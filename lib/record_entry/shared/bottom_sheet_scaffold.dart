import 'package:flutter/material.dart';

class BottomSheetScaffold extends StatelessWidget {
  final Widget child;
  final double heightFactor;
  final Color backgroundColor;

  const BottomSheetScaffold({
    super.key,
    required this.child,
    this.heightFactor = 0.92,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: child,
      ),
    );
  }
}
