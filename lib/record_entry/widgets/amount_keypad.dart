import 'package:flutter/material.dart';

enum KeypadKeyType { digit, dot, backspace, plus, minus }

class KeypadKey {
  final KeypadKeyType type;
  final String text;

  const KeypadKey._(this.type, this.text);

  factory KeypadKey.digit(String d) => KeypadKey._(KeypadKeyType.digit, d);
  factory KeypadKey.dot() => const KeypadKey._(KeypadKeyType.dot, '.');
  factory KeypadKey.backspace() =>
      const KeypadKey._(KeypadKeyType.backspace, '');
  factory KeypadKey.plus() => const KeypadKey._(KeypadKeyType.plus, '+');
  factory KeypadKey.minus() => const KeypadKey._(KeypadKeyType.minus, '-');
}

class AmountKeypad extends StatelessWidget {
  final int modeIndex; // 0支出1收入2转账
  final ValueChanged<int> onModeChange;

  final ValueChanged<KeypadKey> onKey;
  final VoidCallback onHide;
  final VoidCallback onSubmit;

  const AmountKeypad({
    super.key,
    required this.modeIndex,
    required this.onModeChange,
    required this.onKey,
    required this.onHide,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    const border = Color(0xFFEDEFF2);
    const teal = Color(0xFF2CB7B0);

    const modes = ['支出', '收入', '转账'];

    return SafeArea(
      top: false,
      child: Material(
        color: Colors.white,
        elevation: 14,
        child: SizedBox(
          height: 320,
          child: Column(
            children: [
              // 顶部收起箭头（截图右上角的下拉箭头）
              SizedBox(
                height: 34,
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 26,
                        color: Color(0xFF1F2329),
                      ),
                      onPressed: onHide,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // 左侧模式栏
                    Container(
                      width: 64,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: border, width: 1),
                        ),
                      ),
                      child: Column(
                        children: List.generate(modes.length, (i) {
                          final selected = i == modeIndex;
                          return Expanded(
                            child: InkWell(
                              onTap: () => onModeChange(i),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? teal.withOpacity(0.08)
                                      : Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: border,
                                      width: i == modes.length - 1 ? 0 : 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  modes[i],
                                  style: TextStyle(
                                    color: selected
                                        ? teal
                                        : const Color(0xFF1F2329),
                                    fontSize: 16,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    // 数字区
                    Expanded(
                      child: _KeyGrid(borderColor: border, onKey: onKey),
                    ),

                    // 右侧运算与确定
                    SizedBox(
                      width: 86,
                      child: Column(
                        children: [
                          _OpKey(
                            text: '-',
                            height: 64,
                            onTap: () => onKey(KeypadKey.minus()),
                          ),
                          _OpKey(
                            text: '+',
                            height: 64,
                            onTap: () => onKey(KeypadKey.plus()),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: onSubmit,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFFFC2A8),
                                      Color(0xFFFF8B62),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '确\n定',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KeyGrid extends StatelessWidget {
  final Color borderColor;
  final ValueChanged<KeypadKey> onKey;

  const _KeyGrid({required this.borderColor, required this.onKey});

  @override
  Widget build(BuildContext context) {
    final keys = <KeypadKey>[
      KeypadKey.digit('7'),
      KeypadKey.digit('8'),
      KeypadKey.digit('9'),
      KeypadKey.digit('4'),
      KeypadKey.digit('5'),
      KeypadKey.digit('6'),
      KeypadKey.digit('1'),
      KeypadKey.digit('2'),
      KeypadKey.digit('3'),
      KeypadKey.dot(),
      KeypadKey.digit('0'),
      KeypadKey.backspace(),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: borderColor, width: 1)),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.45,
        ),
        itemCount: keys.length,
        itemBuilder: (_, i) {
          final k = keys[i];
          final isBack = k.type == KeypadKeyType.backspace;

          return InkWell(
            onTap: () => onKey(k),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: borderColor, width: 1),
                  left: BorderSide(color: borderColor, width: 1),
                ),
              ),
              child: Center(
                child: isBack
                    ? Container(
                        width: 44,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F3136),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.backspace_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    : Text(
                        k.text,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2329),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OpKey extends StatelessWidget {
  final String text;
  final double height;
  final VoidCallback onTap;

  const _OpKey({required this.text, required this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const border = Color(0xFFEDEFF2);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: border, width: 1),
            left: BorderSide(color: border, width: 1),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2329),
            ),
          ),
        ),
      ),
    );
  }
}
