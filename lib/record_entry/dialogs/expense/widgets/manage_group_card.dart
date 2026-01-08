import 'package:flutter/material.dart';

import '../../../category/models/category_models.dart';
import 'manage_child_row.dart';

class ManageGroupCard extends StatelessWidget {
  final CategoryGroup group;
  final bool enableReorder;
  final bool enableCreate;

  final VoidCallback onEditGroup;
  final ValueChanged<CategoryItem> onEditChild;
  final VoidCallback onCreateChild;

  const ManageGroupCard({
    super.key,
    required this.group,
    required this.enableReorder,
    required this.enableCreate,
    required this.onEditGroup,
    required this.onEditChild,
    required this.onCreateChild,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(14),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Icon(group.icon),
          title: Text(
            group.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEditGroup,
                icon: const Icon(Icons.edit_outlined, size: 20),
              ),
              if (enableReorder)
                const Icon(Icons.drag_handle_rounded, color: Colors.black54),
            ],
          ),
          children: [
            ...group.children.map(
              (c) => ManageChildRow(
                item: c,
                enableReorder: enableReorder,
                onEdit: () => onEditChild(c),
              ),
            ),
            if (enableCreate)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton.icon(
                  onPressed: onCreateChild,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('新建二级分类'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
