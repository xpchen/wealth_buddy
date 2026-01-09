enum TransferDialogMode { pickerSectionList }

class TransferDialogConfig {
  final String ledgerId;
  final TransferDialogMode mode;

  final bool enableSearch;
  final bool enableCreate;
  final String? selectedName;

  TransferDialogConfig._(
    this.ledgerId,
    this.mode, {
    required this.enableSearch,
    required this.enableCreate,
    required this.selectedName,
  });

  factory TransferDialogConfig.picker({
    required String ledgerId,
    bool enableSearch = true,
    bool enableCreate = true,
    String? selectedName,
  }) {
    return TransferDialogConfig._(
      ledgerId,
      TransferDialogMode.pickerSectionList,
      enableSearch: enableSearch,
      enableCreate: enableCreate,
      selectedName: selectedName,
    );
  }
}
