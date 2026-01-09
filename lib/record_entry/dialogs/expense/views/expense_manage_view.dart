import 'package:flutter/material.dart';

import '../../../category/data/category_repo_drift.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/models/category_models.dart';
import '../../../category/pages/expense_primary_editor_page.dart';
import '../expense_sheet_config.dart';
import '../widgets/manage_bottom_bar.dart';
import '../widgets/manage_group_card.dart';
import '../widgets/manage_top_bar.dart';

class ExpenseManageView extends StatefulWidget {
  final ExpenseDialogConfig config;

  const ExpenseManageView({super.key, required this.config});

  @override
  State<ExpenseManageView> createState() => _ExpenseManageViewState();
}

class _ExpenseManageViewState extends State<ExpenseManageView> {
  late final CategoryRepository repo;

  List<CategoryGroup> groups = const [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    repo = CategoryRepoDrift(ledgerId: widget.config.ledgerId);
    _load();
  }

  Future<void> _load() async {
    final data = await repo.listExpenseGroups();
    if (!mounted) return;
    setState(() {
      groups = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ManageTopBar(
          title: '支出分类管理',
          enableSearch: widget.config.enableSearch,
          onClose: () => Navigator.of(context).pop(),
          onSearch: () {
            // TODO: 搜索（后续接入）
          },
        ),
        Expanded(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  itemCount: groups.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final g = groups[i];
                    return ManageGroupCard(
                      group: g,
                      enableReorder: widget.config.enableReorder,
                      enableCreate: widget.config.enableCreate,
                      onEditGroup: () {
                        // TODO: 编辑一级分类
                      },
                      onEditChild: (child) {
                        // TODO: 编辑二级分类
                      },
                      onCreateChild: () {
                        // TODO: 新建二级分类
                      },
                    );
                  },
                ),
        ),
        ManageBottomBar(
          enableCreate: widget.config.enableCreate,
          onBatch: () {
            // TODO: 批量操作
          },
          onCreatePrimary: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ExpensePrimaryCategoryEditorPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
