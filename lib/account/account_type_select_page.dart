import 'package:flutter/material.dart';
import 'account_cash_edit_page.dart';

class AccountTypeSelectPage extends StatelessWidget {
  const AccountTypeSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_AccountTypeItem>[
      _AccountTypeItem(
        title: '现金',
        subtitle: '现金账户',
        icon: Icons.payments_outlined,
        iconBg: const Color(0xFFFFF3E8),
        iconColor: const Color(0xFFFF8A3D),
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const CashAccountEditPage())),
      ),
      _AccountTypeItem(
        title: '信用卡',
        subtitle: '蚂蚁花呗、京东白条也可以记在这里哦',
        icon: Icons.credit_card_outlined,
        iconBg: const Color(0xFFEFF3FF),
        iconColor: const Color(0xFF4C6FFF),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '储蓄卡',
        subtitle: '储蓄卡账户',
        icon: Icons.account_balance_outlined,
        iconBg: const Color(0xFFE8F8F6),
        iconColor: const Color(0xFF1FB7A6),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '基金账户',
        subtitle: '基金账户',
        icon: Icons.bar_chart_outlined,
        iconBg: const Color(0xFFFFECEB),
        iconColor: const Color(0xFFED6A5A),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '股票账户',
        subtitle: '股票账户',
        icon: Icons.show_chart_outlined,
        iconBg: const Color(0xFFFFF1E6),
        iconColor: const Color(0xFFFF8A3D),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '一般投资产品',
        subtitle: '银行理财',
        icon: Icons.trending_up_outlined,
        iconBg: const Color(0xFFEAF6FF),
        iconColor: const Color(0xFF2693FF),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '虚拟账户',
        subtitle: '支付宝、微信钱包、饭卡、公交卡',
        icon: Icons.wallet_outlined,
        iconBg: const Color(0xFFEDEBFF),
        iconColor: const Color(0xFF6A5AE0),
        onTap: () => _toastPlaceholder(context),
        showExpandHint: true,
      ),
      _AccountTypeItem(
        title: '负债账户',
        subtitle: '负债账户',
        icon: Icons.south_west_outlined,
        iconBg: const Color(0xFFFFF0F0),
        iconColor: const Color(0xFFE84D4D),
        onTap: () => _toastPlaceholder(context),
      ),
      _AccountTypeItem(
        title: '债权账户',
        subtitle: '债权账户',
        icon: Icons.north_east_outlined,
        iconBg: const Color(0xFFE7F6EF),
        iconColor: const Color(0xFF2BB673),
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
          '新建账户',
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
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) =>
              const Divider(height: 1, color: Color(0xFFF0F1F3), indent: 66),
          itemBuilder: (context, index) => _AccountTypeTile(item: items[index]),
        ),
      ),
    );
  }

  static void _toastPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('该类型页面稍后补齐（当前先完成 UI 框架）')));
  }
}

class _AccountTypeItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;
  final bool showExpandHint;

  _AccountTypeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
    this.showExpandHint = false,
  });
}

class _AccountTypeTile extends StatelessWidget {
  final _AccountTypeItem item;

  const _AccountTypeTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      fontSize: 12.5,
                      color: Color(0xFF9AA1A8),
                    ),
                  ),
                ],
              ),
            ),
            if (item.showExpandHint)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFB8BEC6),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: SizedBox(width: 24),
              ),
          ],
        ),
      ),
    );
  }
}
