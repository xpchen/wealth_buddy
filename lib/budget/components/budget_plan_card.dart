import 'package:flutter/material.dart';

import '../models/budget_category_item.dart';
import 'budget_category_row.dart';

class BudgetPlanCard extends StatelessWidget {
  /// 预算类型标题：例如 '分类支出'
  final String planTitle;

  final VoidCallback? onTapPlanType;
  final VoidCallback? onTapMore;

  final List<BudgetCategoryItem> categories;
  final ValueChanged<BudgetCategoryItem>? onTapCategory;

  const BudgetPlanCard({
    super.key,
    this.planTitle = '分类支出',
    this.onTapPlanType,
    this.onTapMore,
    required this.categories,
    this.onTapCategory,
  });

  @override
  Widget build(BuildContext context) {
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
              onTap: onTapPlanType,
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
                    Text(
                      planTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: onTapMore,
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
            for (final c in categories)
              BudgetCategoryRow(
                item: c,
                onTap: onTapCategory == null ? null : () => onTapCategory!(c),
              ),
          ],
        ),
      ),
    );
  }
}
