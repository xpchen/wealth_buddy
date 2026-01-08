import 'package:flutter/material.dart';

class CashAccountEditPage extends StatefulWidget {
  const CashAccountEditPage({super.key});

  @override
  State<CashAccountEditPage> createState() => _CashAccountEditPageState();
}

class _CashAccountEditPageState extends State<CashAccountEditPage> {
  final _nameCtrl = TextEditingController();
  final _balanceCtrl = TextEditingController();

  bool _hidden = false;
  bool _includeInAssets = true;

  @override
  void initState() {
    super.initState();
    _nameCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _balanceCtrl.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: 保存逻辑（入库/状态管理）
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final nameLen = _nameCtrl.text.characters.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '新建现金账户',
          style: TextStyle(
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
            onPressed: _save,
            child: const Text(
              '保存',
              style: TextStyle(
                color: Color(0xFFFF8A3D),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _FormCard(
            children: [
              _InputRow(
                label: '账户名称',
                hintText: '请输入账户名称',
                controller: _nameCtrl,
                maxLength: 16,
                trailingText: '$nameLen',
              ),
              _DividerIndent(),
              _TapRow(
                label: '账户图标',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SmallIconBadge(
                      icon: Icons.payments_outlined,
                      bg: const Color(0xFFFFF3E8),
                      color: const Color(0xFFFF8A3D),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
                  ],
                ),
                onTap: () {
                  // TODO: 打开图标选择器
                },
              ),
              _DividerIndent(),
              _InputRow(
                label: '余额',
                hintText: '请输入金额',
                controller: _balanceCtrl,
                keyboardType: TextInputType.number,
                alignRight: true,
              ),
              _DividerIndent(),
              _TapRow(
                label: '币种',
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '人民币（CNY）',
                      style: TextStyle(color: Color(0xFF222222), fontSize: 14),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
                  ],
                ),
                onTap: () {
                  // TODO: 币种选择
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          _FormCard(
            children: [
              _SwitchRow(
                label: '隐藏',
                value: _hidden,
                onChanged: (v) => setState(() => _hidden = v),
              ),
              _DividerIndent(),
              _SwitchRow(
                label: '计入资产',
                value: _includeInAssets,
                activeColor: const Color(0xFFFF8A3D),
                onChanged: (v) => setState(() => _includeInAssets = v),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _FormCard(
            children: [
              _TapRow(
                label: '添加',
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '添加子账户',
                      style: TextStyle(color: Color(0xFF222222), fontSize: 14),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right, color: Color(0xFFB8BEC6)),
                  ],
                ),
                onTap: () {
                  // TODO: 添加子账户
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          _FormCard(
            children: [
              _InputRow(
                label: '备注',
                hintText: '请输入备注',
                controller: TextEditingController(),
                maxLines: 2,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF4B07A), Color(0xFFEF9A4D)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '保存',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final List<Widget> children;

  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _DividerIndent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      color: Color(0xFFF0F1F3),
      indent: 16,
      endIndent: 16,
    );
  }
}

class _TapRow extends StatelessWidget {
  final String label;
  final Widget trailing;
  final VoidCallback onTap;

  const _TapRow({
    required this.label,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF8E959C)),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
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
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF8E959C)),
          ),
          const Spacer(),
          Switch.adaptive(
            value: value,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _InputRow extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final int? maxLength;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool alignRight;
  final String? trailingText;

  const _InputRow({
    required this.label,
    required this.hintText,
    required this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.alignRight = false,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    final textAlign = alignRight ? TextAlign.right : TextAlign.left;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 86,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF8E959C)),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLength: maxLength,
              maxLines: maxLines,
              keyboardType: keyboardType,
              textAlign: textAlign,
              decoration: InputDecoration(
                hintText: hintText,
                counterText: '',
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Color(0xFFC0C5CC)),
              ),
            ),
          ),
          if (trailingText != null) ...[
            const SizedBox(width: 8),
            Text(
              trailingText!,
              style: const TextStyle(color: Color(0xFFB8BEC6), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _SmallIconBadge extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color color;

  const _SmallIconBadge({
    required this.icon,
    required this.bg,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
