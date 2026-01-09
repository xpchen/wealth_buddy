// lib/flow/flow_time.dart
enum FlowTimeUnit { time, year, quarter, month, week, day }

class FlowTimeTitle {
  final String line1;
  final String? line2;
  const FlowTimeTitle(this.line1, this.line2);
}

class FlowTimeKey {
  final FlowTimeUnit unit;
  final int y;
  final int q; // 1-4
  final int m; // 1-12
  final int w; // 1-53 (简化周序号)
  final int d; // 1-31

  const FlowTimeKey._(this.unit, this.y, this.q, this.m, this.w, this.d);

  factory FlowTimeKey.from(DateTime dt, FlowTimeUnit unit) {
    switch (unit) {
      case FlowTimeUnit.year:
        return FlowTimeKey._(unit, dt.year, 0, 0, 0, 0);
      case FlowTimeUnit.quarter:
        final q = ((dt.month - 1) ~/ 3) + 1;
        return FlowTimeKey._(unit, dt.year, q, 0, 0, 0);
      case FlowTimeUnit.month:
        return FlowTimeKey._(unit, dt.year, 0, dt.month, 0, 0);
      case FlowTimeUnit.week:
        final w = _weekOfYear(dt);
        return FlowTimeKey._(unit, dt.year, 0, 0, w, 0);
      case FlowTimeUnit.day:
        return FlowTimeKey._(unit, dt.year, 0, dt.month, 0, dt.day);
      case FlowTimeUnit.time:
        // “time” 不用于分组，只用于底部默认显示
        return FlowTimeKey._(unit, dt.year, 0, dt.month, 0, dt.day);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is FlowTimeKey &&
      other.unit == unit &&
      other.y == y &&
      other.q == q &&
      other.m == m &&
      other.w == w &&
      other.d == d;

  @override
  int get hashCode => Object.hash(unit, y, q, m, w, d);
}

class FlowTime {
  static String unitLabel(FlowTimeUnit u) {
    switch (u) {
      case FlowTimeUnit.time:
        return '时间';
      case FlowTimeUnit.year:
        return '年';
      case FlowTimeUnit.quarter:
        return '季';
      case FlowTimeUnit.month:
        return '月';
      case FlowTimeUnit.week:
        return '周';
      case FlowTimeUnit.day:
        return '天';
    }
  }

  static FlowTimeTitle groupTitle(FlowTimeKey k) {
    switch (k.unit) {
      case FlowTimeUnit.year:
        return FlowTimeTitle('${k.y}年', null);
      case FlowTimeUnit.quarter:
        return FlowTimeTitle('${k.q}季', '${k.y}');
      case FlowTimeUnit.month:
        return FlowTimeTitle('${k.m}月', '${k.y}');
      case FlowTimeUnit.week:
        return FlowTimeTitle('${k.w}周', '${k.y}');
      case FlowTimeUnit.day:
        // 你截图：line1=“9日”，line2=“2026.1”
        return FlowTimeTitle('${k.d}日', '${k.y}.${k.m}');
      case FlowTimeUnit.time:
        return FlowTimeTitle('${k.y}年', null);
    }
  }

  static String dayHeader(DateTime day) {
    final mm = day.month.toString().padLeft(2, '0');
    final dd = day.day.toString().padLeft(2, '0');
    return '${mm}月${dd}日 ${_weekdayZh(day.weekday)}';
  }

  static String _weekdayZh(int weekday) {
    switch (weekday) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
        return '周日';
      default:
        return '';
    }
  }
}

// 简化：一年的第几周（非严格 ISO，但用于 UI 分组足够）
// 若你后续要严格 ISO 周，我再给你替换算法即可。
int _weekOfYear(DateTime date) {
  final first = DateTime(date.year, 1, 1);
  final diff = date.difference(first).inDays;
  return (diff ~/ 7) + 1;
}
