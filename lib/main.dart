import 'package:flutter/material.dart';

import 'record_entry/record_entry_page.dart';
import 'budget_center_page.dart';
import 'account/account_module.dart';

import 'data/db/db_manager.dart';
import 'data/bootstrap/app_bootstrap.dart';
import 'data/storage/app_paths.dart';

import 'flow/flow_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbManager.instance.init(profileId: 'local');
  await dumpDbPaths();
  runApp(const MyApp());
}

Future<void> dumpDbPaths() async {
  debugPrint('meta:   ${await AppPaths.metaDbPath("local")}');
  debugPrint('media:  ${await AppPaths.mediaDbPath("local")}');
  // 如果你知道 ledgerId：
  // debugPrint('ledger: ${await AppPaths.ledgerDbPath("local", ledgerId)}');
}

/// Demo App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: const Color(0xFFF6F7F9),
        fontFamilyFallback: const [
          'PingFang SC',
          'Microsoft YaHei',
          'Noto Sans CJK SC',
        ],
      ),
      home: AppBootstrap(
        homeBuilder: (ledgerId, ledgerName) =>
            LedgerHomePage(ledgerId: ledgerId, ledgerName: ledgerName),
      ),
    );
  }
}

class LedgerHomePage extends StatefulWidget {
  final String ledgerId;
  final String ledgerName;

  const LedgerHomePage({
    super.key,
    required this.ledgerId,
    required this.ledgerName,
  });

  @override
  State<LedgerHomePage> createState() => _LedgerHomePageState();
}

class _LedgerHomePageState extends State<LedgerHomePage> {
  /// 0 首页 / 1 流水 / 2 报表 / 3 设置
  int _tabIndex = 0;

  // 你可以替换成真实数据
  final double monthExpense = 0.00;
  final double monthIncome = 0.00;
  final double monthBalance = 0.00;

  @override
  Widget build(BuildContext context) {
    final textColor = const Color(0xFF1F2329);
    final subTextColor = const Color(0xFF8A8F99);

    final String title;
    if (_tabIndex == 0) {
      title = widget.ledgerName;
    } else if (_tabIndex == 1) {
      title = '流水';
    } else if (_tabIndex == 2) {
      title = '报表';
    } else {
      title = '设置';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF1F2329),
          ),
          onPressed: () {
            // 你可以按需调整：非首页时返回首页
            if (_tabIndex != 0) setState(() => _tabIndex = 0);
          },
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1F2329),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person,
                  size: 18,
                  color: Color(0xFF8A8F99),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildCenterAddButton(),

      bottomNavigationBar: _buildBottomBar(),

      body: IndexedStack(
        index: _tabIndex,
        children: [
          // 0：首页
          _buildHomeBody(textColor: textColor, subTextColor: subTextColor),

          // 1：流水
          FlowPage(ledgerId: widget.ledgerId),

          // 2：报表（先占位）
          const Center(
            child: Text('报表（待实现）', style: TextStyle(color: Color(0xFF8A8F99))),
          ),

          // 3：设置（先占位）
          const Center(
            child: Text('设置（待实现）', style: TextStyle(color: Color(0xFF8A8F99))),
          ),
        ],
      ),
    );
  }

  // =========================
  // 首页 Body（完整内容）
  // =========================
  Widget _buildHomeBody({
    required Color textColor,
    required Color subTextColor,
  }) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 顶部快捷入口
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ShortcutItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: '账户',
                    bg: const Color(0xFFEAF0FF),
                    iconColor: const Color(0xFF5A7BFF),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AccountHomePage(
                            ledgerId: widget.ledgerId,
                            ledgerName: widget.ledgerName, // 可选
                          ),
                        ),
                      );
                    },
                  ),
                  _ShortcutItem(
                    icon: Icons.pie_chart_outline,
                    label: '预算',
                    bg: const Color(0xFFFFF0E6),
                    iconColor: const Color(0xFFFF8A3D),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BudgetCenterPage(),
                        ),
                      );
                    },
                  ),
                  _ShortcutItem(
                    icon: Icons.receipt_long_outlined,
                    label: '流水',
                    bg: const Color(0xFFEAF6FF),
                    iconColor: const Color(0xFF3B8CFF),
                    onTap: () => setState(() => _tabIndex = 1),
                  ),
                  const _ShortcutItem(
                    icon: Icons.insights_outlined,
                    label: '图表',
                    bg: Color(0xFFE9FBF5),
                    iconColor: Color(0xFF21B68B),
                  ),
                  const _ShortcutItem(
                    icon: Icons.savings_outlined,
                    label: '财富',
                    bg: Color(0xFFFFF6E3),
                    iconColor: Color(0xFFFFB000),
                  ),
                ],
              ),
            ),

            // 本月收支统计大卡片
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: _buildMonthSummaryCard(
                textColor: textColor,
                subTextColor: subTextColor,
              ),
            ),

            // 今天/本周/本年 统计卡片
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: _buildPeriodSummaryCard(),
            ),

            // 本月每日支出统计 + 图表区域（占位）
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '本月每日支出统计',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2329),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 210,
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: const Size(double.infinity, double.infinity),
                            painter: _LineChartPlaceholderPainter(),
                          ),
                          const Positioned(
                            left: 38,
                            top: 14,
                            child: _TooltipBubble(
                              label: '支出',
                              value: '0.00',
                              dotColor: Color(0xFF3DB9B0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSummaryCard({
    required Color textColor,
    required Color subTextColor,
  }) {
    // 为了避免 asset 缺失导致异常：用 Stack + Image.asset(errorBuilder)
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 背景底色/兜底
            Container(color: const Color(0xFFEEF2F6)),

            // 背景图（可选）
            Image.asset(
              'assets/images/month_banner.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),

            // 渐变遮罩，提高文字可读性
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                children: [
                  // 左侧文字数据
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '本月收支统计',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(color: Color(0x66000000), blurRadius: 6),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          '总支出',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              monthExpense.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 44,
                                height: 1.0,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                    color: Color(0x66000000),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white70,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '总收入 ${monthIncome.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Container(
                              width: 1,
                              height: 12,
                              color: Colors.white30,
                            ),
                            const SizedBox(width: 14),
                            Text(
                              '结余 ${monthBalance.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 右上角图标
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSummaryCard() {
    const incomeColor = Color(0xFFFF6B3D); // 橙色（总收入）
    const expenseColor = Color(0xFF2CB7B0); // 青色（总支出）

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          _PeriodRow(
            icon: Icons.calendar_month_outlined,
            iconBg: Color(0xFFE8F6F4),
            iconColor: Color(0xFF2CB7B0),
            title: '今天',
            subtitle: '2026年01月07日',
            income: '0.00',
            expense: '0.00',
            incomeColor: incomeColor,
            expenseColor: expenseColor,
            showDivider: true,
          ),
          _PeriodRow(
            icon: Icons.credit_card_outlined,
            iconBg: Color(0xFFEFF4FF),
            iconColor: Color(0xFF4A7DFF),
            title: '本周',
            subtitle: '01月05日–01月11日',
            income: '0.00',
            expense: '0.00',
            incomeColor: incomeColor,
            expenseColor: expenseColor,
            showDivider: true,
          ),
          _PeriodRow(
            icon: Icons.currency_yen_outlined,
            iconBg: Color(0xFFFFF5E5),
            iconColor: Color(0xFFFFB000),
            title: '本年',
            subtitle: '2026年',
            income: '0.00',
            expense: '0.00',
            incomeColor: incomeColor,
            expenseColor: expenseColor,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCenterAddButton() {
    return SizedBox(
      width: 64,
      height: 64,
      child: FloatingActionButton(
        elevation: 2,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RecordEntryPage(ledgerId: widget.ledgerId),
            ),
          );
        },
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFC2A8), Color(0xFFFF8B62)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.add, size: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    // 中间“+”按钮占位，左右各两个
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomItem(
              label: '首页',
              icon: Icons.home_outlined,
              selected: _tabIndex == 0,
              onTap: () => setState(() => _tabIndex = 0),
            ),
            _BottomItem(
              label: '流水',
              icon: Icons.receipt_long_outlined,
              selected: _tabIndex == 1,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FlowPage(ledgerId: widget.ledgerId),
                  ),
                );
              },
            ),
            const SizedBox(width: 44),
            _BottomItem(
              label: '报表',
              icon: Icons.insert_chart_outlined,
              selected: _tabIndex == 2,
              onTap: () => setState(() => _tabIndex = 2),
            ),
            _BottomItem(
              label: '设置',
              icon: Icons.settings_outlined,
              selected: _tabIndex == 3,
              onTap: () => setState(() => _tabIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortcutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color iconColor;
  final VoidCallback? onTap;

  const _ShortcutItem({
    required this.icon,
    required this.label,
    required this.bg,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 62,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1F2329),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeriodRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String income;
  final String expense;
  final Color incomeColor;
  final Color expenseColor;
  final bool showDivider;

  const _PeriodRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.income,
    required this.expense,
    required this.incomeColor,
    required this.expenseColor,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2329),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8F99),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    '总收入 ',
                    style: TextStyle(fontSize: 12, color: Color(0xFF8A8F99)),
                  ),
                  Text(
                    income,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: incomeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Text(
                    '总支出 ',
                    style: TextStyle(fontSize: 12, color: Color(0xFF8A8F99)),
                  ),
                  Text(
                    expense,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: expenseColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    if (!showDivider) return row;

    return Column(
      children: [
        row,
        const Divider(
          height: 1,
          thickness: 1,
          indent: 64,
          endIndent: 14,
          color: Color(0xFFF0F2F5),
        ),
      ],
    );
  }
}

class _BottomItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFFFF7A4D) : const Color(0xFF1F2329);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TooltipBubble extends StatelessWidget {
  final String label;
  final String value;
  final Color dotColor;

  const _TooltipBubble({
    required this.label,
    required this.value,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2F3136),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 简单的折线图占位：网格 + 两条淡线（对应截图下方淡淡的折线）
class _LineChartPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFEFF1F4)
      ..strokeWidth = 1;

    // 横向网格线
    for (int i = 0; i < 4; i++) {
      final y = size.height * (0.18 + i * 0.22);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 中间竖线
    final midX = size.width * 0.28;
    final midLine = Paint()
      ..color = const Color(0xFFD7DCE2)
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(midX, 10), Offset(midX, size.height - 10), midLine);

    // 2 条淡折线
    _drawLine(canvas, size, const Color(0x552CB7B0), 0.52);
    _drawLine(canvas, size, const Color(0x55FF6B3D), 0.62);

    // 底部粗线
    final base = Paint()
      ..color = const Color(0xFF2CB7B0)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final baseY = size.height * 0.78;
    canvas.drawLine(Offset(10, baseY), Offset(size.width - 10, baseY), base);

    // 指示点
    canvas.drawCircle(Offset(midX, baseY), 7, Paint()..color = Colors.white);
    canvas.drawCircle(
      Offset(midX, baseY),
      4.5,
      Paint()..color = const Color(0xFF2CB7B0),
    );
  }

  void _drawLine(Canvas canvas, Size size, Color color, double phase) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = <Offset>[
      Offset(size.width * 0.05, size.height * (0.55 + 0.08 * phase)),
      Offset(size.width * 0.18, size.height * (0.30 + 0.10 * phase)),
      Offset(size.width * 0.32, size.height * (0.58 - 0.05 * phase)),
      Offset(size.width * 0.48, size.height * (0.40 + 0.06 * phase)),
      Offset(size.width * 0.64, size.height * (0.62 - 0.07 * phase)),
      Offset(size.width * 0.82, size.height * (0.45 + 0.05 * phase)),
      Offset(size.width * 0.95, size.height * (0.52 - 0.03 * phase)),
    ];

    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
