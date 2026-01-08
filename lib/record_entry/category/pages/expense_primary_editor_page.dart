import 'package:flutter/material.dart';
import 'category_icon_picker_page.dart';

class ExpensePrimaryCategoryEditorPage extends StatefulWidget {
  const ExpensePrimaryCategoryEditorPage({super.key});

  @override
  State<ExpensePrimaryCategoryEditorPage> createState() =>
      _ExpensePrimaryCategoryEditorPageState();
}

class _ExpensePrimaryCategoryEditorPageState
    extends State<ExpensePrimaryCategoryEditorPage> {
  final TextEditingController _controller = TextEditingController();
  static const int maxLen = 20;

  IconData _icon = Icons.receipt_long_outlined;

  bool get _canSave => _controller.text.trim().isNotEmpty;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickIcon() async {
    final IconData? picked = await Navigator.of(context).push<IconData>(
      MaterialPageRoute(builder: (_) => CategoryIconPickerPage(initial: _icon)),
    );
    if (picked == null) return;
    setState(() => _icon = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '新建一级支出分类',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: _canSave
                ? () {
                    /* TODO: 保存到库 */
                  }
                : null,
            child: Text(
              '保存',
              style: TextStyle(
                color: _canSave ? const Color(0xFFC9A46A) : Colors.black26,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _FormRow(
            title: '分类名称',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  maxLength: maxLen,
                  decoration: const InputDecoration(
                    hintText: '请输入分类名称',
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_controller.text.length}/$maxLen',
                    style: const TextStyle(fontSize: 12, color: Colors.black38),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _FormRow(
            title: '分类图标',
            child: InkWell(
              onTap: _pickIcon,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(_icon),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _FormRow extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormRow({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      ),
    );
  }
}
