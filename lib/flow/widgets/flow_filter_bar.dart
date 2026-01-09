import 'package:flutter/material.dart';

class FlowFilterBar extends StatelessWidget {
  final VoidCallback? onTime;
  final VoidCallback? onCategory;
  final VoidCallback? onAccount;
  final VoidCallback? onProject;
  final VoidCallback? onMore;

  const FlowFilterBar({
    super.key,
    this.onTime,
    this.onCategory,
    this.onAccount,
    this.onProject,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item('时间', onTime),
            _item('分类', onCategory),
            _item('账户', onAccount, highlight: true),
            _item('项目', onProject),
            _item('其它', onMore),
          ],
        ),
      ),
    );
  }

  Widget _item(String label, VoidCallback? onTap, {bool highlight = false}) {
    final color = highlight ? const Color(0xFFFFB000) : const Color(0xFF8A8F99);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, color: color),
          ],
        ),
      ),
    );
  }
}
