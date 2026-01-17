import 'package:flutter/material.dart';

/// 数字键盘组件
class NumberKeypad extends StatelessWidget {
  final String value;
  final ValueChanged<String> onInput;
  final VoidCallback onBackspace;
  final VoidCallback onClear;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const NumberKeypad({
    super.key,
    required this.value,
    required this.onInput,
    required this.onBackspace,
    required this.onClear,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: Colors.white,
        elevation: 14,
        child: SizedBox(
          height: 380, // 固定高度，避免渲染问题
          child: Column(
            children: [
              // 显示区域
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF2F3136),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: onCancel,
                    ),
                    Expanded(
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white70),
                      onPressed: onClear,
                    ),
                  ],
                ),
              ),
              
              // 键盘区域
              Expanded(
                child: Row(
                  children: [
                    // 数字键区域
                    Expanded(
                      flex: 3,
                      child: _buildNumberGrid(),
                    ),
                    // 操作键区域
                    SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Expanded(
                            child: _buildActionButton('+', onPressed: () => onInput('+')),
                          ),
                          Expanded(
                            child: _buildActionButton('-', onPressed: () => onInput('-')),
                          ),
                          Expanded(
                            flex: 2,
                            child: _buildConfirmButton(),
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

  Widget _buildNumberGrid() {
    return GridView.count(
      shrinkWrap: false, // 改为false，让GridView填充可用空间
      crossAxisCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2, // 调整宽高比
      children: [
        _buildNumberButton('7'),
        _buildNumberButton('8'),
        _buildNumberButton('9'),
        _buildNumberButton('4'),
        _buildNumberButton('5'),
        _buildNumberButton('6'),
        _buildNumberButton('1'),
        _buildNumberButton('2'),
        _buildNumberButton('3'),
        _buildNumberButton('0'),
        _buildNumberButton('.'),
        _buildActionButton(
          '⌫',
          fontSize: 20,
          onPressed: onBackspace,
        ),
      ],
    );
  }

  Widget _buildNumberButton(String text) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => onInput(text),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5), width: 0.5),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String text, {
    double fontSize = 18,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: const Color(0xFFF5F5F5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5), width: 0.5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Material(
      color: const Color(0xFFFF8B62),
      child: InkWell(
        onTap: onConfirm,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFF8B62),
          ),
          child: const Center(
            child: Text(
              '确定',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
