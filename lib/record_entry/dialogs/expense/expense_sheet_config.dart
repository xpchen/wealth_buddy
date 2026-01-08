enum ExpenseDialogMode {
  manage, // 分类管理（默认）
  pickerTwoPaneGrid, // 两栏 + 宫格选择
  pickerSimpleList, // 预留：单列表选择
}

class ExpenseDialogConfig {
  final ExpenseDialogMode mode;

  /// 预留扩展点
  final bool enableSearch;
  final bool enableReorder;
  final bool enableCreate;

  const ExpenseDialogConfig._(
    this.mode, {
    required this.enableSearch,
    required this.enableReorder,
    required this.enableCreate,
  });

  const ExpenseDialogConfig.manage({
    bool enableSearch = true,
    bool enableReorder = true,
    bool enableCreate = true,
  }) : this._(
         ExpenseDialogMode.manage,
         enableSearch: enableSearch,
         enableReorder: enableReorder,
         enableCreate: enableCreate,
       );

  const ExpenseDialogConfig.picker({
    bool enableSearch = true,
    bool enableCreate = true,
  }) : this._(
         ExpenseDialogMode.pickerTwoPaneGrid,
         enableSearch: enableSearch,
         enableReorder: false,
         enableCreate: enableCreate,
       );

  const ExpenseDialogConfig.simpleListPicker({
    bool enableSearch = true,
    bool enableCreate = true,
  }) : this._(
         ExpenseDialogMode.pickerSimpleList,
         enableSearch: enableSearch,
         enableReorder: false,
         enableCreate: enableCreate,
       );
}
