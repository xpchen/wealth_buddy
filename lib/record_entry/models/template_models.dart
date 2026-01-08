enum TemplateType { expense, income, transfer }

class TemplateItem {
  final String id;
  final TemplateType type;
  final String name;
  final String accountName;
  final String amountText; // 展示用：0.00
  final String? categoryPath;

  const TemplateItem({
    required this.id,
    required this.type,
    required this.name,
    required this.accountName,
    required this.amountText,
    this.categoryPath,
  });

  TemplateItem copyWith({
    TemplateType? type,
    String? name,
    String? accountName,
    String? amountText,
    String? categoryPath,
  }) {
    return TemplateItem(
      id: id,
      type: type ?? this.type,
      name: name ?? this.name,
      accountName: accountName ?? this.accountName,
      amountText: amountText ?? this.amountText,
      categoryPath: categoryPath ?? this.categoryPath,
    );
  }
}
