import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../data/db/ledger/ledger_db.dart';
import '../data/db/ledger/ledger_tables.dart';
import 'account_money.dart';
import 'account_repo.dart';
import 'account_type_select_page.dart';
import 'account_type_ui.dart';
import 'account_cash_edit_page.dart';

class AccountHomePage extends StatefulWidget {
  final String ledgerId;
  final String? ledgerName;

  const AccountHomePage({super.key, required this.ledgerId, this.ledgerName});

  @override
  State<AccountHomePage> createState() => _AccountHomePageState();
}

class _AccountHomePageState extends State<AccountHomePage> {
  final _repo = AccountRepo.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: StreamBuilder<List<Account>>(
        stream: _repo.watchActiveAccounts(widget.ledgerId),
        builder: (context, snap) {
          final accounts = (snap.data ?? const <Account>[])
              .where((a) => !a.isArchived) // "隐藏" 不展示（后续可做开关）
              .toList();

          final totals = _calcTotals(accounts);

          final sections = _buildSections(accounts);

          return CustomScrollView(
            slivers: [
              _buildHeader(context, totals),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 24),
                  child: Column(
                    children: [
                      for (final s in sections) ...[
                        _AccountSectionCard(
                          title: s.title,
                          rightHint: s.rightHint,
                          items: s.items,
                          onTapItem: (item) => _openEdit(context, item),
                        ),
                        const SizedBox(height: 10),
                      ],
                      if (snap.hasError)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                          child: Text(
                            '加载失败：${snap.error}',
                            style: const TextStyle(color: Color(0xFFFF5B5B)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _HeaderTotals _calcTotals(List<Account> accounts) {
    int assets = 0;
    int liabilities = 0;

    for (final a in accounts) {
      final bal = a.initialBalanceMinor;
      if (!a.includeInTotals) {
        continue; // 不参与统计
      }
      if (isLiabilityAccount(a.accountType)) {
        // 负债：按正数展示更符合用户预期（代表欠款）
        liabilities += bal.abs();
      } else {
        assets += bal;
      }
    }
    final net = assets - liabilities;
    return _HeaderTotals(
      totalAssetsMinor: assets,
      totalLiabilitiesMinor: liabilities,
      netWorthMinor: net,
    );
  }

  List<_SectionVm> _buildSections(List<Account> accounts) {
    final byType = <AccountType, List<Account>>{};
    for (final a in accounts) {
      byType.putIfAbsent(a.accountType, () => <Account>[]).add(a);
    }

    final sections = <_SectionVm>[];

    void addSection(String title, String rightHintPrefix, List<Account> list) {
      if (list.isEmpty) return;
      final sumMinor = list.fold<int>(0, (p, e) => p + (e.initialBalanceMinor));
      final items = list.map(_toRowItem).toList();

      final displaySum = isLiabilityAccount(list.first.accountType)
          ? Money.formatMinor(sumMinor.abs())
          : Money.formatMinor(sumMinor);

      sections.add(
        _SectionVm(
          title: title,
          rightHint: '$rightHintPrefix $displaySum',
          items: items,
        ),
      );
    }

    addSection('现金账户', '资产', byType[AccountType.cash] ?? const []);
    addSection('储蓄账户', '资产', byType[AccountType.debitCard] ?? const []);
    addSection('虚拟账户', '资产', byType[AccountType.ewallet] ?? const []);
    addSection('投资账户', '资产', byType[AccountType.investment] ?? const []);
    addSection('信用账户', '负债', byType[AccountType.creditCard] ?? const []);
    addSection('负债账户', '负债', byType[AccountType.loan] ?? const []);
    addSection('其他账户', '资产', byType[AccountType.other] ?? const []);

    return sections;
  }

  _AccountRowItem _toRowItem(Account a) {
    final ui = accountTypeUi(a.accountType);
    final bal = a.initialBalanceMinor;

    final display = isLiabilityAccount(a.accountType)
        ? Money.formatMinor(bal.abs())
        : Money.formatMinor(bal);

    return _AccountRowItem(
      accountId: a.accountId,
      accountType: a.accountType,
      icon: ui.icon,
      iconBg: ui.iconBg.withOpacity(0.45),
      iconColor: ui.iconColor,
      name: a.name,
      amount: display,
    );
  }

  Future<void> _openEdit(BuildContext context, _AccountRowItem item) async {
    final dbAccount = await _repo.getById(widget.ledgerId, item.accountId);
    if (!context.mounted || dbAccount == null) return;

    final ui = accountTypeUi(dbAccount.accountType);

    await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => CashAccountEditPage(
          ledgerId: widget.ledgerId,
          accountType: dbAccount.accountType,
          pageTitle: '新建${ui.title}账户',
          initial: dbAccount,
        ),
      ),
    );
  }

  SliverAppBar _buildHeader(BuildContext context, _HeaderTotals totals) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 190,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 12,
      title: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const Text(
            '账户',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) =>
                      AccountTypeSelectPage(ledgerId: widget.ledgerId),
                ),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 背景图可自行替换/补齐 assets；缺失时用纯色兜底
            Container(
              decoration: const BoxDecoration(color: Color(0xFF2B2F36)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 88, 16, 16),
              child: _HeaderStats(totals: totals),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderTotals {
  final int totalAssetsMinor;
  final int totalLiabilitiesMinor;
  final int netWorthMinor;

  const _HeaderTotals({
    required this.totalAssetsMinor,
    required this.totalLiabilitiesMinor,
    required this.netWorthMinor,
  });
}

class _HeaderStats extends StatelessWidget {
  final _HeaderTotals totals;

  const _HeaderStats({required this.totals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${Money.formatMinor(totals.netWorthMinor)}  净资产',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              '总资产  ${Money.formatMinor(totals.totalAssetsMinor)}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(width: 14),
            const Text(
              '|',
              style: TextStyle(color: Colors.white38, fontSize: 13),
            ),
            const SizedBox(width: 14),
            Text(
              '总负债  ${Money.formatMinor(totals.totalLiabilitiesMinor)}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionVm {
  final String title;
  final String rightHint;
  final List<_AccountRowItem> items;

  const _SectionVm({
    required this.title,
    required this.rightHint,
    required this.items,
  });
}

class _AccountRowItem {
  final String accountId;
  final AccountType accountType;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String amount;

  const _AccountRowItem({
    required this.accountId,
    required this.accountType,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.amount,
  });
}

class _AccountSectionCard extends StatelessWidget {
  final String title;
  final String rightHint;
  final List<_AccountRowItem> items;
  final ValueChanged<_AccountRowItem> onTapItem;

  const _AccountSectionCard({
    required this.title,
    required this.rightHint,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF222222),
                  ),
                ),
                const Spacer(),
                Text(
                  rightHint,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8F98),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          for (int i = 0; i < items.length; i++) ...[
            _AccountRow(item: items[i], onTap: () => onTapItem(items[i])),
            if (i != items.length - 1)
              const Divider(height: 1, color: Color(0xFFF3F4F6), indent: 66),
          ],
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  final _AccountRowItem item;
  final VoidCallback onTap;

  const _AccountRow({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            Text(
              item.amount,
              style: const TextStyle(fontSize: 16, color: Color(0xFF222222)),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
          ],
        ),
      ),
    );
  }
}
