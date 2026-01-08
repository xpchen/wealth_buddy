import 'package:flutter/material.dart';

class BudgetCenterPage extends StatefulWidget {
  const BudgetCenterPage({super.key});

  @override
  State<BudgetCenterPage> createState() => _BudgetCenterPageState();
}

class _BudgetCenterPageState extends State<BudgetCenterPage> {
  String _periodType = '月'; // 可扩展：月/年/周等
  late DateTime _rangeStart;
  late DateTime _rangeEnd;

  // 汇总（先用 0.00，后续你接入预算数据时替换）
  final double _totalBudget = 0.00;
  final double _usedBudget = 0.00;

  final List<_BudgetCategoryItem> _categories = const [
    _BudgetCategoryItem(
      name: '食品酒水',
      subtitle: '支出预算 未设置',
      icon: Icons.local_dining_outlined,
    ),
    _BudgetCategoryItem(
      name: '行车交通',
      subtitle: '支出预算 未设置',
      icon: Icons.directions_car_outlined,
    ),
    _BudgetCategoryItem(
      name: '居家物业',
      subtitle: '支出预算 未设置',
      icon: Icons.apartment_outlined,
    ),
    _BudgetCategoryItem(
      name: '交流通讯',
      subtitle: '支出预算 未设置',
      icon: Icons.wifi_tethering_outlined,
    ),
    _BudgetCategoryItem(
      name: '衣服饰品',
      subtitle: '支出预算 未设置',
      icon: Icons.checkroom_outlined,
    ),
    _BudgetCategoryItem(
      name: '休闲娱乐',
      subtitle: '支出预算 未设置',
      icon: Icons.sports_bar_outlined,
    ),
    _BudgetCategoryItem(
      name: '医疗保健',
      subtitle: '支出预算 未设置',
      icon: Icons.medical_services_outlined,
    ),
    _BudgetCategoryItem(
      name: '学习进修',
      subtitle: '支出预算 未设置',
      icon: Icons.menu_book_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _setMonthRange(now);
  }

  double get _availableBudget =>
      (_totalBudget - _usedBudget).clamp(0, double.infinity);

  void _setMonthRange(DateTime anyDayInMonth) {
    final start = DateTime(anyDayInMonth.year, anyDayInMonth.month, 1);
    final end = DateTime(anyDayInMonth.year, anyDayInMonth.month + 1, 0);
    _rangeStart = start;
    _rangeEnd = end;
  }

  Future<void> _pickMonth() async {
    // 不引入第三方 month_picker：用 showDatePicker 选择任意日期后归整为该月
    final picked = await showDatePicker(
      context: context,
      initialDate: _rangeStart,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      helpText: '选择月份（选中任意日期即可）',
      builder: (context, child) {
        final theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      _setMonthRange(picked);
      // 后续你接入数据时，在这里刷新预算汇总
    });
  }

  void _showPeriodSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 16,
                  offset: Offset(0, 6),
                  color: Color(0x22000000),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _sheetItem(
                  title: '月',
                  selected: _periodType == '月',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = '月');
                    _pickMonth();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '年（预留）',
                  selected: _periodType == '年',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = '年');
                    // 预留：你后续可实现按年范围
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sheetItem({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: selected ? const Icon(Icons.check, size: 20) : null,
      onTap: onTap,
    );
  }

  String _fmtDateCN(DateTime d) => '${d.year}年${d.month}月${d.day}日';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // 顶部渐变背景
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 280,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFE8A6),
                    Color(0xFFFFC7B8),
                    Color(0xFFE6E1FF),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildTopBar(context)),
                SliverToBoxAdapter(child: _buildHeaderSummary()),
                SliverToBoxAdapter(child: _buildBudgetCard(context)),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              const Text(
                '预算中心',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2430),
                ),
              ),
            ],
          ),

          // 中间 “月 ▼”
          InkWell(
            onTap: _showPeriodSheet,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _periodType,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2430),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_fmtDateCN(_rangeStart)}~${_fmtDateCN(_rangeEnd)}',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),

          const Text(
            '支出总预算',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _totalBudget.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 44,
                  height: 1.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 6),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  '元',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _miniStat(label: '已用', value: _usedBudget.toStringAsFixed(2)),
              const SizedBox(width: 16),
              Container(width: 1, height: 14, color: const Color(0x556B7280)),
              const SizedBox(width: 16),
              _miniStat(
                label: '可用',
                value: _availableBudget.toStringAsFixed(2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat({required String label, required String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 6),
              color: Color(0x14000000),
            ),
          ],
        ),
        child: Column(
          children: [
            // 预算类型行
            InkWell(
              onTap: () {
                // TODO: 预算类型设置页面
              },
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    const Text(
                      '预算类型：',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      '分类支出',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // TODO: 更多设置
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: const Color(0xFFF59E0B),
                      ),
                      child: const Text(
                        '更多',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFEDEFF3)),

            // 分类列表
            ..._categories.map((c) => _buildCategoryRow(context, c)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context, _BudgetCategoryItem item) {
    return InkWell(
      onTap: () {
        // TODO：进入分类预算详情/设置页面
        // Navigator.push(...);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: Icon(
                  item.icon,
                  size: 22,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),
            Text(
              '支出 0.00',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
          ],
        ),
      ),
    );
  }
}

class _BudgetCategoryItem {
  final String name;
  final String subtitle;
  final IconData icon;

  const _BudgetCategoryItem({
    required this.name,
    required this.subtitle,
    required this.icon,
  });
}
