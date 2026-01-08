import 'package:flutter/material.dart';
import '../models/entry_models.dart';
import '../widgets/field_row.dart';
import '../widgets/keypad_collapsed_bar.dart';
import '../widgets/amount_keypad.dart';
import '../dialogs/expense/expense_sheet.dart';
import '../dialogs/expense/expense_sheet_config.dart';
import '../dialogs/income/income_sheet.dart';
import '../dialogs/income/income_sheet_config.dart';

class EntryEditorView extends StatefulWidget {
  final EntryKind kind;
  final int modeIndex; // 0支出1收入2转账
  final ValueChanged<int> onModeChange;

  final EntryDraft draft;
  final ValueChanged<EntryDraft> onDraftChanged;

  final VoidCallback onSubmit;

  const EntryEditorView({
    super.key,
    required this.kind,
    required this.modeIndex,
    required this.onModeChange,
    required this.draft,
    required this.onDraftChanged,
    required this.onSubmit,
  });

  @override
  State<EntryEditorView> createState() => _EntryEditorViewState();
}

class _EntryEditorViewState extends State<EntryEditorView> {
  bool _keypadVisible = true;

  Color get _amountColor {
    // 截图：支出是偏青色；收入可偏红；转账沿用青色也可
    if (widget.kind == EntryKind.income) return const Color(0xFFE86A5E);
    return const Color(0xFF2CB7B0);
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);
    const tealLine = Color(0xFF2CB7B0);

    return Container(
      color: bg,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: _keypadVisible ? 330 : 40),
            child: Column(
              children: [
                // 金额区 + 拍照（与你截图一致的位置）
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.draft.amount,
                              style: TextStyle(
                                fontSize: 54,
                                fontWeight: FontWeight.w300,
                                color: _amountColor,
                                height: 1.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 64,
                            child: InkWell(
                              onTap: () {
                                // TODO: 拍照识别
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.photo_camera_outlined,
                                      size: 28,
                                      color: Color(0xFF1F2329),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '拍照',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8A8F99),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(height: 2, color: tealLine.withOpacity(0.85)),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 字段区（分类/账户/时间/备注）
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      FieldRow(
                        icon: Icons.grid_view_outlined,
                        title: '分类',
                        value: widget.draft.category,
                        onTap: () async {
                          debugPrint('[CategoryTap] handled: ${widget.kind}');
                          if (widget.kind == EntryKind.expense) {
                            debugPrint('[CategoryTap] open expense picker');
                            final String? path =
                                await showExpenseDialog<String>(
                                  context,
                                  config: const ExpenseDialogConfig.picker(),
                                );
                            if (path != null && path.isNotEmpty) {
                              widget.onDraftChanged(
                                widget.draft.copyWith(category: path),
                              );
                            }
                            return;
                          }

                          if (widget.kind == EntryKind.income) {
                            debugPrint('[CategoryTap] open income picker');
                            final String? path = await showIncomeDialog<String>(
                              context,
                              config: const IncomeDialogConfig.picker(),
                            );
                            if (path != null && path.isNotEmpty) {
                              widget.onDraftChanged(
                                widget.draft.copyWith(category: path),
                              );
                            }
                            return;
                          }
                        },
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 56,
                        color: Color(0xFFF0F2F5),
                      ),
                      FieldRow(
                        icon: Icons.account_balance_wallet_outlined,
                        title: '账户',
                        value: widget.draft.account,
                        onTap: () {},
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 56,
                        color: Color(0xFFF0F2F5),
                      ),
                      FieldRow(
                        icon: Icons.access_time,
                        title: '时间',
                        value: widget.draft.timeText,
                        trailing: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFFB0B6BF),
                          ),
                          onPressed: () {
                            widget.onDraftChanged(
                              widget.draft.copyWith(timeText: '今天  01月07日'),
                            );
                          },
                        ),
                        onTap: () {},
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 56,
                        color: Color(0xFFF0F2F5),
                      ),
                      FieldRow(
                        icon: Icons.bookmark_border,
                        title: '备注',
                        value: widget.draft.remark.isEmpty
                            ? '...'
                            : widget.draft.remark,
                        valueColor: widget.draft.remark.isEmpty
                            ? const Color(0xFFB0B6BF)
                            : const Color(0xFF1F2329),
                        onTap: () async {
                          final res = await _showRemarkDialog(
                            context,
                            widget.draft.remark,
                          );
                          if (res != null) {
                            widget.onDraftChanged(
                              widget.draft.copyWith(remark: res),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),

                      // chips
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _chip('136****02...'),
                            _chip('商家'),
                            _chip('项目'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 底部键盘（固定）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: _keypadVisible
                  ? AmountKeypad(
                      key: const ValueKey('keypad'),
                      modeIndex: widget.modeIndex,
                      onModeChange: widget.onModeChange,
                      onKey: _onKeypadKey,
                      onHide: () => setState(() => _keypadVisible = false),
                      onSubmit: widget.onSubmit,
                    )
                  : KeypadCollapsedBar(
                      key: const ValueKey('collapsed'),
                      onExpand: () => setState(() => _keypadVisible = true),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Color(0xFF1F2329)),
      ),
    );
  }

  void _onKeypadKey(KeypadKey key) {
    var amount = widget.draft.amount;

    switch (key.type) {
      case KeypadKeyType.digit:
        amount = _applyDigit(amount, key.text);
        break;
      case KeypadKeyType.dot:
        amount = _applyDot(amount);
        break;
      case KeypadKeyType.backspace:
        amount = _applyBackspace(amount);
        break;
      case KeypadKeyType.plus:
      case KeypadKeyType.minus:
        // 先只做外观一致；要做连加/连减再加状态机
        break;
    }

    widget.onDraftChanged(widget.draft.copyWith(amount: amount));
  }

  String _applyDigit(String current, String d) {
    var s = current;

    if (s == '0.00') {
      s = d;
      return _normalizeMoney(s);
    }
    if (s.length >= 12) return s;

    if (s.contains('.')) {
      final parts = s.split('.');
      if (parts.length == 2 && parts[1].length >= 2) return s;
    }

    s += d;
    return _normalizeMoney(s);
  }

  String _applyDot(String current) {
    if (current.contains('.')) return current;
    return '$current.';
  }

  String _applyBackspace(String current) {
    if (current.isEmpty) return '0.00';
    var s = current.substring(0, current.length - 1);
    if (s.isEmpty || s == '-') return '0.00';
    return _normalizeMoney(s);
  }

  String _normalizeMoney(String s) {
    if (s.endsWith('.')) return s;
    if (s.contains('.')) {
      final parts = s.split('.');
      if (parts.length == 2) {
        final dec = parts[1];
        if (dec.length <= 2) return s;
        return '${parts[0]}.${dec.substring(0, 2)}';
      }
    }
    return s;
  }

  Future<String?> _showRemarkDialog(BuildContext context, String init) async {
    final controller = TextEditingController(text: init);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('备注'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(hintText: '请输入备注'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
