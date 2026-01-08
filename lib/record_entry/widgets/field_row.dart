import 'package:flutter/material.dart';

class FieldRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;
  final VoidCallback onTap;
  final Widget? trailing;

  const FieldRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    this.valueColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    const textMain = Color(0xFF1F2329);
    const textSub = Color(0xFF8A8F99);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFFB0B6BF)),
            const SizedBox(width: 12),
            SizedBox(
              width: 44,
              child: Text(
                title,
                style: const TextStyle(color: textSub, fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor ?? textMain,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
