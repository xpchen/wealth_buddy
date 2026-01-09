enum FlowType { income, expense, transfer, balanceAdjust }

class FlowRecord {
  final String id;
  final DateTime time;
  final FlowType type;

  /// 主标题：如“余额变更 / 早餐 / 工资”
  final String title;

  /// 次信息：如“现金 · 13:56”
  final String subTitle;

  /// 金额（正数存储；展示时根据类型加 + / -）
  final double amount;

  /// 账户（筛选用/展示用）
  final String accountName;

  const FlowRecord({
    required this.id,
    required this.time,
    required this.type,
    required this.title,
    required this.subTitle,
    required this.amount,
    required this.accountName,
  });
}
