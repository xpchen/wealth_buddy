import 'package:flutter/material.dart';
import 'account_type_select_page.dart';

class AccountHomePage extends StatelessWidget {
  const AccountHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 24),
              child: Column(
                children: const [
                  _AccountSectionCard(
                    title: '现金账户',
                    rightHint: '资产 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.payments_outlined,
                        iconBg: Color(0xFFE7F6EF),
                        iconColor: Color(0xFF2BB673),
                        name: '现金',
                        amount: '0.00',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _AccountSectionCard(
                    title: '储蓄账户',
                    rightHint: '资产 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.account_balance_outlined,
                        iconBg: Color(0xFFE8F8F6),
                        iconColor: Color(0xFF1FB7A6),
                        name: '银行卡',
                        amount: '0.00',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _AccountSectionCard(
                    title: '虚拟账户',
                    rightHint: '资产 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.chat_bubble_outline,
                        iconBg: Color(0xFFEDEBFF),
                        iconColor: Color(0xFF6A5AE0),
                        name: '微信钱包',
                        amount: '0.00',
                      ),
                      _AccountRowData(
                        icon: Icons.qr_code_2_outlined,
                        iconBg: Color(0xFFE7F3FF),
                        iconColor: Color(0xFF2B7DE9),
                        name: '支付宝余额',
                        amount: '0.00',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _AccountSectionCard(
                    title: '投资账户',
                    rightHint: '资产 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.show_chart_outlined,
                        iconBg: Color(0xFFFFF1E6),
                        iconColor: Color(0xFFFF8A3D),
                        name: '股票账户',
                        amount: '0.00',
                      ),
                      _AccountRowData(
                        icon: Icons.bar_chart_outlined,
                        iconBg: Color(0xFFFFECEB),
                        iconColor: Color(0xFFED6A5A),
                        name: '基金账户',
                        amount: '0.00',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _AccountSectionCard(
                    title: '债权账户',
                    rightHint: '资产 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.receipt_long_outlined,
                        iconBg: Color(0xFFEAF6FF),
                        iconColor: Color(0xFF2693FF),
                        name: '应收款项',
                        amount: '0.00',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _AccountSectionCard(
                    title: '信用账户',
                    rightHint: '负债 0.00',
                    items: [
                      _AccountRowData(
                        icon: Icons.credit_card_outlined,
                        iconBg: Color(0xFFEFF3FF),
                        iconColor: Color(0xFF4C6FFF),
                        name: '信用卡',
                        amount: '0.00',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildHeader(BuildContext context) {
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
            onPressed: () {
              // TODO: 搜索
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AccountTypeSelectPage(),
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
            // 你可以换成资产图片：AssetImage('assets/images/account_header.jpg')
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2F6),
                image: const DecorationImage(
                  // 如果你没有这张图，运行不受影响：会走 onError 用渐变/底色占位
                  image: AssetImage('images/account_header.png'),
                  fit: BoxFit.cover,
                  onError: null,
                ),
              ),
            ),
            // 顶部蒙层让文字更清晰
            Container(color: Colors.black.withOpacity(0.10)),
            Positioned(
              left: 16,
              bottom: 48,
              right: 16,
              child: _HeaderSummary(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '0.00  净资产',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text(
              '总资产  0.00',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            SizedBox(width: 14),
            Text('|', style: TextStyle(color: Colors.white38)),
            SizedBox(width: 14),
            Text(
              '总负债  0.00',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }
}

class _AccountSectionCard extends StatelessWidget {
  final String title;
  final String rightHint;
  final List<_AccountRowData> items;

  const _AccountSectionCard({
    required this.title,
    required this.rightHint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const Spacer(),
                Text(
                  rightHint,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9AA1A8),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          for (int i = 0; i < items.length; i++) ...[
            _AccountRow(item: items[i]),
            if (i != items.length - 1)
              const Divider(height: 1, color: Color(0xFFF3F4F6), indent: 66),
          ],
        ],
      ),
    );
  }
}

class _AccountRowData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final String amount;

  const _AccountRowData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.amount,
  });
}

class _AccountRow extends StatelessWidget {
  final _AccountRowData item;

  const _AccountRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: 进入账户详情
      },
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
