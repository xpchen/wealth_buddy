import 'package:flutter/material.dart';
import '../data/template_memory_repo.dart';
import '../models/template_models.dart';
import 'template_batch_page.dart';
import 'template_edit_page.dart';

class TemplateHomeView extends StatefulWidget {
  final ValueChanged<TemplateItem> onUseTemplate;

  const TemplateHomeView({super.key, required this.onUseTemplate});

  @override
  State<TemplateHomeView> createState() => _TemplateHomeViewState();
}

class _TemplateHomeViewState extends State<TemplateHomeView> {
  final repo = TemplateMemoryRepo.instance;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7F9);

    final expense = repo.listByType(TemplateType.expense);
    final income = repo.listByType(TemplateType.income);

    return Container(
      color: bg,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 88),
            children: [
              _sectionTitle('支出模板'),
              _cardList(expense, amountColor: const Color(0xFF2CB7B0)),
              const SizedBox(height: 10),
              _sectionTitle('收入模板'),
              _cardList(income, amountColor: const Color(0xFFE86A5E)),
            ],
          ),

          // 底部操作条：批量操作 / 添加模板
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: Container(
                height: 66,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TemplateBatchPage(),
                          ),
                        );
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '批量操作',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2329),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '排序、删除',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8A8F99),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TemplateEditPage(),
                          ),
                        );
                        setState(() {});
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add, size: 20, color: Color(0xFF1F2329)),
                          SizedBox(width: 6),
                          Text(
                            '添加模板',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2329),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF8A8F99),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _cardList(List<TemplateItem> items, {required Color amountColor}) {
    return Container(
      color: Colors.white,
      child: Column(
        children: List.generate(items.length, (i) {
          final t = items[i];
          return Column(
            children: [
              _TemplateRow(
                item: t,
                amountColor: amountColor,
                onUse: () => widget.onUseTemplate(t),
              ),
              if (i != items.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 56,
                  color: Color(0xFFF0F2F5),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _TemplateRow extends StatelessWidget {
  final TemplateItem item;
  final Color amountColor;
  final VoidCallback onUse;

  const _TemplateRow({
    required this.item,
    required this.amountColor,
    required this.onUse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          _iconBox(item.type),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2329),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.amountText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.accountName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8A8F99),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onUse,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFEAD1C3)),
              ),
              child: const Text(
                '记一笔',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB87B5B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(TemplateType t) {
    final bg = (t == TemplateType.income)
        ? const Color(0xFFF2ECFF)
        : const Color(0xFFEAF7F6);
    final icon = (t == TemplateType.income)
        ? Icons.south_west
        : Icons.restaurant;
    final color = (t == TemplateType.income)
        ? const Color(0xFF6B5FD6)
        : const Color(0xFF2CB7B0);

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
