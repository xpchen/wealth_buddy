import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../db/db_manager.dart';
import '../db/meta/meta_db.dart';
import '../db/ledger/ledger_db.dart';
import '../db/ledger/seeds/standard_ledger_seed.dart';

class LedgerRef {
  final String ledgerId;
  final String name;
  const LedgerRef(this.ledgerId, this.name);
}

/// App 启动引导：
/// 1) 打开 meta db，找一个未删除账本；没有则创建“标准账本1”
/// 2) 打开对应 ledger db（建表）
/// 3) 写入/更新 ledgerInfo（保证账本库自描述）
/// 4) 运行 StandardLedgerSeeder（账户+分类+图标初始化，且只执行一次）
/// 5) 返回 ledgerId/ledgerName，用 homeBuilder 进入你的首页
class AppBootstrap extends StatelessWidget {
  final Widget Function(String ledgerId, String ledgerName) homeBuilder;
  final Widget? loading;

  const AppBootstrap({super.key, required this.homeBuilder, this.loading});

  Future<LedgerRef> _ensureDefaultLedger() async {
    final meta = await DbManager.instance.meta();

    // 取最近更新的一个未删除账本
    final ledgers =
        await (meta.select(meta.wbLedgers)
              ..where((t) => t.isDeleted.equals(false))
              ..orderBy([
                (t) => drift.OrderingTerm(
                  expression: t.updatedAtMs,
                  mode: drift.OrderingMode.desc,
                ),
              ])
              ..limit(1))
            .get();

    final now = DateTime.now().millisecondsSinceEpoch;

    late final String ledgerId;
    late final String ledgerName;

    if (ledgers.isNotEmpty) {
      ledgerId = ledgers.first.ledgerId;
      ledgerName = ledgers.first.name;
    } else {
      // 创建默认账本
      ledgerId = const Uuid().v4();
      ledgerName = '标准账本1';

      await meta
          .into(meta.wbLedgers)
          .insert(
            WbLedgersCompanion(
              ledgerId: drift.Value(ledgerId),
              name: drift.Value(ledgerName),
              templateCode: const drift.Value('standard_v1'),

              // 你想固定写也可以；如果表有默认值，这里写上也不冲突
              currencyCode: const drift.Value('CNY'),
              timezone: const drift.Value('Asia/Shanghai'),

              dbFilename: drift.Value('ledger_$ledgerId.sqlite'),
              dataDir: const drift.Value<String?>(null),

              createdAtMs: drift.Value(now),
              updatedAtMs: drift.Value(now),
              isDeleted: const drift.Value(false),
            ),
          );
    }

    // 打开并初始化 ledger db（首次会建表）
    final ledgerDb = await DbManager.instance.ledger(ledgerId);

    // 写入/更新 ledgerInfo（账本库自描述）
    await ledgerDb
        .into(ledgerDb.ledgerInfo)
        .insertOnConflictUpdate(
          LedgerInfoCompanion(
            ledgerId: drift.Value(ledgerId),
            name: drift.Value(ledgerName),
            currencyCode: const drift.Value('CNY'),
            timezone: const drift.Value('Asia/Shanghai'),
            createdAtMs: drift.Value(now),
            updatedAtMs: drift.Value(now),
            isDeleted: const drift.Value(false),
          ),
        );

    // 运行完整初始化（账户 + 分类 + 系统图标）
    // seedIfNeeded() 会自行判断是否已初始化，避免重复插入
    await StandardLedgerSeeder(ledgerDb).seedIfNeeded();

    return LedgerRef(ledgerId, ledgerName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LedgerRef>(
      future: _ensureDefaultLedger(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return loading ??
              const Material(child: Center(child: CircularProgressIndicator()));
        }

        if (snap.hasError) {
          return Material(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '初始化失败：${snap.error}',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        }

        final ref = snap.data!;
        return homeBuilder(ref.ledgerId, ref.name);
      },
    );
  }
}
