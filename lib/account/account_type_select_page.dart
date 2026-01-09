import 'package:flutter/material.dart';

import '../data/db/ledger/ledger_tables.dart';
import 'account_cash_edit_page.dart';
import 'account_type_ui.dart';

class AccountTypeSelectPage extends StatelessWidget {
  final String ledgerId;

  const AccountTypeSelectPage({
    super.key,
    this.ledgerId = 'default',
  });

  @override
  Widget build(BuildContext context) {
    // 目前仅现金已接入编辑页；其他类型后续可复用同一个编辑页，或拆分为各自编辑页。
    final items = <_AccountTypeItem>[
      _item(
        context,
        type: AccountType.cash,
        onTap: () => _openEdit(context, AccountType.cash),
      ),
      _item(
        context,
        type: AccountType.creditCard,
        onTap: () => _toastPlaceholder(context),
      ),
      _item(
        context,
        type: AccountType.debitCard,
        onTap: () => _toastPlaceholder(context),
      ),
      _item(
        context,
        type: AccountType.ewallet,
        onTap: () => _toastPlaceholder(context),
      ),
      _item(
        context,
        type: AccountType.investment,
        onTap: () => _toastPlaceholder(context),
      ),
      _item(
        context,
        type: AccountType.loan,
        onTap: () => _toastPlaceholder(context),
      ),
      _item(
        context,
        type: AccountType.other,
        onTap: () => _toastPlaceholder(context),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '选择账户类型',
          style: TextStyle(
            color: Color(0xFF222222),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF222222)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        itemBuilder: (_, i) => _AccountTypeTile(item: items[i]),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: items.length,
      ),
    );
  }

  _AccountTypeItem _item(
    BuildContext context, {
    required AccountType type,
    required VoidCallback onTap,
  }) {
    final ui = accountTypeUi(type);
    return _AccountTypeItem(
      title: ui.title,
      subtitle: ui.subtitle,
      icon: ui.icon,
      iconBg: ui.iconBg,
      iconColor: ui.iconColor,
      onTap: onTap,
    );
  }

  Future<void> _openEdit(BuildContext context, AccountType type) async {
    final ui = accountTypeUi(type);
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => CashAccountEditPage(
          ledgerId: ledgerId,
          accountType: type,
          pageTitle: '新建${ui.title}账户',
        ),
      ),
    );
    if (ok == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void _toastPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('该类型编辑页即将上线，先用“现金”体验数据库接入。')),
    );
  }
}

class _AccountTypeItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;

  const _AccountTypeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });
}

class _AccountTypeTile extends StatelessWidget {
  final _AccountTypeItem item;
  const _AccountTypeTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A8F98),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
            ],
          ),
        ),
      ),
    );
  }
}
