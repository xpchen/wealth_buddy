import 'package:flutter/material.dart';
import '../data/template_memory_repo.dart';
import '../models/template_models.dart';

class TemplateEditPage extends StatefulWidget {
  final TemplateItem? editing;

  const TemplateEditPage({super.key, this.editing});

  @override
  State<TemplateEditPage> createState() => _TemplateEditPageState();
}

class _TemplateEditPageState extends State<TemplateEditPage> {
  final repo = TemplateMemoryRepo.instance;

  TemplateType _type = TemplateType.expense;
  String _amount = '0.00';

  String _name = '早午晚餐';
  String _category = '食品酒水  >  早午晚餐';
  String _account = '现金 (CNY)';
  bool _autoPost = false;
  final String _remind = '无提醒';
  String _timeText = '今天  01月07日';
  String _remark = '';

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    if (e != null) {
      _type = e.type;
      _name = e.name;
      _account = e.accountName;
      _amount = e.amountText;
      _category = e.categoryPath ?? _category;
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);
    const textMain = Color(0xFF1F2329);
    const textSub = Color(0xFF8A8F99);
    const teal = Color(0xFF2CB7B0);

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
          widget.editing == null ? '新增模板' : '编辑模板',
          style: const TextStyle(
            color: textMain,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: _save,
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
      body: Column(
        children: [
          // 支出/收入/转账 tab
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _miniTab(
                  '支出',
                  _type == TemplateType.expense,
                  () => setState(() => _type = TemplateType.expense),
                ),
                _miniTab(
                  '收入',
                  _type == TemplateType.income,
                  () => setState(() => _type = TemplateType.income),
                ),
                _miniTab(
                  '转账',
                  _type == TemplateType.transfer,
                  () => setState(() => _type = TemplateType.transfer),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                // 金额
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _amount,
                        style: const TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.w300,
                          color: teal,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(height: 2, color: teal.withOpacity(0.8)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // 表单
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _row(
                        '名称',
                        _name,
                        onTap: () async {
                          final res = await _inputDialog(context, '名称', _name);
                          if (res != null) setState(() => _name = res);
                        },
                      ),
                      _div(),
                      _row('分类', _category, onTap: () {}),
                      _div(),
                      _row('账户', _account, onTap: () {}),
                      _div(),
                      _switchRow(
                        '自动入账',
                        _autoPost,
                        (v) => setState(() => _autoPost = v),
                      ),
                      _div(),
                      _row('提醒时间', _remind, onTap: () {}),
                      _div(),
                      _row(
                        '时间',
                        _timeText,
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFFB0B6BF),
                          ),
                          onPressed: () =>
                              setState(() => _timeText = '今天  01月07日'),
                        ),
                        onTap: () {},
                      ),
                      _div(),
                      _row(
                        '备注',
                        _remark.isEmpty ? '...' : _remark,
                        valueColor: _remark.isEmpty
                            ? const Color(0xFFB0B6BF)
                            : textMain,
                        onTap: () async {
                          final res = await _inputDialog(
                            context,
                            '备注',
                            _remark,
                          );
                          if (res != null) setState(() => _remark = res);
                        },
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFC2A8), Color(0xFFFF8B62)],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '存为模板',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniTab(String text, bool selected, VoidCallback onTap) {
    const orange = Color(0xFFFF8B62);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: selected
                    ? const Color(0xFF1F2329)
                    : const Color(0xFF8A8F99),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: selected ? 18 : 0,
              height: 4,
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _div() => const Divider(
    height: 1,
    thickness: 1,
    indent: 16,
    color: Color(0xFFF0F2F5),
  );

  Widget _row(
    String title,
    String value, {
    required VoidCallback onTap,
    Widget? trailing,
    Color? valueColor,
  }) {
    const textSub = Color(0xFF8A8F99);
    const textMain = Color(0xFF1F2329);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              child: Text(
                title,
                style: const TextStyle(color: textSub, fontSize: 14),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor ?? textMain,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _switchRow(String title, bool v, ValueChanged<bool> onChanged) {
    const textSub = Color(0xFF8A8F99);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Text(
              title,
              style: const TextStyle(color: textSub, fontSize: 14),
            ),
          ),
          const Spacer(),
          Switch(value: v, onChanged: onChanged),
        ],
      ),
    );
  }

  Future<String?> _inputDialog(
    BuildContext context,
    String title,
    String init,
  ) async {
    final c = TextEditingController(text: init);
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(controller: c, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, c.text.trim()),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _save() {
    final id =
        widget.editing?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    repo.upsert(
      TemplateItem(
        id: id,
        type: _type,
        name: _name,
        accountName: _account,
        amountText: _amount,
        categoryPath: _category,
      ),
    );
    Navigator.of(context).pop();
  }
}
