import 'package:flutter/material.dart';

class CategoryGroup {
  final String id;
  final String name;
  final IconData icon;
  final List<CategoryItem> children;

  const CategoryGroup({
    required this.id,
    required this.name,
    required this.icon,
    required this.children,
  });
}

class CategoryItem {
  final String id;
  final String name;
  final IconData icon;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
  });
}
