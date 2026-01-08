import 'package:flutter/material.dart';

class CategoryIconPickerPage extends StatelessWidget {
  final IconData initial;

  const CategoryIconPickerPage({super.key, required this.initial});

  static const _icons = <IconData>[
    Icons.receipt_long_outlined,
    Icons.fastfood_outlined,
    Icons.directions_car_outlined,
    Icons.home_outlined,
    Icons.shopping_bag_outlined,
    Icons.school_outlined,
    Icons.local_hospital_outlined,
    Icons.sports_esports_outlined,
    Icons.card_giftcard_outlined,
    Icons.pets_outlined,
    Icons.flight_outlined,
    Icons.work_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '选择图标',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: _icons.length,
        itemBuilder: (_, i) {
          final icon = _icons[i];
          final selected = icon == initial;
          return InkWell(
            onTap: () => Navigator.of(context).pop(icon),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFFFF4EA)
                    : const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon),
            ),
          );
        },
      ),
    );
  }
}
