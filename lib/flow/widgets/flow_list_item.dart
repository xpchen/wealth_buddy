import 'package:flutter/material.dart';
import '../models/flow_models.dart';

class FlowListItem extends StatelessWidget {
  final FlowRecord record;
  final VoidCallback? onTap;

  const FlowListItem({super.key, required this.record, this.onTap});

  @override
  Widget build(BuildContext context) {
    final (icon, iconBg, iconColor) = _iconStyle(record.type);
    final (sign, amountColor) = _amountStyle(record.type);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2329),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.subTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A8F99),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$sign${record.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: amountColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  (IconData, Color, Color) _iconStyle(FlowType t) {
    switch (t) {
      case FlowType.income:
        return (
          Icons.add_circle_outline,
          const Color(0xFFFFF1EA),
          const Color(0xFFFF6B3D),
        );
      case FlowType.expense:
        return (
          Icons.remove_circle_outline,
          const Color(0xFFE8F6F4),
          const Color(0xFF2CB7B0),
        );
      case FlowType.transfer:
        return (
          Icons.swap_horiz,
          const Color(0xFFEFF4FF),
          const Color(0xFF4A7DFF),
        );
      case FlowType.balanceAdjust:
        return (
          Icons.currency_exchange,
          const Color(0xFFF0F2F5),
          const Color(0xFF8A8F99),
        );
    }
  }

  (String, Color) _amountStyle(FlowType t) {
    switch (t) {
      case FlowType.income:
        return ('+', const Color(0xFFFF6B3D));
      case FlowType.expense:
        return ('-', const Color(0xFF2CB7B0));
      case FlowType.transfer:
        return ('', const Color(0xFF1F2329));
      case FlowType.balanceAdjust:
        return ('', const Color(0xFF1F2329));
    }
  }
}
