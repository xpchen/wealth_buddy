// lib/record_entry/domain/money_parser.dart
class MoneyParser {
  /// "12.3" -> 1230, "0.00" -> 0, "12." -> 1200
  static int toMinor(String input) {
    var s = input.trim();
    if (s.isEmpty) return 0;

    // 去掉千分位
    s = s.replaceAll(',', '');

    // 处理 ".5"
    if (s.startsWith('.')) s = '0$s';

    // 只保留正数逻辑（你的键盘也没做负数落库）
    if (s.startsWith('-')) s = s.substring(1);

    final parts = s.split('.');
    final intPart = int.tryParse(parts[0].isEmpty ? '0' : parts[0]) ?? 0;

    var dec = (parts.length > 1) ? parts[1] : '0';
    if (dec.length > 2) dec = dec.substring(0, 2);
    dec = dec.padRight(2, '0');
    final decPart = int.tryParse(dec) ?? 0;

    return intPart * 100 + decPart;
  }

  /// "现金 (CNY)" -> "现金"
  static String normalizeAccountName(String name) {
    final s = name.trim();
    final idx = s.indexOf('(');
    if (idx <= 0) return s;
    return s.substring(0, idx).trim();
  }

  /// "食品酒水  >  早午晚餐" -> ["食品酒水","早午晚餐"]
  static List<String> splitCategoryPath(String path) {
    return path
        .split('>')
        .map((e) => e.replaceAll(' ', '').trim()) // 去掉多余空格
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
