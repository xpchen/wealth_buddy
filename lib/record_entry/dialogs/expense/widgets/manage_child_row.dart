import 'package:flutter/material.dart';
import '../../../category/models/category_models.dart';

class ManageChildRow extends StatelessWidget {
  final CategoryItem item;
  final bool enableReorder;
  final VoidCallback onEdit;

  const ManageChildRow({
    super.key,
    required this.item,
    required this.enableReorder,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(item.icon),
          const SizedBox(width: 10),
          Expanded(
            child: Text(item.name, style: const TextStyle(fontSize: 14)),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 20),
          ),
          if (enableReorder)
            const Icon(Icons.drag_handle_rounded, color: Colors.black54),
        ],
      ),
    );
  }
}
