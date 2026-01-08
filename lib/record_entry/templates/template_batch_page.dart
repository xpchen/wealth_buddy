import 'package:flutter/material.dart';
import '../data/template_memory_repo.dart';
import '../models/template_models.dart';

class TemplateBatchPage extends StatefulWidget {
  const TemplateBatchPage({super.key});

  @override
  State<TemplateBatchPage> createState() => _TemplateBatchPageState();
}

class _TemplateBatchPageState extends State<TemplateBatchPage> {
  final repo = TemplateMemoryRepo.instance;
  final Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    final items = repo.listAll();

    final allSelected = selected.length == items.length && items.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            '取消',
            style: TextStyle(color: Color(0xFF1F2329), fontSize: 16),
          ),
        ),
        title: const Text(
          '选择模板',
          style: TextStyle(
            color: Color(0xFF1F2329),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (allSelected) {
                  selected.clear();
                } else {
                  selected
                    ..clear()
                    ..addAll(items.map((e) => e.id));
                }
              });
            },
            child: const Text(
              '全选',
              style: TextStyle(
                color: Color(0xFFB87B5B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10),
              children: [
                _group(
                  '支出模板',
                  items.where((e) => e.type == TemplateType.expense).toList(),
                ),
                const SizedBox(height: 10),
                _group(
                  '收入模板',
                  items.where((e) => e.type == TemplateType.income).toList(),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              height: 86,
              color: Colors.white,
              child: InkWell(
                onTap: selected.isEmpty
                    ? null
                    : () {
                        setState(() {
                          repo.deleteByIds(selected);
                          selected.clear();
                        });
                      },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        size: 28,
                        color: Color(0xFF8A8F99),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '删除',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A8F99),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _group(String title, List<TemplateItem> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8A8F99),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: List.generate(list.length, (i) {
              final t = list[i];
              final checked = selected.contains(t.id);

              return Column(
                children: [
                  ListTile(
                    leading: Checkbox(
                      value: checked,
                      onChanged: (v) {
                        setState(() {
                          if (v == true) {
                            selected.add(t.id);
                          } else {
                            selected.remove(t.id);
                          }
                        });
                      },
                    ),
                    title: Text(
                      t.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2329),
                      ),
                    ),
                    subtitle: Text(
                      t.accountName,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A8F99),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.drag_handle,
                      color: Color(0xFFB0B6BF),
                    ),
                  ),
                  if (i != list.length - 1)
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
        ),
      ],
    );
  }
}
