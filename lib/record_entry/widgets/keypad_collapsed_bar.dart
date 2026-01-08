import 'package:flutter/material.dart';

class KeypadCollapsedBar extends StatelessWidget {
  final VoidCallback onExpand;

  const KeypadCollapsedBar({super.key, required this.onExpand});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 48,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                size: 26,
                color: Color(0xFF1F2329),
              ),
              onPressed: onExpand,
            ),
          ),
        ),
      ),
    );
  }
}
