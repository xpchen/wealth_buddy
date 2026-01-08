import 'package:flutter/material.dart';
import '../shared/record_types.dart';
import 'expense/expense_sheet.dart';
import 'expense/expense_sheet_config.dart';

class RecordTypeDialogs {
  static Future<void> open(
    BuildContext context, {
    required RecordType type,
  }) async {
    switch (type) {
      case RecordType.expense:
        await showExpenseDialog(
          context,
          config: const ExpenseDialogConfig.manage(), // 默认：支出分类管理
        );
        return;

      case RecordType.income:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('收入对话框：待实现')));
        return;

      case RecordType.transfer:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('转账对话框：待实现')));
        return;
    }
  }
}
