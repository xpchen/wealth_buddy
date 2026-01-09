import 'package:flutter/material.dart';
import '../../../category/data/category_repo_drift.dart';
import '../../../category/data/category_repository.dart';
import '../../../category/models/category_models.dart';
import '../transfer_sheet_config.dart';
// 推荐用 package 导入（把 wealth_buddy 换成你的 pubspec.yaml 里的 name）
import 'package:wealth_buddy/data/db/db_manager.dart';

class TransferAccountPickerView extends StatefulWidget {
  final TransferDialogConfig config;

  const TransferAccountPickerView({super.key, required this.config});

  @override
  State<TransferAccountPickerView> createState() =>
      _TransferAccountPickerViewState();
}

class _TransferAccountPickerViewState extends State<TransferAccountPickerView> {
  late final CategoryRepository repo;

  List<CategoryGroup> groups = const [];
  bool loading = true;

  /// accountId -> balanceMinor
  Map<String, int> _balanceMinorByAccountId = const {};

  /// accountId -> currencyCode
  Map<String, String> _currencyByAccountId = const {};

  @override
  void initState() {
    super.initState();
    repo = CategoryRepoDrift(ledgerId: widget.config.ledgerId);
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await repo.listTransferGroups();
      final pack = await _queryAccountBalances();

      if (!mounted) return;
      setState(() {
        groups = data;
        _balanceMinorByAccountId = pack.$1;
        _currencyByAccountId = pack.$2;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('加载账户失败：$e')));
    }
  }

  /// 返回：
  /// 1) accountId -> balanceMinor
  /// 2) accountId -> currencyCode
  Future<(Map<String, int>, Map<String, String>)>
  _queryAccountBalances() async {
    final db = await DbManager.instance.ledger(widget.config.ledgerId);

    // 1) 取账户初始余额/币种
    final q = db.select(db.accounts)
      ..where((t) => t.isDeleted.equals(false))
      ..where((t) => t.isArchived.equals(false));

    final accounts = await q.get();

    final initial = <String, int>{
      for (final a in accounts) a.accountId: a.initialBalanceMinor,
    };
    final currency = <String, String>{
      for (final a in accounts) a.accountId: a.currencyCode,
    };

    if (accounts.isEmpty) {
      return (<String, int>{}, <String, String>{});
    }

    // 2) 取交易净变动（income +, expense -, transfer in +, transfer out -）
    const sql = '''
SELECT account_id, SUM(delta) AS delta_minor
FROM (
  SELECT account_id AS account_id,
         CASE
           WHEN txn_type = 'income'  THEN amount_minor
           WHEN txn_type = 'expense' THEN -amount_minor
           ELSE 0
         END AS delta
  FROM txns
  WHERE is_deleted = 0 AND status = 'posted' AND account_id IS NOT NULL

  UNION ALL

  SELECT from_account_id AS account_id,
         -amount_minor AS delta
  FROM txns
  WHERE is_deleted = 0 AND status = 'posted' AND txn_type = 'transfer'
    AND from_account_id IS NOT NULL

  UNION ALL

  SELECT to_account_id AS account_id,
         amount_minor AS delta
  FROM txns
  WHERE is_deleted = 0 AND status = 'posted' AND txn_type = 'transfer'
    AND to_account_id IS NOT NULL
) x
GROUP BY account_id
''';

    final rows = await db.customSelect(sql).get();

    final delta = <String, int>{};
    for (final r in rows) {
      final id = r.read<String>('account_id');
      final d = r.read<int?>('delta_minor') ?? 0; // SUM 可能返回 null
      delta[id] = d;
    }

    // 3) 合成余额：initial + delta
    final balance = <String, int>{};
    for (final id in initial.keys) {
      balance[id] = (initial[id] ?? 0) + (delta[id] ?? 0);
    }

    return (balance, currency);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        _TopToolsBar(
          onAdd: widget.config.enableCreate
              ? () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('新增账户：待接入账户模块')));
                }
              : null,
          onEdit: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('编辑账户：待接入账户模块')));
          },
          onSearch: widget.config.enableSearch
              ? () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('搜索：待接入')));
                }
              : null,
          onCollapse: () => Navigator.of(context).pop(),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            itemCount: groups.length,
            itemBuilder: (_, gi) {
              final g = groups[gi];
              return _GroupSection(
                title: g.name,
                children: g.children,
                selectedName: widget.config.selectedName,
                balanceMinorByAccountId: _balanceMinorByAccountId,
                currencyByAccountId: _currencyByAccountId,
                onPick: (item) => Navigator.of(context).pop(item.name),
              );
            },
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

class _GroupSection extends StatelessWidget {
  final String title;
  final List<CategoryItem> children;
  final String? selectedName;

  final Map<String, int> balanceMinorByAccountId;
  final Map<String, String> currencyByAccountId;

  final ValueChanged<CategoryItem> onPick;

  const _GroupSection({
    required this.title,
    required this.children,
    required this.selectedName,
    required this.balanceMinorByAccountId,
    required this.currencyByAccountId,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    const textSub = Color(0xFF8A8F99);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: textSub,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...children.map((c) {
          final selected = (selectedName != null && c.name == selectedName);

          final minor = balanceMinorByAccountId[c.id] ?? 0;
          final cc = currencyByAccountId[c.id] ?? 'CNY';
          final balanceText = _formatMoney(minor, cc);

          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(c.icon, color: const Color(0xFF1F2329), size: 20),
            ),
            title: Text(
              c.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2329),
              ),
            ),
            subtitle: Text(
              balanceText,
              style: const TextStyle(fontSize: 14, color: Color(0xFFB0B6BF)),
            ),
            trailing: selected
                ? const Icon(Icons.check, color: Color(0xFFE6A15B))
                : null,
            onTap: () => onPick(c),
          );
        }),
        const SizedBox(height: 8),
      ],
    );
  }
}

String _formatMoney(int minor, String currency) {
  final neg = minor < 0;
  final v = minor.abs();
  final intPart = v ~/ 100;
  final dec = v % 100;

  String comma(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final pos = s.length - i;
      buf.write(s[i]);
      if (pos > 1 && pos % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }

  final symbol = switch (currency) {
    'CNY' => '¥',
    'USD' => '\$',
    'EUR' => '€',
    _ => '',
  };

  final numStr = '${comma(intPart)}.${dec.toString().padLeft(2, '0')}';
  final signed = neg ? '-$numStr' : numStr;

  return symbol.isEmpty ? '$signed $currency' : '$symbol$signed';
}
