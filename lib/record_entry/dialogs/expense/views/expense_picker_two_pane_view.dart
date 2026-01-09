import 'package:flutter/material.dart';

import '../../../category/data/category_repo_drift.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/models/category_models.dart';
import '../expense_sheet_config.dart';

class ExpensePickerTwoPaneView extends StatefulWidget {
  final ExpenseDialogConfig config;

  const ExpensePickerTwoPaneView({super.key, required this.config});

  @override
  State<ExpensePickerTwoPaneView> createState() =>
      _ExpensePickerTwoPaneViewState();
}

class _ExpensePickerTwoPaneViewState extends State<ExpensePickerTwoPaneView> {
  late final CategoryRepository repo;

  final ScrollController _rightScroll = ScrollController();
  final GlobalKey _rightListKey = GlobalKey();

  List<CategoryGroup> groups = const [];
  List<GlobalKey> _sectionKeys = const [];

  int activeIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    repo = CategoryRepoDrift(ledgerId: widget.config.ledgerId);
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
    final data = await repo.listExpenseGroups();
    if (!mounted) return;
    setState(() {
      groups = data;
      _sectionKeys = List.generate(data.length, (_) => GlobalKey());
      loading = false;
    });
  }

  void _handleRightScroll() {
    // 组数一般不多，直接算；后续可加节流
    _updateActiveIndexByScroll();
  }

  void _updateActiveIndexByScroll() {
    if (_sectionKeys.isEmpty) return;

    final rightCtx = _rightListKey.currentContext;
    if (rightCtx == null) return;

    final rightBox = rightCtx.findRenderObject();
    if (rightBox is! RenderBox) return;

    // 右侧内容区的“顶部锚点”（略微向下偏移，让标题吸顶更自然）
    final rightTopGlobalY = rightBox.localToGlobal(Offset.zero).dy + 8;

    int newIndex = activeIndex;

    // 找到最后一个“标题顶部 <= 锚点”的 section 作为当前 active
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
      alignment: 0.0, // 贴到顶部
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
                  /* TODO: 新增分类 */
                }
              : null,
          onEdit: () {
            // TODO: 这里后续你可以做：返回一个“打开管理”的信号给调用方
            // 现在先留空/或做提示
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('分类管理：待接入')));
          },
          onSearch: widget.config.enableSearch
              ? () {
                  /* TODO: 搜索 */
                }
              : null,
          onCollapse: () => Navigator.of(context).pop(),
        ),

        // 顶部与内容分割线（你说“明显分割线”）
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),

        Expanded(
          child: Row(
            children: [
              // 左侧：整列填充导航区
              Container(
                width: 120,
                color: const Color(0xFFF7F8FA),
                child: ListView.builder(
                  // padding: const EdgeInsets.symmetric(vertical: 10),
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

              // 左右分割线（你说左右区域有明显边界）
              const VerticalDivider(
                width: 1,
                thickness: 1,
                color: Color(0xFFF0F2F5),
              ),

              // 右侧：所有分组滚动内容
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
                          // 返回：一级 > 二级
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
        width: double.infinity, // 关键：整行铺满
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : const Color(0xFFF7F8FA),
          // 关键：圆角方向反过来（左侧圆角，右侧直边）
          borderRadius: selected
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )
              : BorderRadius.zero,
        ),
        child: Row(
          children: [
            // 可选：做一个很细的小“选中标记”（类似你截图左侧那条弧形/标记感）
            if (selected)
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: const Color(0xFFB87B5B),
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
              crossAxisCount: 4, // 贴近截图：一行四个（不够就左对齐）
              mainAxisSpacing: 14,
              crossAxisSpacing: 10,
              childAspectRatio: 0.86,
            ),
            itemBuilder: (_, idx) {
              final c = group.children[idx];
              return _CategoryCell(
                icon: c.icon,
                label: c.name,
                selected: false, // 选择后我们直接 pop 回传；若想展示选中态，可改成 state 记录
                onTap: () => onPick(c),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryCell extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryCell({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFFFFF4EA) : Colors.transparent;
    final border = selected
        ? const BorderSide(color: Color(0xFFF0D3BC))
        : BorderSide.none;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.fromBorderSide(border),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 26, color: const Color(0xFF1F2329)),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Color(0xFF1F2329)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
