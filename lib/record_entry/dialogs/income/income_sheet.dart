import 'package:flutter/material.dart';

import '../../shared/bottom_sheet_scaffold.dart';
import 'income_sheet_config.dart';
import 'views/income_picker_two_pane_view.dart';

Future<T?> showIncomeDialog<T>(
  BuildContext context, {
  required IncomeDialogConfig config,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BottomSheetScaffold(child: _IncomeSheetBody(config: config));
    },
  );
}

class _IncomeSheetBody extends StatelessWidget {
  final IncomeDialogConfig config;

  const _IncomeSheetBody({required this.config});

  @override
  Widget build(BuildContext context) {
    switch (config.mode) {
      case IncomeDialogMode.pickerTwoPaneGrid:
        return IncomePickerTwoPaneView(config: config);
    }
  }
}
