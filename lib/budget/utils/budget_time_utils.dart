import '../../flow/flow_time.dart';

/// 预算时间段工具类
class BudgetTimeUtils {
  /// 根据时间段类型和日期，生成时间段标识符
  /// 格式：year -> 'YYYY', quarter -> 'YYYY-Q', month -> 'YYYY-MM', week -> 'YYYY-Www', day -> 'YYYY-MM-DD'
  static String formatPeriod(DateTime date, FlowTimeUnit unit) {
    switch (unit) {
      case FlowTimeUnit.year:
        return '${date.year}';
      case FlowTimeUnit.quarter:
        final quarter = ((date.month - 1) ~/ 3) + 1;
        return '${date.year}-Q${quarter}';
      case FlowTimeUnit.month:
        return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}';
      case FlowTimeUnit.week:
        final week = _weekOfYear(date);
        return '${date.year}-W${week.toString().padLeft(2, '0')}';
      case FlowTimeUnit.day:
        return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      case FlowTimeUnit.time:
        // time不使用，默认用month
        return formatPeriod(date, FlowTimeUnit.month);
    }
  }

  /// 根据时间段类型和标识符，获取时间范围的开始和结束时间
  static ({DateTime start, DateTime end}) getDateRange(
      String period, FlowTimeUnit unit) {
    switch (unit) {
      case FlowTimeUnit.year:
        final year = int.parse(period);
        return (
          start: DateTime(year, 1, 1),
          end: DateTime(year, 12, 31, 23, 59, 59, 999),
        );
      case FlowTimeUnit.quarter:
        final parts = period.split('-Q');
        final year = int.parse(parts[0]);
        final quarter = int.parse(parts[1]);
        final startMonth = (quarter - 1) * 3 + 1;
        final endMonth = quarter * 3;
        return (
          start: DateTime(year, startMonth, 1),
          end: DateTime(year, endMonth + 1, 0, 23, 59, 59, 999),
        );
      case FlowTimeUnit.month:
        final parts = period.split('-');
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        return (
          start: DateTime(year, month, 1),
          end: DateTime(year, month + 1, 0, 23, 59, 59, 999),
        );
      case FlowTimeUnit.week:
        final parts = period.split('-W');
        final year = int.parse(parts[0]);
        final week = int.parse(parts[1]);
        final start = _dateFromWeekOfYear(year, week);
        final end = start.add(const Duration(days: 6));
        return (
          start: DateTime(start.year, start.month, start.day),
          end: DateTime(end.year, end.month, end.day, 23, 59, 59, 999),
        );
      case FlowTimeUnit.day:
        final parts = period.split('-');
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        return (
          start: DateTime(year, month, day),
          end: DateTime(year, month, day, 23, 59, 59, 999),
        );
      case FlowTimeUnit.time:
        return getDateRange(period, FlowTimeUnit.month);
    }
  }

  /// 简化：一年的第几周（非严格 ISO）
  static int _weekOfYear(DateTime date) {
    final first = DateTime(date.year, 1, 1);
    final diff = date.difference(first).inDays;
    return (diff ~/ 7) + 1;
  }

  /// 根据年份和周数获取日期（简化版本）
  static DateTime _dateFromWeekOfYear(int year, int week) {
    final first = DateTime(year, 1, 1);
    final daysToAdd = (week - 1) * 7;
    return first.add(Duration(days: daysToAdd));
  }

  /// 格式化时间段显示文本
  static String formatPeriodLabel(String period, FlowTimeUnit unit) {
    final range = getDateRange(period, unit);
    switch (unit) {
      case FlowTimeUnit.year:
        return '${range.start.year}年';
      case FlowTimeUnit.quarter:
        final quarter = ((range.start.month - 1) ~/ 3) + 1;
        return '${range.start.year}年第${quarter}季度';
      case FlowTimeUnit.month:
        return '${range.start.year}年${range.start.month}月';
      case FlowTimeUnit.week:
        return '${range.start.year}年第${_weekOfYear(range.start)}周';
      case FlowTimeUnit.day:
        return '${range.start.year}年${range.start.month}月${range.start.day}日';
      case FlowTimeUnit.time:
        return formatPeriodLabel(period, FlowTimeUnit.month);
    }
  }
}