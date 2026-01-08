import '../models/template_models.dart';

class TemplateMemoryRepo {
  TemplateMemoryRepo._();

  static final instance = TemplateMemoryRepo._();

  final List<TemplateItem> _items = [
    const TemplateItem(
      id: 't1',
      type: TemplateType.expense,
      name: '每日餐费',
      accountName: '现金',
      amountText: '0.00',
      categoryPath: '食品酒水 > 早午晚餐',
    ),
    const TemplateItem(
      id: 't2',
      type: TemplateType.expense,
      name: '每月房租',
      accountName: '银行卡',
      amountText: '0.00',
      categoryPath: '居家生活 > 房租',
    ),
    const TemplateItem(
      id: 't3',
      type: TemplateType.income,
      name: '每月工资收入',
      accountName: '银行卡',
      amountText: '0.00',
      categoryPath: '工资收入',
    ),
  ];

  List<TemplateItem> listByType(TemplateType type) {
    return _items.where((e) => e.type == type).toList();
  }

  List<TemplateItem> listAll() => List.unmodifiable(_items);

  void upsert(TemplateItem item) {
    final idx = _items.indexWhere((e) => e.id == item.id);
    if (idx >= 0) {
      _items[idx] = item;
    } else {
      _items.insert(0, item);
    }
  }

  void deleteByIds(Set<String> ids) {
    _items.removeWhere((e) => ids.contains(e.id));
  }

  void reorder(int oldIndex, int newIndex, List<TemplateItem> scope) {
    // 简化：仅演示，可按“expense范围 / income范围”分别重排并写回
  }
}
