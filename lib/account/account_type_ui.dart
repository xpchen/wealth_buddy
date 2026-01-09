import 'package:flutter/material.dart';

import '../data/db/ledger/ledger_tables.dart';

class AccountTypeUi {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color accent;

  const AccountTypeUi({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.accent,
  });
}

AccountTypeUi accountTypeUi(AccountType type) {
  switch (type) {
    case AccountType.cash:
      return const AccountTypeUi(
        title: '现金',
        subtitle: '现金账户',
        icon: Icons.payments_outlined,
        iconBg: Color(0xFFFFF3E8),
        iconColor: Color(0xFFFF8A3D),
        accent: Color(0xFFFF8A3D),
      );
    case AccountType.creditCard:
      return const AccountTypeUi(
        title: '信用卡',
        subtitle: '蚂蚁花呗、京东白条也可以记在这里哦',
        icon: Icons.credit_card_outlined,
        iconBg: Color(0xFFEFF3FF),
        iconColor: Color(0xFF4C6FFF),
        accent: Color(0xFF4C6FFF),
      );
    case AccountType.debitCard:
      return const AccountTypeUi(
        title: '储蓄卡',
        subtitle: '储蓄卡账户',
        icon: Icons.account_balance_outlined,
        iconBg: Color(0xFFE8F8F6),
        iconColor: Color(0xFF1FB7A6),
        accent: Color(0xFF1FB7A6),
      );
    case AccountType.ewallet:
      return const AccountTypeUi(
        title: '虚拟账户',
        subtitle: '支付宝、微信、余额等',
        icon: Icons.account_balance_wallet_outlined,
        iconBg: Color(0xFFEDEBFF),
        iconColor: Color(0xFF6A5AE0),
        accent: Color(0xFF6A5AE0),
      );
    case AccountType.investment:
      return const AccountTypeUi(
        title: '投资账户',
        subtitle: '基金、股票、理财等',
        icon: Icons.show_chart_outlined,
        iconBg: Color(0xFFFFF1E6),
        iconColor: Color(0xFFFF8A3D),
        accent: Color(0xFFFF8A3D),
      );
    case AccountType.loan:
      return const AccountTypeUi(
        title: '负债',
        subtitle: '借款、贷款等',
        icon: Icons.request_quote_outlined,
        iconBg: Color(0xFFFFE8E8),
        iconColor: Color(0xFFFF5B5B),
        accent: Color(0xFFFF5B5B),
      );
    case AccountType.other:
      return const AccountTypeUi(
        title: '其他',
        subtitle: '其他类型账户',
        icon: Icons.more_horiz_outlined,
        iconBg: Color(0xFFF1F2F4),
        iconColor: Color(0xFF6B7280),
        accent: Color(0xFF6B7280),
      );
  }
}

bool isLiabilityAccount(AccountType type) {
  return type == AccountType.creditCard || type == AccountType.loan;
}
