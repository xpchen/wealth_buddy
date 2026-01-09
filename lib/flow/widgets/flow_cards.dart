import 'package:flutter/material.dart';

class FlowNoticeBanner extends StatelessWidget {
  final String text;
  final VoidCallback? onClose;
  final VoidCallback? onView;

  const FlowNoticeBanner({
    super.key,
    required this.text,
    this.onClose,
    this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(999),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close, size: 16, color: Color(0xFF8A8F99)),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.calendar_today, size: 16, color: Color(0xFFB76E5A)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF1F2329),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onView,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                '查看 >',
                style: TextStyle(
                  color: Color(0xFFB76E5A),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowAccountSummaryCard extends StatelessWidget {
  final String accountName;
  final double netIn;
  final double inAmount;
  final double outAmount;
  final VoidCallback? onTap;

  const FlowAccountSummaryCard({
    super.key,
    required this.accountName,
    required this.netIn,
    required this.inAmount,
    required this.outAmount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                accountName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2329),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text(
                      '净流入 ',
                      style: TextStyle(color: Color(0xFF8A8F99), fontSize: 12),
                    ),
                    Text(
                      netIn.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Color(0xFF1F2329),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '流入 ${inAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF8A8F99),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '|',
                      style: TextStyle(color: Color(0xFFE1E4E8), fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '流出 ${outAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF8A8F99),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.keyboard_arrow_up,
                color: Color(0xFF8A8F99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
