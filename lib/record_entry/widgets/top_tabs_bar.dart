import 'package:flutter/material.dart';

class TopTabsBar extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final ValueChanged<int> onTap;

  const TopTabsBar({
    super.key,
    required this.tabs,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const textMain = Color(0xFF1F2329);
    const textSub = Color(0xFF8A8F99);
    const orange = Color(0xFFFF8B62);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (i) {
            final selected = i == index;
            return InkWell(
              onTap: () => onTap(i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    Text(
                      tabs[i],
                      style: TextStyle(
                        fontSize: selected ? 18 : 16,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected ? textMain : textSub,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: selected ? 18 : 0,
                      height: 4,
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
