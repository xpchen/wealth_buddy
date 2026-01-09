import 'package:flutter/material.dart';

import '../data/db/ledger/ledger_db.dart';
import '../data/db/ledger/ledger_tables.dart';
import 'account_money.dart';
import 'account_repo.dart';
import 'account_type_ui.dart';

class CashAccountEditPage extends StatefulWidget {
  final String ledgerId;
  final AccountType accountType;
  final String pageTitle;

  /// If provided, page works in "edit" mode.
  final Account? initial;

  const CashAccountEditPage({
    super.key,
    this.ledgerId = 'default',
    this.accountType = AccountType.cash,
    this.pageTitle = '新建现金账户',
    this.initial,
  });

  @override
  State<CashAccountEditPage> createState() => _CashAccountEditPageState();
}

class _CashAccountEditPageState extends State<CashAccountEditPage> {
  final _nameCtrl = TextEditingController();
  final _balanceCtrl = TextEditingController();

  bool _hidden = false;

  /// 是否参与总资产/总负债/净资产等统计（schema v2: accounts.includeInTotals）。
  bool _includeInTotals = true;

  final _sortCtrl = TextEditingController();

  bool _saving = false;

  @override
  void initState() {
    super.initState();

    final a = widget.initial;
    if (a != null) {
      _nameCtrl.text = a.name;
      _balanceCtrl.text = Money.formatMinor(a.initialBalanceMinor);
      _hidden = a.isArchived;
      _includeInTotals = a.includeInTotals;
      _sortCtrl.text = (a.sortOrder).toString();
    } else {
      _includeInTotals = true;
      _sortCtrl.text = '0';
}

    _nameCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balanceCtrl.dispose();
    _sortCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;

    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      _toast('请输入账户名称');
      return;
    }

    int minor = 0;
    try {
      minor = Money.parseToMinor(_balanceCtrl.text.isEmpty ? '0' : _balanceCtrl.text);
    } catch (_) {
      _toast('余额格式不正确，例如：123.45');
      return;
    }


    int sortOrder = 0;
    try {
      final s = _sortCtrl.text.trim();
      sortOrder = s.isEmpty ? 0 : int.parse(s);
    } catch (_) {
      _toast('排序必须是整数');
      return;
    }

    setState(() => _saving = true);
    try {
      if (widget.initial == null) {
        await AccountRepo.instance.createAccount(
          ledgerId: widget.ledgerId,
          type: widget.accountType,
          name: name,
          initialBalanceMinor: minor,
          hidden: _hidden,
          includeInTotals: _includeInTotals,
          sortOrder: sortOrder,
        );
      } else {
        await AccountRepo.instance.updateAccount(
          ledgerId: widget.ledgerId,
          accountId: widget.initial!.accountId,
          name: name,
          initialBalanceMinor: minor,
          hidden: _hidden,
          includeInTotals: _includeInTotals,
          sortOrder: sortOrder,
        );
      }

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      _toast('保存失败：$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final ui = accountTypeUi(widget.accountType);

    final canSave = _nameCtrl.text.trim().isNotEmpty && !_saving;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.initial == null ? widget.pageTitle : '编辑${ui.title}账户',
          style: const TextStyle(
            color: Color(0xFF222222),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF222222)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          TextButton(
            onPressed: canSave ? _save : null,
            child: Text(
              '保存',
              style: TextStyle(
                color: canSave ? ui.accent : const Color(0xFFB8BEC6),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
        children: [
          _sectionCard(
            title: '基础信息',
            children: [
              _InputRow(
                label: '账户名称',
                hint: '例如：现金 / 招商银行卡 / 微信钱包',
                controller: _nameCtrl,
              ),
              const Divider(height: 1, color: Color(0xFFF0F1F3), indent: 16),
              _InputRow(
                label: '余额',
                hint: '0.00',
                controller: _balanceCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                suffix: const _SmallIconBadge(text: 'CNY'),
              ),
              const Divider(height: 1, color: Color(0xFFF0F1F3), indent: 16),
              _InputRow(
                label: '排序',
                hint: '0（越小越靠前）',
                controller: _sortCtrl,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _sectionCard(
            title: '显示与统计',
            children: [
              _SwitchRow(
                label: '隐藏',
                value: _hidden,
                onChanged: (v) => setState(() => _hidden = v),
              ),
              const Divider(height: 1, color: Color(0xFFF0F1F3), indent: 16),
              _SwitchRow(
                label: '计入统计',
                value: _includeInTotals,
                activeColor: ui.accent,
                onChanged: (v) => setState(() => _includeInTotals = v),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '提示：关闭“计入统计”后，该账户仍会显示在列表中，但不会参与总资产/总负债/净资产等统计。',
              style: const TextStyle(fontSize: 12, color: Color(0xFF8A8F98)),
            ),
          ),
          const SizedBox(height: 18),
          _TapRow(
            label: '更多设置（后续）',
            value: '图标 / 备注 / 币种 / 信用卡账单日等',
            onTap: () => _toast('该功能即将上线'),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF222222),
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0F1F3)),
          ...children,
        ],
      ),
    );
  }
}

class _TapRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _TapRow({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF8A8F98)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF222222)),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }
}

class _InputRow extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _InputRow({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF222222)),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFFB8BEC6)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffix != null) ...[
            const SizedBox(width: 10),
            suffix!,
          ],
        ],
      ),
    );
  }
}

class _SmallIconBadge extends StatelessWidget {
  final String text;
  const _SmallIconBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F2F4),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
      ),
    );
  }
}
