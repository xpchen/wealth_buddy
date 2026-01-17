import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import '../../flow/flow_time.dart';
import '../../data/db/ledger/ledger_tables.dart';
import '../data/budget_repo.dart';
import '../utils/budget_time_utils.dart';
import '../widgets/number_keypad.dart';

/// 预算详情页面 - 用于设置一级和二级分类的预算
class BudgetDetailPage extends StatefulWidget {
  final String ledgerId;
  final String categoryId;
  final String categoryName;
  final IconData categoryIcon;
  final FlowTimeUnit periodType;
  final DateTime currentDate;
  final CategoryType budgetType; // 支出或收入

  const BudgetDetailPage({
    super.key,
    required this.ledgerId,
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.periodType,
    required this.currentDate,
    required this.budgetType,
  });

  @override
  State<BudgetDetailPage> createState() => _BudgetDetailPageState();
}

class _BudgetDetailPageState extends State<BudgetDetailPage> {
  String _inputAmount = '0.00';
  bool _keypadVisible = false;
  
  // 一级分类预算
  int? _parentBudgetMinor;
  
  // 二级分类列表及其预算
  List<SubCategoryBudget> _subCategories = [];
  
  // 当前编辑的二级分类ID（如果正在编辑二级分类）
  String? _editingSubCategoryId;

  @override
  void initState() {
    super.initState();
    _loadBudgetData();
  }

  Future<void> _loadBudgetData() async {
    final period = BudgetTimeUtils.formatPeriod(
      widget.currentDate,
      widget.periodType,
    );

    // 先加载二级分类列表和预算
    await _loadSubCategories(period);
    
    // 如果二级分类有预算，计算一级分类预算（所有二级分类预算的总和）
    final hasSubCategoryBudget = _subCategories.any((c) => c.budgetMinor != null && c.budgetMinor! > 0);
    
    if (hasSubCategoryBudget) {
      // 如果二级分类有预算，计算总和作为一级分类预算
      final totalSubBudget = _subCategories.fold<int>(
        0,
        (sum, cat) => sum + (cat.budgetMinor ?? 0),
      );
      
      if (mounted) {
        setState(() {
          _parentBudgetMinor = totalSubBudget;
        });
      }
    } else {
      // 如果二级分类没有预算，加载一级分类预算
      final parentBudget = await BudgetRepo.instance.getBudgetByScope(
        ledgerId: widget.ledgerId,
        month: period, // 兼容旧接口，实际支持所有时间段
        scopeType: BudgetScopeType.category,
        scopeId: widget.categoryId,
      );
      
      if (mounted) {
        setState(() {
          _parentBudgetMinor = parentBudget?.amountMinor;
          if (_parentBudgetMinor != null) {
            _inputAmount = (_parentBudgetMinor! / 100.0).toStringAsFixed(2);
          }
        });
      }
    }
  }

  Future<void> _loadSubCategories(String period) async {
    // 获取所有二级分类
    final db = await BudgetRepo.instance.db(widget.ledgerId);
    final categories = db.categories;
    final iconResources = db.iconResources;

      final joinQ = db.select(categories).join([
        drift.leftOuterJoin(
          iconResources,
          iconResources.iconId.equalsExp(categories.iconId),
        ),
      ])
        ..where(
          categories.isDeleted.equals(false) &
              categories.isHidden.equals(false) &
              categories.type.equals(widget.budgetType.name) &
              categories.parentId.equals(widget.categoryId),
        )
        ..orderBy([
          drift.OrderingTerm.asc(categories.sortOrder),
          drift.OrderingTerm.asc(categories.name),
        ]);

    final rows = await joinQ.get();
    
    // 加载每个二级分类的预算
    final subCategories = <SubCategoryBudget>[];
    for (final row in rows) {
      final category = row.readTable(categories);
      final iconRes = row.readTableOrNull(iconResources);

      IconData icon = Icons.category_outlined;
      if (iconRes != null &&
          iconRes.source == IconSource.material &&
          iconRes.codepoint != null) {
        icon = IconData(
          iconRes.codepoint!,
          fontFamily: iconRes.fontFamily ?? 'MaterialIcons',
        );
      }

      // 查询该二级分类的预算
      final budget = await BudgetRepo.instance.getBudgetByScope(
        ledgerId: widget.ledgerId,
        month: period,
        scopeType: BudgetScopeType.category,
        scopeId: category.categoryId,
      );

      subCategories.add(SubCategoryBudget(
        categoryId: category.categoryId,
        name: category.name,
        icon: icon,
        budgetMinor: budget?.amountMinor,
      ));
    }

    if (mounted) {
      setState(() {
        _subCategories = subCategories;
      });
    }
  }

  void _showKeypad({String? subCategoryId}) {
    setState(() {
      _keypadVisible = true;
      _editingSubCategoryId = subCategoryId;
      
      if (subCategoryId != null) {
        // 编辑二级分类
        final subCat = _subCategories.firstWhere(
          (c) => c.categoryId == subCategoryId,
          orElse: () => SubCategoryBudget(
            categoryId: subCategoryId,
            name: '',
            icon: Icons.category_outlined,
            budgetMinor: null,
          ),
        );
        if (subCat.budgetMinor != null) {
          _inputAmount = (subCat.budgetMinor! / 100.0).toStringAsFixed(2);
        } else {
          _inputAmount = '0.00';
        }
      } else {
        // 编辑一级分类（显示计算后的总和或原值）
        final displayValue = _calculateParentBudget();
        if (displayValue != null && displayValue > 0) {
          _inputAmount = (displayValue / 100.0).toStringAsFixed(2);
        } else {
          _inputAmount = '0.00';
        }
      }
    });
  }

  void _hideKeypad() {
    setState(() {
      _keypadVisible = false;
      _editingSubCategoryId = null;
    });
  }

  void _onNumberInput(String value) {
    setState(() {
      // 如果输入的是小数点
      if (value == '.') {
        if (!_inputAmount.contains('.')) {
          // 如果还没有小数点，直接添加
          if (_inputAmount.isEmpty || _inputAmount == '0') {
            _inputAmount = '0.';
          } else {
            _inputAmount += '.';
          }
        }
        return;
      }
      
      // 如果当前是 '0.00' 或 '0'，替换为新数字
      if (_inputAmount == '0.00' || _inputAmount == '0') {
        _inputAmount = value;
      } else {
        // 检查是否已经有小数点
        if (_inputAmount.contains('.')) {
          final parts = _inputAmount.split('.');
          // 如果小数部分已经有2位，不能再输入
          if (parts.length > 1 && parts[1].length >= 2) {
            return;
          }
        }
        _inputAmount += value;
      }
      
      // 限制小数位数为2位
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

  Future<void> _onConfirm() async {
    final amount = double.tryParse(_inputAmount) ?? 0.0;
    final amountMinor = (amount * 100).toInt();
    
    final period = BudgetTimeUtils.formatPeriod(
      widget.currentDate,
      widget.periodType,
    );

    if (_editingSubCategoryId != null) {
      // 保存二级分类预算
      await BudgetRepo.instance.upsertBudget(
        ledgerId: widget.ledgerId,
        month: period,
        scopeType: BudgetScopeType.category,
        scopeId: _editingSubCategoryId,
        amountMinor: amountMinor,
      );
      
      // 更新本地状态
      setState(() {
        final index = _subCategories.indexWhere(
          (c) => c.categoryId == _editingSubCategoryId,
        );
        if (index >= 0) {
          _subCategories[index] = SubCategoryBudget(
            categoryId: _subCategories[index].categoryId,
            name: _subCategories[index].name,
            icon: _subCategories[index].icon,
            budgetMinor: amountMinor,
          );
        }
        
        // 更新后重新计算一级分类预算（所有二级分类预算的总和）
        final totalSubBudget = _subCategories.fold<int>(
          0,
          (sum, cat) => sum + (cat.budgetMinor ?? 0),
        );
        _parentBudgetMinor = totalSubBudget;
      });
    } else {
      // 保存一级分类预算
      await BudgetRepo.instance.upsertBudget(
        ledgerId: widget.ledgerId,
        month: period,
        scopeType: BudgetScopeType.category,
        scopeId: widget.categoryId,
        amountMinor: amountMinor,
      );
      
      setState(() {
        _parentBudgetMinor = amountMinor;
        // 如果二级分类有预算，需要重新计算一级分类预算显示
      });
    }

    _hideKeypad();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('预算设置成功')),
      );
    }
  }

  String _formatBudget(int? minor) {
    if (minor == null) return '未设置';
    return '${(minor / 100.0).toStringAsFixed(2)} 元';
  }

  /// 计算一级分类预算（如果二级分类有预算，返回总和；否则返回一级分类预算）
  int? _calculateParentBudget() {
    final hasSubCategoryBudget = _subCategories.any((c) => c.budgetMinor != null && c.budgetMinor! > 0);
    
    if (hasSubCategoryBudget) {
      // 如果二级分类有预算，返回所有二级分类预算的总和
      return _subCategories.fold<int>(
        0,
        (sum, cat) => sum + (cat.budgetMinor ?? 0),
      );
    } else {
      // 如果没有二级分类预算，返回一级分类预算
      return _parentBudgetMinor;
    }
  }

  /// 构建一级分类预算的副标题
  String _buildBudgetSubtitle() {
    final budgetTypeLabel = widget.budgetType == CategoryType.expense ? '支出' : '收入';
    final calculatedBudget = _calculateParentBudget();
    return '$budgetTypeLabel预算 ${_formatBudget(calculatedBudget)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Color(0xFF1F2430), // 与标题文字颜色一致
          ),
          onPressed: () {
            // 返回时通知父页面刷新数据
            Navigator.of(context).pop(true);
          },
        ),
        title: const Text(
          '二级分类预算',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2430),
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // 主内容
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: _keypadVisible ? 400 : 16, // 键盘显示时添加底部padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 一级分类预算卡片
                _buildParentCategoryCard(),
                
                // 二级分类列表（如果有二级分类）
                if (_subCategories.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  // 二级分类列表
                  ..._subCategories.map((subCat) => _buildSubCategoryCard(subCat)),
                ],
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
                onConfirm: _onConfirm,
                onCancel: _hideKeypad,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildParentCategoryCard() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _showKeypad(),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.categoryIcon,
                  size: 24,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoryName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _buildBudgetSubtitle(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubCategoryCard(SubCategoryBudget subCat) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _showKeypad(subCategoryId: subCat.categoryId),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  subCat.icon,
                  size: 20,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subCat.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    _formatBudget(subCat.budgetMinor),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFBDBDBD)),
            ],
          ),
        ),
      ),
    );
  }
}

class SubCategoryBudget {
  final String categoryId;
  final String name;
  final IconData icon;
  final int? budgetMinor;

  SubCategoryBudget({
    required this.categoryId,
    required this.name,
    required this.icon,
    this.budgetMinor,
  });
}
