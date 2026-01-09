import 'package:flutter/material.dart';

import '../../shared/bottom_sheet_scaffold.dart';
import 'transfer_sheet_config.dart';
import 'views/transfer_account_picker_view.dart';

Future<T?> showTransferDialog<T>(
  BuildContext context, {
  required TransferDialogConfig config,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BottomSheetScaffold(child: _TransferSheetBody(config: config));
    },
  );
}

class _TransferSheetBody extends StatelessWidget {
  final TransferDialogConfig config;

  const _TransferSheetBody({required this.config});

  @override
  Widget build(BuildContext context) {
    switch (config.mode) {
      case TransferDialogMode.pickerSectionList:
        return TransferAccountPickerView(config: config);
    }
  }
}
