enum IncomeDialogMode {
  pickerTwoPaneGrid, // 先只做选择器
}

class IncomeDialogConfig {
  final IncomeDialogMode mode;
  final bool enableSearch;
  final bool enableCreate;

  const IncomeDialogConfig._(
    this.mode, {
    required this.enableSearch,
    required this.enableCreate,
  });

  const IncomeDialogConfig.picker({
    bool enableSearch = true,
    bool enableCreate = true,
  }) : this._(
         IncomeDialogMode.pickerTwoPaneGrid,
         enableSearch: enableSearch,
         enableCreate: enableCreate,
       );
}
