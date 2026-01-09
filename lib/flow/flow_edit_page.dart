// lib/flow/flow_edit_page.dart
import 'package:flutter/material.dart';

import '../record_entry/entries/expense_entry_view.dart';
import '../record_entry/entries/income_entry_view.dart';
import '../record_entry/entries/transfer_entry_view.dart';
import '../record_entry/models/entry_models.dart';
import '../record_entry/domain/record_service.dart';

class FlowEditPage extends StatefulWidget {
  final String ledgerId;
  final String entryId;

  const FlowEditPage({
    super.key,
    required this.ledgerId,
    required this.entryId,
  });

  @override
  State<FlowEditPage> createState() => _FlowEditPageState();
}

class _FlowEditPageState extends State<FlowEditPage> {
  bool _loading = true;

  late EntryKind _kind;
  late EntryDraft _draft;

  int get _modeIndex {
    switch (_kind) {
      case EntryKind.expense:
        return 0;
      case EntryKind.income:
        return 1;
      case EntryKind.transfer:
        return 2;
    }
  }

  String get _title {
    switch (_kind) {
      case EntryKind.expense:
        return '编辑支出';
      case EntryKind.income:
        return '编辑收入';
      case EntryKind.transfer:
        return '编辑转账';
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      // 需要你在 RecordService 实现 loadForEdit（见文末接口签名）
      final r = await RecordService.instance.loadForEdit(
        ledgerId: widget.ledgerId,
        entryId: widget.entryId,
      );

      if (!mounted) return;
      setState(() {
        _kind = r.kind;
        _draft = r.draft;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('加载失败：$e')));
    }
  }

  Future<void> _submit() async {
    try {
      // 需要你在 RecordService 实现 updateDraft（见文末接口签名）
      await RecordService.instance.updateDraft(
        ledgerId: widget.ledgerId,
        entryId: widget.entryId,
        kind: _kind,
        draft: _draft,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true); // 通知 Flow 刷新
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('删除这条流水？'),
        content: const Text('删除后将从流水中移除。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      // 需要你在 RecordService 实现 deleteEntry（见文末接口签名）
      await RecordService.instance.deleteEntry(
        ledgerId: widget.ledgerId,
        entryId: widget.entryId,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true); // 通知 Flow 刷新
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('删除失败：$e')));
    }
  }

  void _convertToTransfer() {
    // 你截图里有“改为转账”，这里先把 UI 和入口放好。
    // 真正转换需要把：原 account -> from/to，且更新 txnType。
    // 由于 EntryDraft 字段你没给全，我这里先做“切到转账编辑”的壳，避免编译风险。
    if (_kind == EntryKind.transfer) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('改为转账：待接入（需要 account → from/to 映射）')),
    );

    // 如果你希望先切 UI，可取消注释下面两行（前提：initialTransfer 不会破坏你的字段约束）
    // setState(() {
    //   _kind = EntryKind.transfer;
    //   _draft = EntryDraft.initialTransfer(); // 可在这里把 amount/时间/备注等从旧 draft 复制过去
    // });
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);
    const textMain = Color(0xFF1F2329);

    if (_loading) {
      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: textMain,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: const Text(
            '编辑',
            style: TextStyle(
              color: textMain,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: const Color(0xFFF0F2F5)),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: textMain),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          _title,
          style: const TextStyle(
            color: textMain,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // 顶部对勾：保存
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _submit,
              child: Container(
                width: 54,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFC2A8), Color(0xFFFF8B62)],
                  ),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFF0F2F5)),
        ),
      ),

      // 主体：复用你现有三件套 EntryView（它们本身就是“编辑支出/收入/转账”风格）
      body: _buildBody(),

      // 底部：删除 / 改为转账 / 完成（贴近你截图）
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFF0F2F5))),
          ),
          child: Row(
            children: [
              Expanded(
                child: _OutlinePillButton(
                  text: '删除',
                  textColor: const Color(0xFFE35A5A),
                  borderColor: const Color(0xFFE5E6EB),
                  onTap: _delete,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _GradientPillButton(text: '完成', onTap: _submit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    // 编辑页不允许切类型：modeIndex 固定、onModeChange 不做切换
    if (_kind == EntryKind.income) {
      return IncomeEntryView(
        ledgerId: widget.ledgerId,
        modeIndex: _modeIndex,
        onModeChange: (_) {},
        draft: _draft,
        onDraftChanged: (d) => setState(() => _draft = d),
        onSubmit: _submit,
      );
    }

    if (_kind == EntryKind.transfer) {
      return TransferEntryView(
        ledgerId: widget.ledgerId,
        modeIndex: _modeIndex,
        onModeChange: (_) {},
        draft: _draft,
        onDraftChanged: (d) => setState(() => _draft = d),
        onSubmit: _submit,
      );
    }

    return ExpenseEntryView(
      ledgerId: widget.ledgerId,
      modeIndex: _modeIndex,
      onModeChange: (_) {},
      draft: _draft,
      onDraftChanged: (d) => setState(() => _draft = d),
      onSubmit: _submit,
    );
  }
}

class _OutlinePillButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _OutlinePillButton({
    required this.text,
    required this.textColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _GradientPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _GradientPillButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFC2A8), Color(0xFFFF8B62)],
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
