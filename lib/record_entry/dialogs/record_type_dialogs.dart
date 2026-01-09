import 'package:flutter/material.dart';

import '../shared/record_types.dart';

import 'expense/expense_sheet.dart';
import 'expense/expense_sheet_config.dart';

import 'income/income_sheet.dart';
import 'income/income_sheet_config.dart';

import 'transfer/transfer_sheet.dart';
import 'transfer/transfer_sheet_config.dart';

class RecordTypeDialogs {
  static Future<void> open(
    BuildContext context, {
    required String ledgerId,
    required RecordType type,
  }) async {
    switch (type) {
      case RecordType.expense:
        await showExpenseDialog(
          context,
          config: ExpenseDialogConfig.manage(ledgerId: ledgerId),
        );
        return;

      case RecordType.income:
        await showIncomeDialog(
          context,
          config: IncomeDialogConfig.picker(ledgerId: ledgerId),
        );
        return;

      case RecordType.transfer:
        await showTransferDialog(
          context,
          config: TransferDialogConfig.picker(ledgerId: ledgerId),
        );
        return;
    }
  }
}
