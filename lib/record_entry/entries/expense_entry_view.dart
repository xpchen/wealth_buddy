import 'package:flutter/material.dart';
import '../models/entry_models.dart';
import 'entry_editor_view.dart';

class ExpenseEntryView extends StatelessWidget {
  final int modeIndex;
  final ValueChanged<int> onModeChange;

  final EntryDraft draft;
  final ValueChanged<EntryDraft> onDraftChanged;

  final VoidCallback onSubmit;

  const ExpenseEntryView({
    super.key,
    required this.modeIndex,
    required this.onModeChange,
    required this.draft,
    required this.onDraftChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return EntryEditorView(
      kind: EntryKind.expense,
      modeIndex: modeIndex,
      onModeChange: onModeChange,
      draft: draft,
      onDraftChanged: onDraftChanged,
      onSubmit: onSubmit,
    );
  }
}
