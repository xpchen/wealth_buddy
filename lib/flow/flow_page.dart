// lib/flow/flow_page.dart
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wealth_buddy/flow/flow_edit_page.dart';

import '../data/db/ledger/ledger_tables.dart';
import 'data/flow_repository.dart';
import 'data/flow_vm.dart';
import 'flow_time.dart';
import 'ui/flow_palette.dart';

enum _GroupBy { categoryLevel1, categoryLevel2, time, account }

enum _GroupKind { category, time, account }

class FlowPage extends StatefulWidget {
  final String ledgerId;
  const FlowPage({super.key, required this.ledgerId});

  @override
  State<FlowPage> createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {
  late Future<FlowRepository> _repoFuture;

  // 默认：一级分类（符合你最新要求）
  _GroupBy _groupBy = _GroupBy.categoryLevel1;

  // “时间”tab默认显示“时间”，只有真正选择年/季/月/周/天时才进入按时间分组
  FlowTimeUnit _timeUnit = FlowTimeUnit.time;

  // 过滤（项目还保留筛选；账户不再筛选，改为分组）
  String? _itemId;

  // 展开/收缩状态
  final Map<String, bool> _expanded = {};

  @override
  void initState() {
    super.initState();
    _repoFuture = FlowRepository.open(widget.ledgerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlowPalette.bg,
      body: FutureBuilder<FlowRepository>(
        future: _repoFuture,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final repo = snap.data!;

          return StreamBuilder<List<FlowTxnVM>>(
            stream: repo.watchTxns(itemId: _itemId, limit: 1000),
            builder: (context, s) {
              final txns = s.data ?? const <FlowTxnVM>[];

              // 顶部汇总：按“全部流水”的口径：income/expense 统计；transfer 不计入
              final topSum = _sumIncomeExpense(txns);
              final groups = _buildGroups(txns);

              return Stack(
                children: [
                  _buildHeaderBg(),
                  SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        _buildTopBar(context),
                        _buildHeaderSummary(topSum),
                        const SizedBox(height: 10),
                        Expanded(child: _buildRoundedBody(groups)),
                        _buildFilterBar(repo),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeaderBg() {
    return SizedBox.expand(
      child: Image.asset(
        'assets/images/flow_header.jpg',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5C6B73), Color(0xFF9AA6AC)],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 2),
          const Text(
            '全部流水',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.white),
          ),
          IconButton(
            onPressed: _onPickTimeUnit,
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSummary(_InOutSum sum) {
    String m(int minor) => (minor / 100.0).toStringAsFixed(2);

    final balanceMinor = sum.inMinor - sum.outMinor;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            m(balanceMinor),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 44,
              height: 1.0,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Color(0x66000000), blurRadius: 8)],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '收入 ${m(sum.inMinor)}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 12, color: Colors.white30),
              const SizedBox(width: 12),
              Text(
                '支出 ${m(sum.outMinor)}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedBody(List<_FlowGroup> groups) {
    return Container(
      decoration: const BoxDecoration(
        color: FlowPalette.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        itemCount: groups.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final g = groups[index];
          final expanded = _expanded[g.key] ?? true;

          return _GroupCard(
            kind: g.kind,
            titleLine1: g.titleLine1,
            titleLine2: g.titleLine2,
            sum: g.sum,
            expanded: expanded,
            onToggle: () => setState(() => _expanded[g.key] = !expanded),
            body: expanded ? _buildGroupBody(g) : const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildGroupBody(_FlowGroup g) {
    final items = g.items;

    // “按时间分组 + 天” 时，组本身就是某一天，不再插入“01月09日 周五”
    final needDayHeader =
        !(_groupBy == _GroupBy.time && _timeUnit == FlowTimeUnit.day);

    final widgets = <Widget>[];
    DateTime? lastDay;

    for (final vm in items) {
      final d = vm.occurredAt;
      final day = DateTime(d.year, d.month, d.day);

      if (needDayHeader && (lastDay == null || day != lastDay)) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Text(
              FlowTime.dayHeader(day),
              style: const TextStyle(
                color: FlowPalette.subText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
        lastDay = day;
      }

      widgets.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              final changed = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (_) => FlowEditPage(
                    ledgerId: widget.ledgerId,
                    entryId: vm.txnId, // 关键：流水的主键ID（确保 FlowTxnVM 有 id 字段）
                  ),
                ),
              );

              if (changed == true && mounted) {
                // 你这里是 StreamBuilder(repo.watchTxns...)，通常不需要手动 reload，
                // 但为了兼容你未来不是 stream 的场景，可以触发一次 rebuild：
                setState(() {});
              }
            },
            child: _TxnRow(
              vm: vm,
              // 账户分组时，需要知道“当前组账户”，用于 transfer 的进/出方向与金额符号
              contextAccountId: g.contextAccountId,
            ),
          ),
        ),
      );
    }

    return Column(children: widgets);
  }

  Widget _buildFilterBar(FlowRepository repo) {
    final timeLabel = FlowTime.unitLabel(_timeUnit); // 默认“时间”
    final catLabel = _groupBy == _GroupBy.categoryLevel2 ? '二级分类' : '一级分类';

    return SafeArea(
      top: false,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: FlowPalette.divider)),
        ),
        child: Row(
          children: [
            Expanded(
              child: _FilterTab(
                label: timeLabel,
                active: _groupBy == _GroupBy.time,
                onTap: _onPickTimeUnit,
              ),
            ),
            Expanded(
              child: _FilterTab(
                label: catLabel,
                active:
                    _groupBy == _GroupBy.categoryLevel1 ||
                    _groupBy == _GroupBy.categoryLevel2,
                onTap: _onPickCategoryLevel,
              ),
            ),
            // 账户：不弹选择，直接分组展示所有账户
            Expanded(
              child: _FilterTab(
                label: '账户',
                active: _groupBy == _GroupBy.account,
                onTap: () {
                  setState(() {
                    _groupBy = _GroupBy.account;
                    // 账户分组不需要选择账户，这里不做 accountId filter
                  });
                },
              ),
            ),
            Expanded(
              child: _FilterTab(
                label: '项目',
                active: _itemId != null && _itemId!.isNotEmpty,
                onTap: () => _onPickItem(repo),
              ),
            ),
            Expanded(
              child: _FilterTab(label: '其它', active: false, onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- BottomSheet helpers（规避 mouse_tracker 断言） --------------------

  void _afterSheetCloseSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(fn);
    });
  }

  void _onPickTimeUnit() {
    _showSheet(
      title: '时间',
      options: const [
        ('年', FlowTimeUnit.year),
        ('季', FlowTimeUnit.quarter),
        ('月', FlowTimeUnit.month),
        ('周', FlowTimeUnit.week),
        ('天', FlowTimeUnit.day),
      ],
      onPick: (u) {
        Navigator.of(context).pop();
        _afterSheetCloseSetState(() {
          _timeUnit = u;
          _groupBy = _GroupBy.time;
        });
      },
    );
  }

  void _onPickCategoryLevel() {
    _showSheet(
      title: '分类',
      options: const [
        ('一级分类', _GroupBy.categoryLevel1),
        ('二级分类', _GroupBy.categoryLevel2),
      ],
      onPick: (v) {
        Navigator.of(context).pop();
        _afterSheetCloseSetState(() {
          _groupBy = v;
        });
      },
    );
  }

  void _onPickItem(FlowRepository repo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                '项目',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              StreamBuilder<List<FlowOption>>(
                stream: repo.watchItems(),
                builder: (context, s) {
                  final list = s.data ?? const <FlowOption>[];
                  return Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          title: const Text('全部项目'),
                          onTap: () {
                            Navigator.of(context).pop();
                            _afterSheetCloseSetState(() => _itemId = null);
                          },
                        ),
                        ...list.map((e) {
                          return ListTile(
                            title: Text(e.name),
                            trailing: _itemId == e.id
                                ? const Icon(
                                    Icons.check,
                                    color: FlowPalette.active,
                                  )
                                : null,
                            onTap: () {
                              Navigator.of(context).pop();
                              _afterSheetCloseSetState(() => _itemId = e.id);
                            },
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSheet<T>({
    required String title,
    required List<(String, T)> options,
    required ValueChanged<T> onPick,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              ...options.map((e) {
                return ListTile(title: Text(e.$1), onTap: () => onPick(e.$2));
              }),
            ],
          ),
        );
      },
    );
  }

  // -------------------- Grouping --------------------

  List<_FlowGroup> _buildGroups(List<FlowTxnVM> txns) {
    if (txns.isEmpty) return const [];

    switch (_groupBy) {
      case _GroupBy.time:
        final map = <FlowTimeKey, List<FlowTxnVM>>{};
        for (final vm in txns) {
          // 选择“时间”后 _timeUnit 必定是 year/quarter/month/week/day
          final key = FlowTimeKey.from(vm.occurredAt, _timeUnit);
          (map[key] ??= []).add(vm);
        }

        final keys = map.keys.toList();
        keys.sort((a, b) {
          int maxMs(FlowTimeKey k) =>
              map[k]!.map((e) => e.occurredAtMs).reduce(math.max);
          return maxMs(b).compareTo(maxMs(a));
        });

        return keys.map((k) {
          final title = FlowTime.groupTitle(k);
          final items = map[k]!
            ..sort((a, b) => b.occurredAtMs.compareTo(a.occurredAtMs));
          return _FlowGroup(
            key: 'time_${k.hashCode}',
            kind: _GroupKind.time,
            titleLine1: title.line1,
            titleLine2: title.line2,
            items: items,
            sum: _sumIncomeExpense(items), // 时间汇总仍按收入/支出（transfer 不计）
            contextAccountId: null,
          );
        }).toList();

      case _GroupBy.account:
        // 账户：不需要选择，直接每个账户一组；transfer 同时出现在 from/to 两个账户组中
        final map = <String, List<FlowTxnVM>>{};
        final nameMap = <String, String>{};

        void addTo(String? id, String? name, FlowTxnVM vm) {
          if (id == null || id.isEmpty) return;
          (map[id] ??= []).add(vm);
          if (name != null && name.isNotEmpty) nameMap[id] = name;
        }

        for (final vm in txns) {
          if (vm.txnType == TxnType.transfer) {
            addTo(vm.fromAccountId, vm.fromAccountName, vm);
            addTo(vm.toAccountId, vm.toAccountName, vm);
          } else {
            addTo(vm.accountId, vm.accountName, vm);
          }
        }

        final keys = map.keys.toList();
        keys.sort((a, b) {
          int maxMs(String k) =>
              map[k]!.map((e) => e.occurredAtMs).reduce(math.max);
          return maxMs(b).compareTo(maxMs(a));
        });

        return keys.map((accId) {
          final items = map[accId]!
            ..sort((a, b) => b.occurredAtMs.compareTo(a.occurredAtMs));
          return _FlowGroup(
            key: 'acc_$accId',
            kind: _GroupKind.account,
            titleLine1: nameMap[accId] ?? '账户',
            titleLine2: null,
            items: items,
            // 账户汇总：按“净流入/流入/流出”，transfer 计入
            sum: _sumAccountInOut(items, accId),
            contextAccountId: accId,
          );
        }).toList();

      case _GroupBy.categoryLevel1:
      case _GroupBy.categoryLevel2:
        // 一级：大类；二级：小类 + subtitle=大类
        final map = <String, List<FlowTxnVM>>{};
        final name1 = <String, String>{};
        final name2 = <String, String?>{};

        for (final vm in txns) {
          final isLv2 = _groupBy == _GroupBy.categoryLevel2;

          // 无分类：单独一组
          if (vm.categoryName == null || vm.categoryName!.isEmpty) {
            const k = '_uncat';
            (map[k] ??= []).add(vm);
            name1[k] = '无分类';
            name2[k] = '无分类';
            continue;
          }

          final key = isLv2
              ? (vm.categoryId ?? '_uncat')
              : (vm.parentCategoryId ?? vm.categoryId ?? '_uncat');

          final title = isLv2
              ? (vm.categoryName ?? '无分类')
              : (vm.parentCategoryName ?? vm.categoryName ?? '无分类');

          final subtitle = isLv2 ? (vm.parentCategoryName ?? '') : null;

          (map[key] ??= []).add(vm);
          name1[key] = title;
          name2[key] = (subtitle != null && subtitle.trim().isNotEmpty)
              ? subtitle
              : null;
        }

        final keys = map.keys.toList();
        keys.sort((a, b) {
          int maxMs(String k) =>
              map[k]!.map((e) => e.occurredAtMs).reduce(math.max);
          return maxMs(b).compareTo(maxMs(a));
        });

        return keys.map((k) {
          final items = map[k]!
            ..sort((a, b) => b.occurredAtMs.compareTo(a.occurredAtMs));
          return _FlowGroup(
            key: 'cat_$k',
            kind: _GroupKind.category,
            titleLine1: name1[k] ?? '',
            titleLine2: name2[k],
            items: items,
            // 分类汇总：收入/支出（transfer 不计），符合你截图“余额变更不算收入支出”
            sum: _sumIncomeExpense(items),
            contextAccountId: null,
          );
        }).toList();
    }
  }
}

// -------------------- UI widgets --------------------

class _GroupCard extends StatelessWidget {
  final _GroupKind kind;
  final String titleLine1;
  final String? titleLine2;
  final _InOutSum sum;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget body;

  const _GroupCard({
    required this.kind,
    required this.titleLine1,
    required this.titleLine2,
    required this.sum,
    required this.expanded,
    required this.onToggle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    String m(int minor) => (minor / 100.0).toStringAsFixed(2);

    final netMinor = sum.inMinor - sum.outMinor;

    final left = () {
      if (kind == _GroupKind.time) {
        // 时间：数字大（2026年 / 9日 等）
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleLine1,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: FlowPalette.text,
              ),
            ),
            if (titleLine2 != null) ...[
              const SizedBox(height: 2),
              Text(
                titleLine2!,
                style: const TextStyle(
                  fontSize: 12,
                  color: FlowPalette.subText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        );
      }

      // 分类/账户：常规标题
      if (titleLine2 == null) {
        return Text(
          titleLine1,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: FlowPalette.text,
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleLine1,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: FlowPalette.text,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            titleLine2!,
            style: const TextStyle(
              fontSize: 12,
              color: FlowPalette.subText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }();

    final headerLabelNet = kind == _GroupKind.account ? '净流入 ' : '结余 ';
    final headerLabelIn = kind == _GroupKind.account ? '流入 ' : '收入 ';
    final headerLabelOut = kind == _GroupKind.account ? '流出 ' : '支出 ';

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
              onTap: onToggle,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Row(
                  children: [
                    Expanded(child: left),
                    const SizedBox(width: 10),
                    // 右侧统计：加宽度约束 + FittedBox 防止溢出
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 170),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                headerLabelNet,
                                style: const TextStyle(
                                  color: FlowPalette.subText,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                m(netMinor),
                                style: const TextStyle(
                                  color: FlowPalette.text,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '$headerLabelIn${m(sum.inMinor)}',
                                  style: TextStyle(
                                    color: kind == _GroupKind.account
                                        ? FlowPalette.income
                                        : FlowPalette.income,
                                    fontSize: 12,
                                  ),
                                ),
                                const Text(
                                  '  |  ',
                                  style: TextStyle(color: FlowPalette.divider),
                                ),
                                Text(
                                  '$headerLabelOut${m(sum.outMinor)}',
                                  style: TextStyle(
                                    color: kind == _GroupKind.account
                                        ? FlowPalette.expense
                                        : FlowPalette.expense,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFFB0B6BF),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: FlowPalette.divider),
            AnimatedCrossFade(
              firstChild: body,
              secondChild: const SizedBox.shrink(),
              crossFadeState: expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 180),
            ),
          ],
        ),
      ),
    );
  }
}

class _TxnRow extends StatelessWidget {
  final FlowTxnVM vm;

  /// 账户分组时，传当前“组账户”，用于 transfer 方向与金额符号
  final String? contextAccountId;

  const _TxnRow({required this.vm, required this.contextAccountId});

  @override
  Widget build(BuildContext context) {
    String m(int minor) => (minor / 100.0).toStringAsFixed(2);

    final signed = vm.signedForAccount(contextAccountId);

    // 你截图里支出金额一般不显示负号，这里按“符号可控”：
    final showSign = false;
    final amountText = showSign
        ? (signed > 0
              ? '+${m(signed)}'
              : signed < 0
              ? '-${m(-signed)}'
              : m(vm.amountMinor))
        : m(signed.abs() == 0 ? vm.amountMinor : signed.abs());

    final amountColor = () {
      if (signed > 0) return FlowPalette.income;
      if (signed < 0) return FlowPalette.expense;
      return FlowPalette.subText;
    }();

    // 关键：流水行图标永远用“二级分类图标”
    final iconData = vm.categoryIcon ?? _fallbackIcon(vm.txnType);
    final iconColor = vm.categoryIconColor ?? _fallbackColor(vm.txnType);

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 18, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vm.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: FlowPalette.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  vm.subTitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: FlowPalette.subText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            amountText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  static IconData _fallbackIcon(TxnType t) {
    switch (t) {
      case TxnType.income:
        return Icons.arrow_downward;
      case TxnType.expense:
        return Icons.arrow_upward;
      case TxnType.transfer:
        return Icons.swap_horiz;
    }
  }

  static Color _fallbackColor(TxnType t) {
    switch (t) {
      case TxnType.income:
        return FlowPalette.income;
      case TxnType.expense:
        return FlowPalette.expense;
      case TxnType.transfer:
        return FlowPalette.transfer;
    }
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? FlowPalette.active : FlowPalette.subText;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 56,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 2),
              Icon(Icons.arrow_drop_down, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- sums & models --------------------

class _InOutSum {
  final int inMinor; // 账户：流入；分类/时间：收入
  final int outMinor; // 账户：流出；分类/时间：支出
  const _InOutSum({required this.inMinor, required this.outMinor});
}

// 分类/时间/顶部：只统计 income/expense，transfer 不计
_InOutSum _sumIncomeExpense(List<FlowTxnVM> txns) {
  var income = 0;
  var expense = 0;
  for (final vm in txns) {
    if (vm.txnType == TxnType.income) income += vm.amountMinor;
    if (vm.txnType == TxnType.expense) expense += vm.amountMinor;
  }
  return _InOutSum(inMinor: income, outMinor: expense);
}

// 账户：统计 transfer 的进/出
_InOutSum _sumAccountInOut(List<FlowTxnVM> txns, String accountId) {
  var inMinor = 0;
  var outMinor = 0;

  for (final vm in txns) {
    final signed = vm.signedForAccount(accountId);
    if (signed > 0) inMinor += signed;
    if (signed < 0) outMinor += (-signed);
  }
  return _InOutSum(inMinor: inMinor, outMinor: outMinor);
}

class _FlowGroup {
  final String key;
  final _GroupKind kind;
  final String titleLine1;
  final String? titleLine2;
  final List<FlowTxnVM> items;
  final _InOutSum sum;

  /// 仅账户分组使用：用于 transfer 方向
  final String? contextAccountId;

  const _FlowGroup({
    required this.key,
    required this.kind,
    required this.titleLine1,
    required this.titleLine2,
    required this.items,
    required this.sum,
    required this.contextAccountId,
  });
}
