import 'package:flutter/material.dart';

import '../../../category/data/category_repo_mock.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/models/category_models.dart';
import '../income_sheet_config.dart';

class IncomePickerTwoPaneView extends StatefulWidget {
  final IncomeDialogConfig config;

  const IncomePickerTwoPaneView({super.key, required this.config});

  @override
  State<IncomePickerTwoPaneView> createState() =>
      _IncomePickerTwoPaneViewState();
}

class _IncomePickerTwoPaneViewState extends State<IncomePickerTwoPaneView> {
  final CategoryRepository repo = CategoryRepoMock();

  final ScrollController _rightScroll = ScrollController();
  final GlobalKey _rightListKey = GlobalKey();

  List<CategoryGroup> groups = const [];
  List<GlobalKey> _sectionKeys = const [];

  int activeIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    _rightScroll.addListener(_handleRightScroll);
  }

  @override
  void dispose() {
    _rightScroll.removeListener(_handleRightScroll);
    _rightScroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final data = await repo.listIncomeGroups();
    if (!mounted) return;
    setState(() {
      groups = data;
      _sectionKeys = List.generate(data.length, (_) => GlobalKey());
      loading = false;
    });
  }

  void _handleRightScroll() => _updateActiveIndexByScroll();

  void _updateActiveIndexByScroll() {
    if (_sectionKeys.isEmpty) return;

    final rightCtx = _rightListKey.currentContext;
    if (rightCtx == null) return;

    final rightBox = rightCtx.findRenderObject();
    if (rightBox is! RenderBox) return;

    final rightTopGlobalY = rightBox.localToGlobal(Offset.zero).dy + 8;

    int newIndex = activeIndex;
    for (int i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;

      final ro = ctx.findRenderObject();
      if (ro is! RenderBox) continue;

      final y = ro.localToGlobal(Offset.zero).dy;
      if (y <= rightTopGlobalY + 2) {
        newIndex = i;
      } else {
        break;
      }
    }

    if (newIndex != activeIndex && mounted) {
      setState(() => activeIndex = newIndex);
    }
  }

  Future<void> _scrollToSection(int index) async {
    if (index < 0 || index >= _sectionKeys.length) return;
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;

    setState(() => activeIndex = index);

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      alignment: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (groups.isEmpty) return const Center(child: Text('暂无分类'));

    return Column(
      children: [
        _TopToolsBar(
          onAdd: widget.config.enableCreate
              ? () {
                  /* TODO */
                }
              : null,
          onEdit: () {
            // TODO：后续接入“收入分类管理”
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('收入分类管理：待接入')));
          },
          onSearch: widget.config.enableSearch
              ? () {
                  /* TODO */
                }
              : null,
          onCollapse: () => Navigator.of(context).pop(),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
        Expanded(
          child: Row(
            children: [
              // 左侧导航
              Container(
                width: 120,
                color: const Color(0xFFF7F8FA),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: groups.length,
                  itemBuilder: (_, i) {
                    final g = groups[i];
                    final selected = i == activeIndex;
                    return _LeftNavItem(
                      icon: g.icon,
                      label: g.name,
                      selected: selected,
                      onTap: () => _scrollToSection(i),
                    );
                  },
                ),
              ),
              const VerticalDivider(
                width: 1,
                thickness: 1,
                color: Color(0xFFF0F2F5),
              ),
              // 右侧内容
              Expanded(
                child: Container(
                  key: _rightListKey,
                  color: Colors.white,
                  child: ListView.builder(
                    controller: _rightScroll,
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 18),
                    itemCount: groups.length,
                    itemBuilder: (_, i) {
                      final g = groups[i];
                      return _RightSection(
                        key: _sectionKeys[i],
                        group: g,
                        onPick: (child) {
                          Navigator.of(
                            context,
                          ).pop('${g.name} > ${child.name}');
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopToolsBar extends StatelessWidget {
  final VoidCallback? onAdd;
  final VoidCallback? onEdit;
  final VoidCallback? onSearch;
  final VoidCallback onCollapse;

  const _TopToolsBar({
    this.onAdd,
    this.onEdit,
    this.onSearch,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search_rounded),
          ),
          const Spacer(),
          IconButton(
            onPressed: onCollapse,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
    );
  }
}

class _LeftNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LeftNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : const Color(0xFFF7F8FA),
          borderRadius: selected
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )
              : BorderRadius.zero,
        ),
        child: Row(
          children: [
            if (selected)
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFE86A5E), // 收入主题色
                  borderRadius: BorderRadius.circular(99),
                ),
              )
            else
              const SizedBox(width: 4),
            const SizedBox(width: 10),
            Icon(
              icon,
              size: 18,
              color: selected
                  ? const Color(0xFF1F2329)
                  : const Color(0xFFB0B6BF),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? const Color(0xFF1F2329)
                      : const Color(0xFFB0B6BF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RightSection extends StatelessWidget {
  final CategoryGroup group;
  final ValueChanged<CategoryItem> onPick;

  const _RightSection({super.key, required this.group, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.name,
            style: const TextStyle(fontSize: 13, color: Color(0xFF8A8F99)),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: group.children.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 14,
              crossAxisSpacing: 10,
              childAspectRatio: 0.86,
            ),
            itemBuilder: (_, idx) {
              final c = group.children[idx];
              return InkWell(
                onTap: () => onPick(c),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(c.icon, size: 26, color: const Color(0xFF1F2329)),
                      const SizedBox(height: 8),
                      Text(
                        c.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1F2329),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
