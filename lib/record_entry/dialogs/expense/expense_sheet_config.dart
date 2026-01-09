enum ExpenseDialogMode { manage, pickerTwoPaneGrid, pickerSimpleList }

class ExpenseDialogConfig {
  final String ledgerId;
  final ExpenseDialogMode mode;

  final bool enableSearch;
  final bool enableReorder;
  final bool enableCreate;

  ExpenseDialogConfig._(
    this.ledgerId,
    this.mode, {
    required this.enableSearch,
    required this.enableReorder,
    required this.enableCreate,
  });

  factory ExpenseDialogConfig.manage({
    required String ledgerId,
    bool enableSearch = true,
    bool enableReorder = true,
    bool enableCreate = true,
  }) {
    return ExpenseDialogConfig._(
      ledgerId,
      ExpenseDialogMode.manage,
      enableSearch: enableSearch,
      enableReorder: enableReorder,
      enableCreate: enableCreate,
    );
  }

  factory ExpenseDialogConfig.picker({
    required String ledgerId,
    bool enableSearch = true,
    bool enableCreate = true,
  }) {
    return ExpenseDialogConfig._(
      ledgerId,
      ExpenseDialogMode.pickerTwoPaneGrid,
      enableSearch: enableSearch,
      enableReorder: false,
      enableCreate: enableCreate,
    );
  }

  factory ExpenseDialogConfig.simpleListPicker({
    required String ledgerId,
    bool enableSearch = true,
    bool enableCreate = true,
  }) {
    return ExpenseDialogConfig._(
      ledgerId,
      ExpenseDialogMode.pickerSimpleList,
      enableSearch: enableSearch,
      enableReorder: false,
      enableCreate: enableCreate,
    );
  }
}
