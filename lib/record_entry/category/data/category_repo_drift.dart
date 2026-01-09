import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import 'category_repository.dart';
import '../models/category_models.dart';

// 这里路径按你的工程结构调整：record_entry 在 lib/record_entry，db 在 lib/data/db
import '../../../data/db/db_manager.dart';
import '../../../data/db/ledger/ledger_db.dart';
import '../../../data/db/ledger/ledger_tables.dart';

class CategoryRepoDrift implements CategoryRepository {
  final String ledgerId;
  const CategoryRepoDrift({required this.ledgerId});

  Future<LedgerDb> _db() => DbManager.instance.ledger(ledgerId);

  @override
  Future<List<CategoryGroup>> listExpenseGroups() =>
      _listCategoryGroups(CategoryType.expense);

  @override
  Future<List<CategoryGroup>> listIncomeGroups() =>
      _listCategoryGroups(CategoryType.income);

  @override
  Future<List<CategoryGroup>> listTransferGroups() => _listAccountGroups();

  // -------------------------
  // 分类：支出 / 收入
  // -------------------------
  Future<List<CategoryGroup>> _listCategoryGroups(CategoryType type) async {
    final db = await _db();

    // 1) 一级分类
    final parents =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.isHidden.equals(false) &
                    _eqCategoryType(t, type) &
                    t.parentId.isNull(),
              )
              ..orderBy([
                (t) => drift.OrderingTerm(expression: t.sortOrder),
                (t) => drift.OrderingTerm(expression: t.name),
              ]))
            .get();

    if (parents.isEmpty) return const [];

    final parentIds = parents.map((e) => e.categoryId).toList();

    // 2) 二级分类
    final children =
        await (db.select(db.categories)
              ..where(
                (t) =>
                    t.isDeleted.equals(false) &
                    t.isHidden.equals(false) &
                    _eqCategoryType(t, type) &
                    t.parentId.isIn(parentIds),
              )
              ..orderBy([
                (t) => drift.OrderingTerm(expression: t.sortOrder),
                (t) => drift.OrderingTerm(expression: t.name),
              ]))
            .get();

    final childrenByParent = <String, List<Category>>{};
    for (final c in children) {
      final pid = c.parentId;
      if (pid == null) continue;
      (childrenByParent[pid] ??= []).add(c);
    }

    // 3) 图标：一次性批量取 iconResources
    final iconIds = <String>{};
    for (final p in parents) {
      if (p.iconId != null) iconIds.add(p.iconId!);
    }
    for (final c in children) {
      if (c.iconId != null) iconIds.add(c.iconId!);
    }
    final iconMap = await _loadIcons(db, iconIds);

    // 4) 组装成 UI 模型
    final result = <CategoryGroup>[];
    for (final p in parents) {
      final kids = childrenByParent[p.categoryId] ?? const [];

      final childItems = kids.map((c) {
        return CategoryItem(
          id: c.categoryId,
          name: c.name,
          icon: _iconOf(iconMap, c.iconId, fallback: Icons.category_outlined),
        );
      }).toList();

      // 左侧一级图标：优先用一级 icon；没有则用第一个二级 icon；再没有用默认
      final groupIcon = (p.iconId != null)
          ? _iconOf(iconMap, p.iconId, fallback: Icons.category_outlined)
          : (childItems.isNotEmpty
                ? childItems.first.icon
                : Icons.category_outlined);

      result.add(
        CategoryGroup(
          id: p.categoryId,
          name: p.name,
          icon: groupIcon,
          children: childItems,
        ),
      );
    }

    return result;
  }

  // -------------------------
  // 转账：账户分组
  // -------------------------
  Future<List<CategoryGroup>> _listAccountGroups() async {
    final db = await _db();

    final accounts =
        await (db.select(db.accounts)
              ..where(
                (t) => t.isDeleted.equals(false) & t.isArchived.equals(false),
              )
              ..orderBy([
                (t) => drift.OrderingTerm(expression: t.sortOrder),
                (t) => drift.OrderingTerm(expression: t.name),
              ]))
            .get();

    if (accounts.isEmpty) return const [];

    final iconIds = <String>{};
    for (final a in accounts) {
      if (a.iconId != null) iconIds.add(a.iconId!);
    }
    final iconMap = await _loadIcons(db, iconIds);

    // 分组
    final byType = <AccountType, List<Account>>{};
    for (final a in accounts) {
      (byType[a.accountType] ??= []).add(a);
    }

    final orderedTypes = <AccountType>[
      AccountType.cash,
      AccountType.debitCard,
      AccountType.creditCard,
      AccountType.ewallet,
      AccountType.investment,
      AccountType.loan,
      AccountType.other,
    ];

    final result = <CategoryGroup>[];
    for (final t in orderedTypes) {
      final list = byType[t];
      if (list == null || list.isEmpty) continue;

      final children = list.map((a) {
        final displayName = '${a.name} (${a.currencyCode})';
        return CategoryItem(
          id: a.accountId,
          name: displayName,
          icon: _iconOf(iconMap, a.iconId, fallback: _defaultAccountIcon(t)),
        );
      }).toList();

      result.add(
        CategoryGroup(
          id: t.name,
          name: _accountTypeLabel(t),
          icon: _defaultAccountIcon(t),
          children: children,
        ),
      );
    }

    return result;
  }

  // -------------------------
  // Icon helpers
  // -------------------------
  Future<Map<String, IconData>> _loadIcons(
    LedgerDb db,
    Set<String> iconIds,
  ) async {
    if (iconIds.isEmpty) return const {};

    final rows =
        await (db.select(db.iconResources)..where(
              (t) =>
                  t.isDeleted.equals(false) & t.iconId.isIn(iconIds.toList()),
            ))
            .get();

    final map = <String, IconData>{};
    for (final r in rows) {
      // 目前 Seeder 都是 material
      if (r.source == IconSource.material && r.codepoint != null) {
        map[r.iconId] = IconData(
          r.codepoint!,
          fontFamily: r.fontFamily ?? 'MaterialIcons',
        );
      } else {
        map[r.iconId] = Icons.image_outlined;
      }
    }
    return map;
  }

  IconData _iconOf(
    Map<String, IconData> iconMap,
    String? iconId, {
    required IconData fallback,
  }) {
    if (iconId == null) return fallback;
    return iconMap[iconId] ?? fallback;
  }

  IconData _defaultAccountIcon(AccountType t) {
    switch (t) {
      case AccountType.cash:
        return Icons.account_balance_wallet_outlined;
      case AccountType.debitCard:
        return Icons.account_balance_outlined;
      case AccountType.creditCard:
        return Icons.credit_card_outlined;
      case AccountType.ewallet:
        return Icons.payment_outlined;
      case AccountType.investment:
        return Icons.trending_up_outlined;
      case AccountType.loan:
        return Icons.request_quote_outlined;
      case AccountType.other:
        return Icons.category_outlined;
    }
  }

  String _accountTypeLabel(AccountType t) {
    switch (t) {
      case AccountType.cash:
        return '现金账户';
      case AccountType.debitCard:
        return '储蓄卡';
      case AccountType.creditCard:
        return '信用卡';
      case AccountType.ewallet:
        return '电子钱包';
      case AccountType.investment:
        return '投资账户';
      case AccountType.loan:
        return '借贷账户';
      case AccountType.other:
        return '其他账户';
    }
  }

  // 关键：兼容你当前 “type 是 enum 或 String” 的两种情况
  // 你如果 drift 映射正确（EnumNameConverter），用 t.type.equals(type)
  // 如果你现在还是 String 列，就把下面这一行改成：t.type.equals(type.name)
  drift.Expression<bool> _eqCategoryType(Categories t, CategoryType type) {
    // 默认按“已映射 enum”的写法
    return t.type.equals(type.name);
  }
}
