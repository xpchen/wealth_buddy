enum EntryKind { expense, income, transfer }

extension EntryKindLabel on EntryKind {
  String get label {
    switch (this) {
      case EntryKind.expense:
        return '支出';
      case EntryKind.income:
        return '收入';
      case EntryKind.transfer:
        return '转账';
    }
  }
}

class EntryDraft {
  final String amount;
  final String category;
  final String account;
  final String timeText;
  final String remark;

  const EntryDraft({
    required this.amount,
    required this.category,
    required this.account,
    required this.timeText,
    required this.remark,
  });

  factory EntryDraft.initialExpense() => const EntryDraft(
    amount: '0.00',
    category: '食品酒水  >  早午晚餐',
    account: '现金 (CNY)',
    timeText: '今天  01月07日',
    remark: '',
  );

  factory EntryDraft.initialIncome() => const EntryDraft(
    amount: '0.00',
    category: '工资收入',
    account: '银行卡',
    timeText: '今天  01月07日',
    remark: '',
  );

  factory EntryDraft.initialTransfer() => const EntryDraft(
    amount: '0.00',
    category: '账户互转',
    account: '从 现金 到 银行卡',
    timeText: '今天  01月07日',
    remark: '',
  );

  EntryDraft copyWith({
    String? amount,
    String? category,
    String? account,
    String? timeText,
    String? remark,
  }) {
    return EntryDraft(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      account: account ?? this.account,
      timeText: timeText ?? this.timeText,
      remark: remark ?? this.remark,
    );
  }
}
