import 'package:flutter/material.dart';

/// 预算中心页头汇总：日期范围 + 总预算 + 已用/可用
class BudgetHeaderSummary extends StatelessWidget {
  final DateTime rangeStart;
  final DateTime rangeEnd;

  /// 元（double），UI层先用 double；后续接库时建议统一 minor units -> 这里再格式化
  final double totalBudget;
  final double usedBudget;
  final VoidCallback? onTapTotalBudget;

  const BudgetHeaderSummary({
    super.key,
    required this.rangeStart,
    required this.rangeEnd,
    required this.totalBudget,
    required this.usedBudget,
    this.onTapTotalBudget,
  });

  double get availableBudget => totalBudget - usedBudget; // 允许负数

  String _fmtDateCN(DateTime d) => '${d.year}年${d.month}月${d.day}日';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_fmtDateCN(rangeStart)}~${_fmtDateCN(rangeEnd)}',
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

          GestureDetector(
            onTap: onTapTotalBudget,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  totalBudget.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 44,
                    height: 1.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                    decoration: onTapTotalBudget != null
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: const Color(0xFF9CA3AF),
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
                if (onTapTotalBudget != null) ...[
                  const SizedBox(width: 6),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _miniStat(label: '已用', value: usedBudget.toStringAsFixed(2)),
              const SizedBox(width: 16),
              Container(width: 1, height: 14, color: const Color(0x556B7280)),
              const SizedBox(width: 16),
              _miniStat(
                label: '可用',
                value: availableBudget.toStringAsFixed(2),
                valueColor: availableBudget < 0
                    ? const Color(0xFFFF3B30)
                    : const Color(0xFF111827),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat({
    required String label,
    required String value,
    Color valueColor = const Color(0xFF111827),
  }) {
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
          style: TextStyle(
            fontSize: 14,
            color: valueColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
