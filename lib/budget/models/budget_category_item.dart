import 'package:flutter/material.dart';

/// 预算中心：分类行数据模型
class BudgetCategoryItem {
  final String name;
  final String subtitle;
  final IconData icon;

  /// 右侧展示文案，例如：'支出 0.00'
  final String trailingText;
  
  /// 分类ID（用于跳转到详情页）
  final String? categoryId;

  const BudgetCategoryItem({
    required this.name,
    required this.subtitle,
    required this.icon,
    this.trailingText = '支出 0.00',
    this.categoryId,
  });
}
