import 'package:flutter/material.dart';

/// 预算中心顶部栏：返回 + 标题 + 周期选择
class BudgetTopBar extends StatelessWidget {
  final String title;
  final String periodTypeLabel;
  final VoidCallback onBack;
  final VoidCallback onTapPeriod;

  const BudgetTopBar({
    super.key,
    this.title = '预算中心',
    required this.periodTypeLabel,
    required this.onBack,
    required this.onTapPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2430),
                ),
              ),
            ],
          ),

          // 中间 “月 ▼”
          InkWell(
            onTap: onTapPeriod,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    periodTypeLabel,
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
}
