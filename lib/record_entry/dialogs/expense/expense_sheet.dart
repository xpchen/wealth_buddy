import 'package:flutter/material.dart';

import '../../shared/bottom_sheet_scaffold.dart';
import 'expense_sheet_config.dart';
import 'views/expense_manage_view.dart';
import 'views/expense_picker_two_pane_view.dart';
import 'views/expense_picker_simple_list_view.dart';

Future<T?> showExpenseDialog<T>(
  BuildContext context, {
  required ExpenseDialogConfig config,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        BottomSheetScaffold(child: _ExpenseSheetBody(config: config)),
  );
}

class _ExpenseSheetBody extends StatelessWidget {
  final ExpenseDialogConfig config;

  const _ExpenseSheetBody({required this.config});

  @override
  Widget build(BuildContext context) {
    switch (config.mode) {
      case ExpenseDialogMode.manage:
        return ExpenseManageView(config: config);

      case ExpenseDialogMode.pickerTwoPaneGrid:
        return ExpensePickerTwoPaneView(config: config);

      case ExpenseDialogMode.pickerSimpleList:
        return ExpensePickerSimpleListView(config: config);
    }
  }
}
