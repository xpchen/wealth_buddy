import 'package:flutter/material.dart';
import 'entries/expense_entry_view.dart';
import 'entries/income_entry_view.dart';
import 'entries/transfer_entry_view.dart';
import 'models/entry_models.dart';
import 'models/template_models.dart';
import 'templates/template_home_view.dart';
import 'widgets/top_tabs_bar.dart';
import 'dialogs/record_type_dialogs.dart';
import 'shared/record_types.dart';
import 'domain/record_service.dart'; // 按你实际路径调整

class RecordEntryPage extends StatefulWidget {
  final String ledgerId;
  const RecordEntryPage({super.key, required this.ledgerId});

  @override
  State<RecordEntryPage> createState() => _RecordEntryPageState();
}

class _RecordEntryPageState extends State<RecordEntryPage> {
  final List<String> _topTabs = const [
    '模板',
    '支出',
    '收入',
    '转账',
    '余额',
    '借贷',
    '代付',
  ];

  int _topTabIndex = 1; // 默认：支出（与截图一致）
  int _modeIndex = 0; // 键盘左侧模式：0支出 1收入 2转账

  bool get _isTemplateTab => _topTabIndex == 0;

  /// 三种录入模式分别保存草稿，避免切换丢状态
  final Map<EntryKind, EntryDraft> _drafts = {
    EntryKind.expense: EntryDraft.initialExpense(),
    EntryKind.income: EntryDraft.initialIncome(),
    EntryKind.transfer: EntryDraft.initialTransfer(),
  };

  EntryKind get _activeKind {
    if (_topTabIndex == 2) return EntryKind.income;
    if (_topTabIndex == 3) return EntryKind.transfer;
    return EntryKind.expense;
  }

  EntryDraft get _activeDraft => _drafts[_activeKind]!;

  void _syncTopToMode(int topIndex) {
    // 顶部Tab：支出=1 收入=2 转账=3
    // 左侧模式：支出=0 收入=1 转账=2
    if (topIndex == 1) _modeIndex = 0;
    if (topIndex == 2) _modeIndex = 1;
    if (topIndex == 3) _modeIndex = 2;
  }

  void _syncModeToTop(int modeIndex) {
    _topTabIndex = (modeIndex == 0)
        ? 1
        : (modeIndex == 1)
        ? 2
        : 3;
  }

  void _onTopTabTap(int i) {
    setState(() {
      _topTabIndex = i;
      if (i == 1 || i == 2 || i == 3) {
        _syncTopToMode(i);
      }
    });
  }

  void _onModeChange(int i) {
    setState(() {
      _modeIndex = i;
      _syncModeToTop(i);
    });
  }

  Future<void> _onSubmit() async {
    final kind = _activeKind;
    final draft = _activeDraft;

    try {
      final txnId = await RecordService.instance.submitDraft(
        ledgerId: widget.ledgerId,
        kind: kind,
        draft: draft,
      );

      // 成功后：重置草稿（只重置当前类型，体验更贴合）
      setState(() {
        _drafts[kind] = (kind == EntryKind.expense)
            ? EntryDraft.initialExpense()
            : (kind == EntryKind.income)
            ? EntryDraft.initialIncome()
            : EntryDraft.initialTransfer();
      });

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已保存：$txnId')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('保存失败：$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);
    const textMain = Color(0xFF1F2329);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: textMain),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          '记一笔',
          style: TextStyle(
            color: textMain,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          _buildCustomAction(),
          if (!_isTemplateTab) _buildSubmitAction(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFF0F2F5)),
        ),
      ),
      body: Column(
        children: [
          TopTabsBar(tabs: _topTabs, index: _topTabIndex, onTap: _onTopTabTap),
          Expanded(
            child: _isTemplateTab
                ? TemplateHomeView(
                    onUseTemplate: (t) {
                      setState(() {
                        // 1) 根据模板类型切换顶部Tab，并同步键盘模式
                        if (t.type == TemplateType.income) {
                          _topTabIndex = 2; // 收入
                        } else if (t.type == TemplateType.transfer) {
                          _topTabIndex = 3; // 转账（如果你模板支持转账）
                        } else {
                          _topTabIndex = 1; // 支出
                        }
                        _syncTopToMode(_topTabIndex);

                        // 2) 映射到 EntryKind
                        final EntryKind kind = (t.type == TemplateType.income)
                            ? EntryKind.income
                            : (t.type == TemplateType.transfer)
                            ? EntryKind.transfer
                            : EntryKind.expense;

                        // 3) 回填草稿（只填你模型里存在的字段）
                        final d = _drafts[kind]!;
                        _drafts[kind] = d.copyWith(
                          category: t.categoryPath ?? d.category,
                          account: t.accountName,
                          amount: t.amountText,
                          // 你的 TemplateItem 目前没有 remark，所以这里不写
                          // remark: d.remark,
                        );
                      });
                    },
                  )
                : _buildEntryBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryBody() {
    // 只完善“三件套”：支出/收入/转账
    if (_topTabIndex == 2) {
      return IncomeEntryView(
        ledgerId: widget.ledgerId,
        modeIndex: _modeIndex,
        onModeChange: _onModeChange,
        draft: _drafts[EntryKind.income]!,
        onDraftChanged: (d) => setState(() => _drafts[EntryKind.income] = d),
        onSubmit: _onSubmit,
      );
    }
    if (_topTabIndex == 3) {
      return TransferEntryView(
        ledgerId: widget.ledgerId,
        modeIndex: _modeIndex,
        onModeChange: _onModeChange,
        draft: _drafts[EntryKind.transfer]!,
        onDraftChanged: (d) => setState(() => _drafts[EntryKind.transfer] = d),
        onSubmit: _onSubmit,
      );
    }

    // 默认支出
    return ExpenseEntryView(
      ledgerId: widget.ledgerId,
      modeIndex: _modeIndex,
      onModeChange: _onModeChange,
      draft: _drafts[EntryKind.expense]!,
      onDraftChanged: (d) => setState(() => _drafts[EntryKind.expense] = d),
      onSubmit: _onSubmit,
    );
  }

  Widget _buildCustomAction() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          if (_topTabIndex == 1) {
            RecordTypeDialogs.open(
              context,
              ledgerId: widget.ledgerId,
              type: RecordType.expense,
            );
            return;
          }
          if (_topTabIndex == 2) {
            RecordTypeDialogs.open(
              context,
              ledgerId: widget.ledgerId,
              type: RecordType.income,
            );
            return;
          }
          if (_topTabIndex == 3) {
            RecordTypeDialogs.open(
              context,
              ledgerId: widget.ledgerId,
              type: RecordType.transfer,
            );
            return;
          }
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('该功能暂未接入自定义面板')));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4EE),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: const [
              Icon(Icons.tune, size: 16, color: Color(0xFFB87B5B)),
              SizedBox(width: 6),
              Text(
                '自定义',
                style: TextStyle(
                  color: Color(0xFFB87B5B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitAction() {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: _onSubmit,
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
    );
  }
}
