import 'dart:async';
import 'package:flutter/material.dart';

import '../../flow/flow_time.dart';
import '../../data/db/ledger/ledger_tables.dart';
import '../components/budget_header_summary.dart';
import '../components/budget_plan_card.dart';
import '../components/budget_top_bar.dart';
import '../models/budget_category_item.dart';
import '../data/budget_repo.dart';
import '../utils/budget_time_utils.dart';
import '../widgets/number_keypad.dart';
import 'budget_detail_page.dart';

class BudgetCenterPage extends StatefulWidget {
  final String ledgerId;

  const BudgetCenterPage({
    super.key,
    required this.ledgerId,
  });

  @override
  State<BudgetCenterPage> createState() => _BudgetCenterPageState();
}

class _BudgetCenterPageState extends State<BudgetCenterPage> {
  FlowTimeUnit _periodType = FlowTimeUnit.month;
  late DateTime _currentDate;
  late DateTime _rangeStart;
  late DateTime _rangeEnd;
  
  CategoryType _budgetType = CategoryType.expense; // 默认支出

  // 汇总数据
  double _totalBudget = 0.00;
  double _usedBudget = 0.00;

  // 分类列表
  List<BudgetCategoryItem> _categories = [];
  
  // 存储分类信息（用于跳转详情页）
  final Map<String, CategoryForBudget> _categoryMap = {};

  StreamSubscription<List<CategoryForBudget>>? _categoriesSubscription;
  StreamSubscription<List<CategoryBudgetItem>>? _budgetsSubscription;
  Timer? _statsTimer;
  
  // 编辑总预算相关状态
  bool _keypadVisible = false;
  String _inputAmount = '0.00';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentDate = now;
    _updateDateRange();
    _loadData();
  }

  @override
  void dispose() {
    _categoriesSubscription?.cancel();
    _budgetsSubscription?.cancel();
    _statsTimer?.cancel();
    super.dispose();
  }

  void _updateDateRange() {
    final period = BudgetTimeUtils.formatPeriod(_currentDate, _periodType);
    final range = BudgetTimeUtils.getDateRange(period, _periodType);
    setState(() {
      _rangeStart = range.start;
      _rangeEnd = range.end;
    });
  }

  void _loadData() {
    final period = BudgetTimeUtils.formatPeriod(_currentDate, _periodType);

    // 取消之前的订阅
    _categoriesSubscription?.cancel();
    _budgetsSubscription?.cancel();
    _statsTimer?.cancel();

    // 监听分类列表
    _categoriesSubscription = BudgetRepo.instance
        .watchCategoriesByType(widget.ledgerId, _budgetType)
        .listen((categories) {
      // 保存分类信息
      _categoryMap.clear();
      for (final cat in categories) {
        _categoryMap[cat.categoryId] = cat;
      }
      _loadBudgetData(period, categories);
    });

    // 定期刷新统计数据（每5秒）
    _statsTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _refreshStats(period);
    });

    // 立即刷新一次
    _refreshStats(period);
  }

  Future<void> _loadBudgetData(
      String period, List<CategoryForBudget> categories) async {
    // 监听预算数据
    _budgetsSubscription?.cancel();
    _budgetsSubscription = BudgetRepo.instance
        .watchCategoryBudgets(widget.ledgerId, period)
        .listen((budgets) {
      _updateCategories(categories, budgets, period);
    });
  }

  Future<void> _updateCategories(
    List<CategoryForBudget> categories,
    List<CategoryBudgetItem> budgets,
    String period,
  ) async {
    // 创建预算映射
    final budgetMap = <String, CategoryBudgetItem>{};
    for (final budget in budgets) {
      budgetMap[budget.categoryId] = budget;
    }

    // 构建分类列表（包含预算和支出信息）
    final categoryItems = <BudgetCategoryItem>[];
    for (final category in categories) {
      final budget = budgetMap[category.categoryId];
      final budgetAmountMinor = budget?.budgetAmountMinor ?? 0;

      // 获取实际支出/收入（包含所有子分类的交易）
      final amountMinor = await BudgetRepo.instance.calculateCategoryAmount(
        ledgerId: widget.ledgerId,
        categoryId: category.categoryId, // 这会自动包含所有子分类的交易
        period: period,
        periodType: _periodType,
        transactionType: _budgetType == CategoryType.expense
            ? TxnType.expense
            : TxnType.income,
      );

      // 构建副标题
      String subtitle;
      if (budgetAmountMinor > 0) {
        final typeLabel = _budgetType == CategoryType.expense ? '支出' : '收入';
        subtitle = '$typeLabel预算 ${_formatAmount(budgetAmountMinor)} 元';
      } else {
        final typeLabel = _budgetType == CategoryType.expense ? '支出' : '收入';
        subtitle = '$typeLabel预算 未设置';
      }

      // 构建右侧文案（显示实际支出/收入）
      final typeLabel = _budgetType == CategoryType.expense ? '支出' : '收入';
      final trailingText = '$typeLabel ${_formatAmount(amountMinor)}';

      categoryItems.add(BudgetCategoryItem(
        name: category.name,
        subtitle: subtitle,
        icon: category.icon,
        trailingText: trailingText,
        categoryId: category.categoryId, // 添加ID用于跳转
      ));
    }

    if (mounted) {
      setState(() {
        _categories = categoryItems;
      });
    }
  }

  Future<void> _refreshStats(String period) async {
    final totalBudgetMinor =
        await BudgetRepo.instance.calculateTotalBudget(
      ledgerId: widget.ledgerId,
      month: period, // 兼容接口，实际支持所有时间段
    );

    final totalAmountMinor =
        await BudgetRepo.instance.calculateTotalAmount(
      ledgerId: widget.ledgerId,
      period: period,
      periodType: _periodType,
      transactionType: _budgetType == CategoryType.expense
          ? TxnType.expense
          : TxnType.income,
    );

    if (mounted) {
      setState(() {
        _totalBudget = _minorToYuan(totalBudgetMinor);
        _usedBudget = _minorToYuan(totalAmountMinor);
      });
    }
  }

  /// 将分转换为元
  double _minorToYuan(int minor) => minor / 100.0;

  /// 格式化金额显示
  String _formatAmount(int minor) => _minorToYuan(minor).toStringAsFixed(2);

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      helpText: '选择日期',
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
      _currentDate = picked;
      _updateDateRange();
      _loadData();
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
                  title: '年',
                  selected: _periodType == FlowTimeUnit.year,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = FlowTimeUnit.year);
                    _updateDateRange();
                    _loadData();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '季',
                  selected: _periodType == FlowTimeUnit.quarter,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = FlowTimeUnit.quarter);
                    _updateDateRange();
                    _loadData();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '月',
                  selected: _periodType == FlowTimeUnit.month,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = FlowTimeUnit.month);
                    _updateDateRange();
                    _loadData();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '周',
                  selected: _periodType == FlowTimeUnit.week,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = FlowTimeUnit.week);
                    _updateDateRange();
                    _loadData();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '日',
                  selected: _periodType == FlowTimeUnit.day,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _periodType = FlowTimeUnit.day);
                    _updateDateRange();
                    _loadData();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBudgetTypeSheet() {
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
                  title: '支出',
                  selected: _budgetType == CategoryType.expense,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _budgetType = CategoryType.expense);
                    _loadData();
                  },
                ),
                const Divider(height: 1),
                _sheetItem(
                  title: '收入',
                  selected: _budgetType == CategoryType.income,
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _budgetType = CategoryType.income);
                    _loadData();
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

  void _showEditTotalBudget() {
    setState(() {
      _keypadVisible = true;
      _inputAmount = _totalBudget.toStringAsFixed(2);
    });
  }

  void _hideKeypad() {
    setState(() {
      _keypadVisible = false;
      _inputAmount = '0.00';
    });
  }

  void _onNumberInput(String value) {
    setState(() {
      // 如果输入的是小数点
      if (value == '.') {
        if (!_inputAmount.contains('.')) {
          if (_inputAmount.isEmpty || _inputAmount == '0') {
            _inputAmount = '0.';
          } else {
            _inputAmount += '.';
          }
        }
        return;
      }
      
      if (_inputAmount == '0.00' || _inputAmount == '0') {
        _inputAmount = value;
      } else {
        if (_inputAmount.contains('.')) {
          final parts = _inputAmount.split('.');
          if (parts.length > 1 && parts[1].length >= 2) {
            return;
          }
        }
        _inputAmount += value;
      }
      
      final parts = _inputAmount.split('.');
      if (parts.length > 1 && parts[1].length > 2) {
        _inputAmount = '${parts[0]}.${parts[1].substring(0, 2)}';
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_inputAmount.length > 1) {
        _inputAmount = _inputAmount.substring(0, _inputAmount.length - 1);
      } else {
        _inputAmount = '0';
      }
    });
  }

  void _onClear() {
    setState(() {
      _inputAmount = '0.00';
    });
  }

  Future<void> _onConfirmTotalBudget() async {
    final amount = double.tryParse(_inputAmount) ?? 0.0;
    final amountMinor = (amount * 100).toInt();
    
    final period = BudgetTimeUtils.formatPeriod(_currentDate, _periodType);
    
    // 保存总预算
    await BudgetRepo.instance.upsertBudget(
      ledgerId: widget.ledgerId,
      month: period,
      scopeType: BudgetScopeType.total,
      scopeId: null, // 总预算没有scopeId
      amountMinor: amountMinor,
    );
    
    _hideKeypad();
    
    // 刷新统计数据
    await _refreshStats(period);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('总预算设置成功')),
      );
    }
  }

  void _navigateToDetail(BudgetCategoryItem item) {
    final category = _categoryMap[item.categoryId];
    if (category == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetDetailPage(
          ledgerId: widget.ledgerId,
          categoryId: category.categoryId,
          categoryName: category.name,
          categoryIcon: category.icon,
          periodType: _periodType,
          currentDate: _currentDate,
          budgetType: _budgetType,
        ),
      ),
    ).then((shouldRefresh) {
      // 返回后刷新数据
      if (shouldRefresh == true) {
        final period = BudgetTimeUtils.formatPeriod(_currentDate, _periodType);
        _refreshStats(period);
        // 重新加载所有数据
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final periodLabel = FlowTime.unitLabel(_periodType);
    final budgetTypeLabel = _budgetType == CategoryType.expense ? '支出' : '收入';
    
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
                SliverToBoxAdapter(
                  child: BudgetTopBar(
                    periodTypeLabel: periodLabel,
                    onBack: () => Navigator.maybePop(context),
                    onTapPeriod: _showPeriodSheet,
                  ),
                ),
                SliverToBoxAdapter(
                  child: BudgetHeaderSummary(
                    rangeStart: _rangeStart,
                    rangeEnd: _rangeEnd,
                    totalBudget: _totalBudget,
                    usedBudget: _usedBudget,
                    onTapTotalBudget: _showEditTotalBudget,
                  ),
                ),
                SliverToBoxAdapter(
                  child: BudgetPlanCard(
                    planTitle: '分类$budgetTypeLabel',
                    categories: _categories,
                    onTapPlanType: _showBudgetTypeSheet,
                    onTapMore: () {
                      // 可以添加更多设置选项
                    },
                    onTapCategory: _navigateToDetail,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
          
          // 数字键盘
          if (_keypadVisible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: NumberKeypad(
                value: _inputAmount,
                onInput: _onNumberInput,
                onBackspace: _onBackspace,
                onClear: _onClear,
                onConfirm: _onConfirmTotalBudget,
                onCancel: _hideKeypad,
              ),
            ),
        ],
      ),
    );
  }
}
