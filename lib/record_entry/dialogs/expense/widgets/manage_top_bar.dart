import 'package:flutter/material.dart';

class ManageTopBar extends StatelessWidget {
  final String title;
  final bool enableSearch;
  final VoidCallback onClose;
  final VoidCallback? onSearch;

  const ManageTopBar({
    super.key,
    required this.title,
    required this.enableSearch,
    required this.onClose,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (enableSearch)
            IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search_rounded),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }
}
