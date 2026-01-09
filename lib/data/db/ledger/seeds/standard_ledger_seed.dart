import 'dart:math';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import '../ledger_db.dart';
import '../ledger_tables.dart';

/// 不依赖 uuid 的本地唯一 id（足够用于离线主键）
final _rnd = Random.secure();
String _genId() {
  final ts = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
  final r1 = _rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
  final r2 = _rnd.nextInt(1 << 32).toRadixString(16).padLeft(8, '0');
  return '$ts$r1$r2';
}

/// 标准账本初始化：账户 + 分类（支出/收入）
/// - 账户：全部带系统图标（Material Icons）
/// - 二级分类：全部带系统图标（Material Icons）
class StandardLedgerSeeder {
  final LedgerDb db;
  StandardLedgerSeeder(this.db);

  Future<void> seedIfNeeded() async {
    // 如果已经有账户或分类，就认为已初始化（避免重复插入）
    final hasAccount = await (db.select(db.accounts)..limit(1)).get();
    final hasCategory = await (db.select(db.categories)..limit(1)).get();
    if (hasAccount.isNotEmpty || hasCategory.isNotEmpty) return;

    final now = DateTime.now().millisecondsSinceEpoch;

    // key: codePoint|fontFamily -> iconId
    final iconCache = <String, String>{};

    Future<String> ensureMaterialIcon(IconData icon) async {
      final key = '${icon.codePoint}|${icon.fontFamily ?? 'MaterialIcons'}';
      final cached = iconCache[key];
      if (cached != null) return cached;

      final iconId = _genId();

      await db
          .into(db.iconResources)
          .insert(
            IconResourcesCompanion.insert(
              iconId: iconId,
              source: IconSource.material,

              // nullable columns -> drift.Value<T?>
              codepoint: drift.Value<int?>(icon.codePoint),
              fontFamily: drift.Value<String?>(
                icon.fontFamily ?? 'MaterialIcons',
              ),

              assetPath: const drift.Value<String?>(null),
              mediaId: const drift.Value<String?>(null),
              fgColor: const drift.Value<String?>(null),
              bgColor: const drift.Value<String?>(null),

              createdAtMs: now,
              updatedAtMs: now,
              isDeleted: const drift.Value(false),
            ),
          );

      iconCache[key] = iconId;
      return iconId;
    }

    Future<void> insertAccount({
      required String name,
      required AccountType type,
      required IconData icon,
      int sortOrder = 0, // 当前表没有 sort_order，可忽略
    }) async {
      final iconId = await ensureMaterialIcon(icon);
      await db
          .into(db.accounts)
          .insert(
            AccountsCompanion.insert(
              accountId: _genId(),
              name: name,
              accountType: type,
              currencyCode: drift.Value('CNY'),
              iconId: drift.Value<String?>(iconId),
              initialBalanceMinor: drift.Value(0),
              initialBalanceAtMs: const drift.Value<int?>(null),

              creditLimitMinor: const drift.Value<int?>(null),
              billingDay: const drift.Value<int?>(null),
              repaymentDay: const drift.Value<int?>(null),

              note: const drift.Value<String?>(null),
              isArchived: const drift.Value(false),

              createdAtMs: now,
              updatedAtMs: now,
              isDeleted: const drift.Value(false),
            ),
          );
    }

    Future<String> insertCategoryParent({
      required String name,
      required CategoryType type,
      required int sort,
    }) async {
      final id = _genId();
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              categoryId: id,
              type: type,
              parentId: const drift.Value<String?>(null),
              name: name,

              // 一级可不带图标；二级必须带
              iconId: const drift.Value<String?>(null),

              sortOrder: drift.Value(sort),
              isHidden: const drift.Value(false),
              createdAtMs: now,
              updatedAtMs: now,
              isDeleted: const drift.Value(false),
            ),
          );
      return id;
    }

    Future<void> insertCategoryChild({
      required String parentId,
      required String name,
      required CategoryType type,
      required int sort,
      required IconData icon,
    }) async {
      final iconId = await ensureMaterialIcon(icon);
      await db
          .into(db.categories)
          .insert(
            CategoriesCompanion.insert(
              categoryId: _genId(),
              type: type,
              parentId: drift.Value<String?>(parentId),
              name: name,
              iconId: drift.Value<String?>(iconId),
              sortOrder: drift.Value(sort),
              isHidden: const drift.Value(false),
              createdAtMs: now,
              updatedAtMs: now,
              isDeleted: const drift.Value(false),
            ),
          );
    }

    await db.transaction(() async {
      // -------------------------
      // 账户初始化（全部带系统图标）
      // -------------------------
      await insertAccount(
        name: '现金',
        type: AccountType.cash,
        icon: Icons.account_balance_wallet_outlined,
      );
      await insertAccount(
        name: '银行卡',
        type: AccountType.debitCard,
        icon: Icons.credit_card_outlined,
      );

      await insertAccount(
        name: '微信钱包',
        type: AccountType.ewallet,
        icon: Icons.chat_outlined,
      );
      await insertAccount(
        name: '支付宝余额',
        type: AccountType.ewallet,
        icon: Icons.account_balance_wallet_outlined,
      );

      await insertAccount(
        name: '股票账户',
        type: AccountType.investment,
        icon: Icons.show_chart_outlined,
      );
      await insertAccount(
        name: '基金账户',
        type: AccountType.investment,
        icon: Icons.trending_up_outlined,
      );

      await insertAccount(
        name: '应收款项',
        type: AccountType.other,
        icon: Icons.receipt_long_outlined,
      );
      await insertAccount(
        name: '信用卡',
        type: AccountType.creditCard,
        icon: Icons.credit_card,
      );
      await insertAccount(
        name: '应付款项',
        type: AccountType.loan,
        icon: Icons.request_quote_outlined,
      );

      // -------------------------
      // 支出分类（一级 + 二级；二级必须带系统图标）
      // -------------------------
      int pSort = 0;

      // 食品酒水
      final food = await insertCategoryParent(
        name: '食品酒水',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: food,
        name: '早午晚餐',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.restaurant_outlined,
      );
      await insertCategoryChild(
        parentId: food,
        name: '烟酒茶',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.local_bar_outlined,
      );
      await insertCategoryChild(
        parentId: food,
        name: '水果零食',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.icecream_outlined,
      );

      // 行车交通
      final traffic = await insertCategoryParent(
        name: '行车交通',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: traffic,
        name: '公共交通',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.directions_bus_outlined,
      );
      await insertCategoryChild(
        parentId: traffic,
        name: '打车租车',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.local_taxi_outlined,
      );
      await insertCategoryChild(
        parentId: traffic,
        name: '私家车费用',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.directions_car_outlined,
      );

      // 居家物业
      final home = await insertCategoryParent(
        name: '居家物业',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: home,
        name: '日常用品',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.shopping_bag_outlined,
      );
      await insertCategoryChild(
        parentId: home,
        name: '水电煤气',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.bolt_outlined,
      );
      await insertCategoryChild(
        parentId: home,
        name: '房租',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.home_outlined,
      );
      await insertCategoryChild(
        parentId: home,
        name: '物业管理',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.apartment_outlined,
      );
      await insertCategoryChild(
        parentId: home,
        name: '维修保养',
        type: CategoryType.expense,
        sort: 4,
        icon: Icons.build_outlined,
      );

      // 交流通讯
      final comm = await insertCategoryParent(
        name: '交流通讯',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: comm,
        name: '座机费',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.phone_in_talk_outlined,
      );
      await insertCategoryChild(
        parentId: comm,
        name: '手机费',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.smartphone_outlined,
      );
      await insertCategoryChild(
        parentId: comm,
        name: '上网费',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.wifi_outlined,
      );
      await insertCategoryChild(
        parentId: comm,
        name: '邮寄费',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.local_post_office_outlined,
      );

      // 衣服饰品
      final cloth = await insertCategoryParent(
        name: '衣服饰品',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: cloth,
        name: '衣服裤子',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.checkroom_outlined,
      );
      await insertCategoryChild(
        parentId: cloth,
        name: '鞋帽包包',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.shopping_bag_outlined,
      );
      await insertCategoryChild(
        parentId: cloth,
        name: '化妆饰品',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.brush_outlined,
      );

      // 休闲娱乐
      final fun = await insertCategoryParent(
        name: '休闲娱乐',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: fun,
        name: '运动健身',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.fitness_center_outlined,
      );
      await insertCategoryChild(
        parentId: fun,
        name: '交际聚会',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.groups_outlined,
      );
      await insertCategoryChild(
        parentId: fun,
        name: '休闲玩乐',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.sports_esports_outlined,
      );
      await insertCategoryChild(
        parentId: fun,
        name: '宠物宝贝',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.pets_outlined,
      );
      await insertCategoryChild(
        parentId: fun,
        name: '旅游度假',
        type: CategoryType.expense,
        sort: 4,
        icon: Icons.flight_takeoff_outlined,
      );

      // 医疗保健
      final health = await insertCategoryParent(
        name: '医疗保健',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: health,
        name: '药品费',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.medication_outlined,
      );
      await insertCategoryChild(
        parentId: health,
        name: '保健费',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.favorite_border_outlined,
      );
      await insertCategoryChild(
        parentId: health,
        name: '美容费',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.spa_outlined,
      );
      await insertCategoryChild(
        parentId: health,
        name: '治疗费',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.local_hospital_outlined,
      );

      // 学习进修
      final learn = await insertCategoryParent(
        name: '学习进修',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: learn,
        name: '数码装备',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.devices_outlined,
      );
      await insertCategoryChild(
        parentId: learn,
        name: '书报杂志',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.menu_book_outlined,
      );
      await insertCategoryChild(
        parentId: learn,
        name: '培训进修',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.school_outlined,
      );

      // 人情往来
      final gift = await insertCategoryParent(
        name: '人情往来',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: gift,
        name: '送礼请客',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.card_giftcard_outlined,
      );
      await insertCategoryChild(
        parentId: gift,
        name: '孝敬长辈',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.emoji_people_outlined,
      );
      await insertCategoryChild(
        parentId: gift,
        name: '还人钱物',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.sync_alt_outlined,
      );
      await insertCategoryChild(
        parentId: gift,
        name: '慈善捐助',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.volunteer_activism_outlined,
      );

      // 金融保险
      final fin = await insertCategoryParent(
        name: '金融保险',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '银行手续',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.account_balance_outlined,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '投资亏损',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.trending_down_outlined,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '按揭还款',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.home_outlined,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '消费税收',
        type: CategoryType.expense,
        sort: 3,
        icon: Icons.receipt_outlined,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '利息支出',
        type: CategoryType.expense,
        sort: 4,
        icon: Icons.percent_outlined,
      );
      await insertCategoryChild(
        parentId: fin,
        name: '赔偿罚款',
        type: CategoryType.expense,
        sort: 5,
        icon: Icons.gavel_outlined,
      );

      // 其他杂项
      final other = await insertCategoryParent(
        name: '其他杂项',
        type: CategoryType.expense,
        sort: pSort++,
      );
      await insertCategoryChild(
        parentId: other,
        name: '其他支出',
        type: CategoryType.expense,
        sort: 0,
        icon: Icons.more_horiz_outlined,
      );
      await insertCategoryChild(
        parentId: other,
        name: '意外丢失',
        type: CategoryType.expense,
        sort: 1,
        icon: Icons.report_problem_outlined,
      );
      await insertCategoryChild(
        parentId: other,
        name: '烂账损失',
        type: CategoryType.expense,
        sort: 2,
        icon: Icons.money_off_outlined,
      );

      // -------------------------
      // 收入分类（二级必须带系统图标）
      // -------------------------
      int ip = 0;

      final job = await insertCategoryParent(
        name: '职业收入',
        type: CategoryType.income,
        sort: ip++,
      );
      await insertCategoryChild(
        parentId: job,
        name: '工资收入',
        type: CategoryType.income,
        sort: 0,
        icon: Icons.payments_outlined,
      );
      await insertCategoryChild(
        parentId: job,
        name: '加班收入',
        type: CategoryType.income,
        sort: 1,
        icon: Icons.schedule_outlined,
      );
      await insertCategoryChild(
        parentId: job,
        name: '奖金收入',
        type: CategoryType.income,
        sort: 2,
        icon: Icons.emoji_events_outlined,
      );
      await insertCategoryChild(
        parentId: job,
        name: '兼职收入',
        type: CategoryType.income,
        sort: 3,
        icon: Icons.work_outline,
      );
      await insertCategoryChild(
        parentId: job,
        name: '经营所得',
        type: CategoryType.income,
        sort: 4,
        icon: Icons.store_outlined,
      );

      final inc2 = await insertCategoryParent(
        name: '其他收入',
        type: CategoryType.income,
        sort: ip++,
      );
      await insertCategoryChild(
        parentId: inc2,
        name: '投资收入',
        type: CategoryType.income,
        sort: 0,
        icon: Icons.trending_up_outlined,
      );
      await insertCategoryChild(
        parentId: inc2,
        name: '利息收入',
        type: CategoryType.income,
        sort: 1,
        icon: Icons.savings_outlined,
      );
      await insertCategoryChild(
        parentId: inc2,
        name: '礼金收入',
        type: CategoryType.income,
        sort: 2,
        icon: Icons.card_giftcard_outlined,
      );
      await insertCategoryChild(
        parentId: inc2,
        name: '中奖收入',
        type: CategoryType.income,
        sort: 3,
        icon: Icons.casino_outlined,
      );
      await insertCategoryChild(
        parentId: inc2,
        name: '意外来钱',
        type: CategoryType.income,
        sort: 4,
        icon: Icons.star_outline,
      );
    });
  }
}
