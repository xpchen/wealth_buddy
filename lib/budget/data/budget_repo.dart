import 'dart:math';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../data/db/db_manager.dart';
import '../../data/db/ledger/ledger_db.dart';
import '../../data/db/ledger/ledger_tables.dart';
import '../../flow/flow_time.dart';
import '../utils/budget_time_utils.dart';

/// 预算数据访问层
class BudgetRepo {
  BudgetRepo._();
  static final instance = BudgetRepo._();

  /// 获取数据库实例（公开以供外部使用）
  Future<LedgerDb> _db(String ledgerId) => DbManager.instance.ledger(ledgerId);
  
  // 公开_db方法以供外部访问（如detail page）
  Future<LedgerDb> db(String ledgerId) => _db(ledgerId);

  /// 生成唯一ID
  String _genId() {
    final rnd = Random.secure();
    final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    final r1 = rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
    final r2 = rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
    return '$ts$r1$r2';
  }

  /// 解析月份：'YYYY-MM' -> DateTime (该月第一天)
  DateTime _parseMonth(String month) {
    final parts = month.split('-');
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
  }

  // =========================
  // 查询方法
  // =========================

  /// 查询指定月份的预算列表（Stream，用于响应式更新）
  Stream<List<BudgetPlan>> watchBudgetsForMonth(
    String ledgerId,
    String month, // 'YYYY-MM'
  ) {
    return Stream.fromFuture(_db(ledgerId)).asyncExpand((db) {
      final q = db.select(db.budgetPlans)
        ..where((t) =>
            t.month.equals(month) &
            t.isDeleted.equals(false))
        ..orderBy([
          (t) => OrderingTerm.asc(t.scopeType),
          (t) => OrderingTerm.asc(t.createdAtMs),
        ]);
      return q.watch();
    });
  }

  /// 查询指定范围类型的预算
  Future<BudgetPlan?> getBudgetByScope({
    required String ledgerId,
    required String month, // 'YYYY-MM'
    required BudgetScopeType scopeType,
    String? scopeId, // total时为空，category/account时为对应ID
  }) async {
    final db = await _db(ledgerId);
    final q = db.select(db.budgetPlans)
      ..where((t) =>
          t.month.equals(month) &
          t.scopeType.equals(scopeType.name) &
          t.isDeleted.equals(false));

    if (scopeType == BudgetScopeType.total) {
      q.where((t) => t.scopeId.isNull());
    } else if (scopeId != null) {
      q.where((t) => t.scopeId.equals(scopeId));
    } else {
      return null;
    }

    q.limit(1);
    return q.getSingleOrNull();
  }

  /// 查询分类预算列表（带分类信息）
  Stream<List<CategoryBudgetItem>> watchCategoryBudgets(
    String ledgerId,
    String month, // 'YYYY-MM'
  ) {
    return Stream.fromFuture(_db(ledgerId)).asyncExpand((db) {
      final budgets = db.budgetPlans;
      final categories = db.categories;
      final iconResources = db.iconResources;

      // Join查询：预算 + 分类 + 图标
      final joinQ = db.select(budgets).join([
        leftOuterJoin(
          categories,
          categories.categoryId.equalsExp(budgets.scopeId),
        ),
        leftOuterJoin(
          iconResources,
          iconResources.iconId.equalsExp(categories.iconId),
        ),
      ])
        ..where(
          budgets.month.equals(month) &
              budgets.scopeType.equals(BudgetScopeType.category.name) &
              budgets.isDeleted.equals(false),
        )
        ..orderBy([
          OrderingTerm.asc(categories.sortOrder),
          OrderingTerm.asc(categories.name),
        ]);

      return joinQ.watch().map((rows) {
        return rows.map((row) {
          final budget = row.readTable(budgets);
          final category = row.readTableOrNull(categories);
          final iconRes = row.readTableOrNull(iconResources);

          IconData icon = Icons.category_outlined;
          if (iconRes != null &&
              iconRes.source == IconSource.material &&
              iconRes.codepoint != null) {
            icon = IconData(
              iconRes.codepoint!,
              fontFamily: iconRes.fontFamily ?? 'MaterialIcons',
            );
          }

          return CategoryBudgetItem(
            budgetId: budget.budgetId,
            categoryId: budget.scopeId ?? '',
            categoryName: category?.name ?? '未知分类',
            icon: icon,
            budgetAmountMinor: budget.amountMinor,
            rolloverRule: budget.rolloverRule,
            note: budget.note,
          );
        }).toList();
      });
    });
  }

  /// 计算指定分类在指定月份的实际支出（从交易表统计）
  Future<int> calculateCategoryExpense({
    required String ledgerId,
    required String? categoryId,
    required String month, // 'YYYY-MM'
  }) async {
    // 兼容旧接口，使用月份格式
    final monthDate = _parseMonth(month);
    final monthStartMs = monthDate.millisecondsSinceEpoch;
    final monthEndMs = DateTime(monthDate.year, monthDate.month + 1, 1)
        .millisecondsSinceEpoch;

    return calculateCategoryAmount(
      ledgerId: ledgerId,
      categoryId: categoryId,
      period: month,
      periodType: null, // 使用默认月份解析
      transactionType: TxnType.expense,
      startMs: monthStartMs,
      endMs: monthEndMs,
    );
  }

  /// 计算指定分类在指定时间段的实际金额（从交易表统计）
  /// 如果是一级分类，会包含所有子分类的交易
  Future<int> calculateCategoryAmount({
    required String ledgerId,
    required String? categoryId,
    required String period,
    FlowTimeUnit? periodType, // 如果提供，使用BudgetTimeUtils解析
    required TxnType transactionType,
    int? startMs, // 如果提供，直接使用
    int? endMs, // 如果提供，直接使用
  }) async {
    final db = await _db(ledgerId);
    
    int rangeStartMs, rangeEndMs;
    if (startMs != null && endMs != null) {
      rangeStartMs = startMs;
      rangeEndMs = endMs;
    } else if (periodType != null) {
      // 使用BudgetTimeUtils解析时间段
      final range = BudgetTimeUtils.getDateRange(period, periodType);
      rangeStartMs = range.start.millisecondsSinceEpoch;
      rangeEndMs = range.end.millisecondsSinceEpoch;
    } else {
      // 默认按月份解析（兼容旧接口）
      final monthDate = _parseMonth(period);
      rangeStartMs = monthDate.millisecondsSinceEpoch;
      rangeEndMs = DateTime(monthDate.year, monthDate.month + 1, 1)
          .millisecondsSinceEpoch;
    }

    final txns = db.txns;

    // 查询交易
    final sumExpr = txns.amountMinor.sum();
    final query = db.selectOnly(txns)
      ..addColumns([sumExpr])
      ..where(
        txns.txnType.equals(transactionType.name) &
            txns.status.equals(TxnStatus.posted.name) &
            txns.isDeleted.equals(false) &
            txns.occurredAtMs.isBiggerOrEqualValue(rangeStartMs) &
            txns.occurredAtMs.isSmallerThanValue(rangeEndMs),
      );

    if (categoryId != null && categoryId.isNotEmpty) {
      // 获取该分类的所有子分类ID（包括自己）
      final categoryIds = await _getCategoryIdsWithChildren(db, categoryId);
      
      if (categoryIds.isNotEmpty) {
        query.where(txns.categoryId.isIn(categoryIds));
      } else {
        // 如果没有找到分类，返回0
        return 0;
      }
    }

    final result = await query.getSingle();
    final sumValue = result.read(sumExpr);
    return sumValue ?? 0;
  }

  /// 获取分类及其所有子分类的ID列表（包括自己）
  Future<List<String>> _getCategoryIdsWithChildren(
    LedgerDb db,
    String categoryId,
  ) async {
    final result = <String>[categoryId];
    final categories = db.categories;
    
    // 查询所有子分类（parentId = categoryId）
    final subCategories = await (db.select(categories)
          ..where(
            (t) => t.isDeleted.equals(false) &
                t.parentId.equals(categoryId),
          ))
        .get();
    
    // 递归获取子分类的子分类
    for (final subCat in subCategories) {
      final subIds = await _getCategoryIdsWithChildren(db, subCat.categoryId);
      result.addAll(subIds);
    }
    
    return result;
  }

  /// 计算总预算（指定月份所有分类预算之和）
  Future<int> calculateTotalBudget({
    required String ledgerId,
    required String month, // 'YYYY-MM'
  }) async {
    final db = await _db(ledgerId);

    // 先查总预算（scopeType=total）
    final totalBudget = await getBudgetByScope(
      ledgerId: ledgerId,
      month: month,
      scopeType: BudgetScopeType.total,
    );

    if (totalBudget != null) {
      return totalBudget.amountMinor;
    }

    // 如果没有总预算，则汇总所有分类预算
    final sumExpr = db.budgetPlans.amountMinor.sum();
    final q = db.selectOnly(db.budgetPlans)
      ..addColumns([sumExpr])
      ..where(
        db.budgetPlans.month.equals(month) &
            db.budgetPlans.scopeType.equals(BudgetScopeType.category.name) &
            db.budgetPlans.isDeleted.equals(false),
      );

    final result = await q.getSingle();
    final sumValue = result.read(sumExpr);
    return sumValue ?? 0;
  }

  /// 计算总支出（指定月份所有支出交易之和）
  Future<int> calculateTotalExpense({
    required String ledgerId,
    required String month, // 'YYYY-MM'
  }) async {
    return calculateCategoryExpense(
      ledgerId: ledgerId,
      categoryId: null, // null表示所有分类
      month: month,
    );
  }

  /// 计算总金额（指定时间段所有交易之和）
  Future<int> calculateTotalAmount({
    required String ledgerId,
    required String period,
    required FlowTimeUnit periodType,
    required TxnType transactionType,
  }) async {
    return calculateCategoryAmount(
      ledgerId: ledgerId,
      categoryId: null, // null表示所有分类
      period: period,
      periodType: periodType,
      transactionType: transactionType,
    );
  }

  /// 获取所有支出分类（一级分类，用于显示预算列表）
  Stream<List<CategoryForBudget>> watchExpenseCategories(String ledgerId) {
    return watchCategoriesByType(ledgerId, CategoryType.expense);
  }

  /// 获取指定类型的分类（一级分类，用于显示预算列表）
  Stream<List<CategoryForBudget>> watchCategoriesByType(
      String ledgerId, CategoryType categoryType) {
    return Stream.fromFuture(_db(ledgerId)).asyncExpand((db) {
      final categories = db.categories;
      final iconResources = db.iconResources;

      final joinQ = db.select(categories).join([
        leftOuterJoin(
          iconResources,
          iconResources.iconId.equalsExp(categories.iconId),
        ),
      ])
        ..where(
          categories.isDeleted.equals(false) &
              categories.isHidden.equals(false) &
              categories.type.equals(categoryType.name) &
              categories.parentId.isNull(), // 只取一级分类
        )
        ..orderBy([
          OrderingTerm.asc(categories.sortOrder),
          OrderingTerm.asc(categories.name),
        ]);

      return joinQ.watch().map((rows) {
        return rows.map((row) {
          final category = row.readTable(categories);
          final iconRes = row.readTableOrNull(iconResources);

          IconData icon = Icons.category_outlined;
          if (iconRes != null &&
              iconRes.source == IconSource.material &&
              iconRes.codepoint != null) {
            icon = IconData(
              iconRes.codepoint!,
              fontFamily: iconRes.fontFamily ?? 'MaterialIcons',
            );
          }

          return CategoryForBudget(
            categoryId: category.categoryId,
            name: category.name,
            icon: icon,
          );
        }).toList();
      });
    });
  }

  // =========================
  // 创建/更新/删除方法
  // =========================

  /// 创建或更新预算
  Future<String> upsertBudget({
    required String ledgerId,
    required String month, // 'YYYY-MM'
    required BudgetScopeType scopeType,
    String? scopeId, // total时为空，category/account时为对应ID
    required int amountMinor, // 金额（分）
    RolloverRule rolloverRule = RolloverRule.none,
    String? note,
    String? existingBudgetId, // 如果提供，则更新；否则创建新预算
  }) async {
    final db = await _db(ledgerId);
    final now = DateTime.now().millisecondsSinceEpoch;

    final budgetId = existingBudgetId ?? _genId();

    // 检查是否已存在
    final existing = await getBudgetByScope(
      ledgerId: ledgerId,
      month: month,
      scopeType: scopeType,
      scopeId: scopeId,
    );

    if (existing != null && existing.budgetId != budgetId) {
      // 已存在其他预算，更新它
      await (db.update(db.budgetPlans)
            ..where((t) => t.budgetId.equals(existing.budgetId)))
          .write(
        BudgetPlansCompanion(
          amountMinor: Value(amountMinor),
          rolloverRule: Value(rolloverRule),
          note: Value<String?>(note),
          updatedAtMs: Value(now),
        ),
      );
      return existing.budgetId;
    } else {
      // 创建新预算或更新指定ID的预算
      await db.into(db.budgetPlans).insertOnConflictUpdate(
        BudgetPlansCompanion.insert(
          budgetId: budgetId,
          month: month,
          scopeType: scopeType,
          scopeId: Value<String?>(scopeId),
          amountMinor: amountMinor,
          rolloverRule: Value(rolloverRule),
          note: Value<String?>(note),
          createdAtMs: now,
          updatedAtMs: now,
          isDeleted: const Value(false),
        ),
      );
      return budgetId;
    }
  }

  /// 删除预算（软删除）
  Future<void> deleteBudget(String ledgerId, String budgetId) async {
    final db = await _db(ledgerId);
    final now = DateTime.now().millisecondsSinceEpoch;

    await (db.update(db.budgetPlans)..where((t) => t.budgetId.equals(budgetId)))
        .write(
      BudgetPlansCompanion(
        isDeleted: const Value(true),
        updatedAtMs: Value(now),
      ),
    );
  }
}

/// 分类预算项（UI模型）
class CategoryBudgetItem {
  final String budgetId;
  final String categoryId;
  final String categoryName;
  final IconData icon;
  final int budgetAmountMinor; // 预算金额（分）
  final RolloverRule rolloverRule;
  final String? note;

  CategoryBudgetItem({
    required this.budgetId,
    required this.categoryId,
    required this.categoryName,
    required this.icon,
    required this.budgetAmountMinor,
    required this.rolloverRule,
    this.note,
  });
}

/// 分类信息（用于预算列表）
class CategoryForBudget {
  final String categoryId;
  final String name;
  final IconData icon;

  CategoryForBudget({
    required this.categoryId,
    required this.name,
    required this.icon,
  });
}