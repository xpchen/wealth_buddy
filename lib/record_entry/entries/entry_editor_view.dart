import 'package:flutter/material.dart';
import '../models/entry_models.dart';
import '../widgets/field_row.dart';
import '../widgets/keypad_collapsed_bar.dart';
import '../widgets/amount_keypad.dart';
import '../dialogs/expense/expense_sheet.dart';
import '../dialogs/expense/expense_sheet_config.dart';
import '../dialogs/income/income_sheet.dart';
import '../dialogs/income/income_sheet_config.dart';
import '../dialogs/transfer/transfer_sheet.dart';
import '../dialogs/transfer/transfer_sheet_config.dart';

class EntryEditorView extends StatefulWidget {
  final EntryKind kind;
  final int modeIndex; // 0支出1收入2转账
  final ValueChanged<int> onModeChange;

  final EntryDraft draft;
  final ValueChanged<EntryDraft> onDraftChanged;

  final VoidCallback onSubmit;
  final String ledgerId;

  const EntryEditorView({
    super.key,
    required this.ledgerId,
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

  bool get _isTransfer => widget.kind == EntryKind.transfer;

  Color get _amountColor {
    // 截图：转账金额是黑色；支出偏青；收入偏红
    if (_isTransfer) return const Color(0xFF1F2329);
    if (widget.kind == EntryKind.income) return const Color(0xFFE86A5E);
    return const Color(0xFF2CB7B0);
  }

  Color get _lineColor {
    // 截图：转账下方是橙色线；支出/收入用青色线
    if (_isTransfer) return const Color(0xFFE6A15B);
    return const Color(0xFF2CB7B0);
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);

    return Container(
      color: bg,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: _keypadVisible ? 330 : 40),
            child: Column(
              children: [
                // 金额区 + 拍照（与你截图一致的位置）
                // 金额区部分
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // 当点击金额时，如果数字键盘隐藏，则显示
                                if (!_keypadVisible) {
                                  setState(() {
                                    _keypadVisible = true; // 显示数字键盘
                                  });
                                }
                              },
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
                      Container(height: 2, color: _lineColor.withOpacity(0.85)),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 字段区
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // 1) 分类：转账不显示
                      if (!_isTransfer) ...[
                        FieldRow(
                          icon: Icons.grid_view_outlined,
                          title: '分类',
                          value: widget.draft.category,
                          onTap: () async {
                            debugPrint('[CategoryTap] handled: ${widget.kind}');
                            if (widget.kind == EntryKind.expense) {
                              final String? path =
                                  await showExpenseDialog<String>(
                                    context,
                                    config: ExpenseDialogConfig.picker(
                                      ledgerId: widget.ledgerId,
                                      enableSearch: true,
                                      enableCreate: true,
                                    ),
                                  );
                              if (path != null && path.isNotEmpty) {
                                widget.onDraftChanged(
                                  widget.draft.copyWith(category: path),
                                );
                              }
                              return;
                            }

                            if (widget.kind == EntryKind.income) {
                              final String? path =
                                  await showIncomeDialog<String>(
                                    context,
                                    config: IncomeDialogConfig.picker(
                                      ledgerId: widget.ledgerId,
                                      enableSearch: true,
                                      enableCreate: true,
                                    ),
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
                      ],

                      // 2) 账户：转账显示“转出/转入”
                      if (_isTransfer) ...[
                        _transferAccountRow(),
                      ] else ...[
                        FieldRow(
                          icon: Icons.account_balance_wallet_outlined,
                          title: '账户',
                          value: widget.draft.account,
                          onTap: () async {
                            final picked = await _showAccountPicker(
                              '选择账户',
                              widget.draft.account,
                            );
                            if (picked != null && picked.isNotEmpty) {
                              widget.onDraftChanged(
                                widget.draft.copyWith(account: picked),
                              );
                            }
                          },
                        ),
                      ],
                      const Divider(
                        height: 1,
                        thickness: 1,
                        indent: 56,
                        color: Color(0xFFF0F2F5),
                      ),

                      // 3) 时间：转账不显示（改到 chip）
                      if (!_isTransfer) ...[
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
                                widget.draft.copyWith(timeText: _todayText()),
                              );
                            },
                          ),
                          onTap: () async {
                            final t = await _pickDateText();
                            if (t != null) {
                              widget.onDraftChanged(
                                widget.draft.copyWith(timeText: t),
                              );
                            }
                          },
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          indent: 56,
                          color: Color(0xFFF0F2F5),
                        ),
                      ],

                      // 4) 备注：通用
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
                            // 转账：加上日期 chip（与截图一致）
                            if (_isTransfer)
                              _chip(
                                widget.draft.timeText.isEmpty
                                    ? _todayText()
                                    : widget.draft.timeText,
                                onTap: () async {
                                  final t = await _pickDateText();
                                  if (t != null) {
                                    widget.onDraftChanged(
                                      widget.draft.copyWith(timeText: t),
                                    );
                                  }
                                },
                              ),
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
                      // 如果你这里还报 “No named parameter with the name 'key'”
                      // 说明 KeypadCollapsedBar 构造函数没写 super.key；
                      // 你可以：1) 给它加 super.key；或 2) 删除这里的 key 参数（我这里本来就没传）
                      onExpand: () => setState(() => _keypadVisible = true),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================
  // 转账账户行：转出 / 转入
  // ==========================
  Widget _transferAccountRow() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const SizedBox(
              width: 40,
              child: Icon(
                Icons.account_balance_wallet_outlined,
                color: Color(0xFF1F2329),
              ),
            ),
            const SizedBox(width: 6),
            const SizedBox(
              width: 44,
              child: Text(
                '账户',
                style: TextStyle(fontSize: 14, color: Color(0xFF1F2329)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        final picked = await _showAccountPicker(
                          '选择转出账户',
                          widget.draft.fromAccount,
                        );
                        if (picked == null) return;
                        if (picked == widget.draft.toAccount) {
                          _toast('转出与转入账户不能相同');
                          return;
                        }
                        widget.onDraftChanged(
                          widget.draft.copyWith(fromAccount: picked),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '转出',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8A8F99),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.draft.fromAccount,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2329),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // 中间箭头：点击交换
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      final a = widget.draft.fromAccount;
                      final b = widget.draft.toAccount;
                      widget.onDraftChanged(
                        widget.draft.copyWith(fromAccount: b, toAccount: a),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.compare_arrows_rounded,
                        color: Color(0xFFB0B6BF),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        final picked = await _showAccountPicker(
                          '选择转入账户',
                          widget.draft.toAccount,
                        );
                        if (picked == null) return;
                        if (picked == widget.draft.fromAccount) {
                          _toast('转出与转入账户不能相同');
                          return;
                        }
                        widget.onDraftChanged(
                          widget.draft.copyWith(toAccount: picked),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '转入',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8A8F99),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.draft.toAccount,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2329),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showAccountPicker(String title, String current) async {
    // 直接复用你新建的转账对话框（分组账户列表）
    final picked = await showTransferDialog<String>(
      context,
      config: TransferDialogConfig.picker(
        ledgerId: widget.ledgerId,
        selectedName: current,
        enableSearch: true,
        enableCreate: true,
      ),
    );

    // 返回账户名称（CategoryItem.name）
    return picked;
  }

  Widget _chip(String text, {VoidCallback? onTap}) {
    final child = Container(
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

    if (onTap == null) return child;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: child,
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

  // ==========================
  // 日期选择：输出类似 “今天  01月08日”
  // ==========================
  String _two(int n) => n.toString().padLeft(2, '0');

  String _todayText() {
    final now = DateTime.now();
    return '今天  ${_two(now.month)}月${_two(now.day)}日';
  }

  Future<String?> _pickDateText() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (date == null) return null;

    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final prefix = isToday ? '今天  ' : '';
    return '$prefix${_two(date.month)}月${_two(date.day)}日';
  }
}
