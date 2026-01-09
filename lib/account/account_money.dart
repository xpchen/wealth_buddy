import 'dart:math';

/// Money helpers for minor units (e.g., CNY cents).
///
/// - Store money in "minor units" to avoid floating point errors.
/// - UI normally displays as "yuan.cents" with 2 decimals.
class Money {
  static String formatMinor(int minor) {
    final sign = minor < 0 ? '-' : '';
    final v = minor.abs();
    final yuan = v ~/ 100;
    final cents = v % 100;
    return '$sign$yuan.${cents.toString().padLeft(2, '0')}';
  }

  /// Parse input like:
  /// - "123" -> 12300
  /// - "123.4" -> 12340
  /// - "123.45" -> 12345
  /// - "-0.01" -> -1
  ///
  /// Throws [FormatException] for invalid input.
  static int parseToMinor(String input) {
    final s = input.trim().replaceAll(',', '');
    if (s.isEmpty) throw const FormatException('empty');
    final neg = s.startsWith('-');
    final raw = (neg || s.startsWith('+')) ? s.substring(1) : s;

    final parts = raw.split('.');
    if (parts.length > 2) throw const FormatException('invalid money');

    final int yuan;
    if (parts[0].isEmpty) {
      yuan = 0;
    } else {
      yuan = int.parse(parts[0]);
    }

    int cents = 0;
    if (parts.length == 2) {
      var frac = parts[1];
      if (frac.length > 2) {
        // Truncate extra decimals with rounding (3rd digit and beyond)
        final kept = frac.substring(0, 2);
        final rest = frac.substring(2);
        final base = int.parse(kept.padRight(2, '0'));
        // simple rounding based on the first dropped digit
        final roundUp = rest.isNotEmpty && int.tryParse(rest[0]) != null && int.parse(rest[0]) >= 5;
        cents = min(99, base + (roundUp ? 1 : 0));
      } else {
        cents = int.parse(frac.padRight(2, '0'));
      }
    }

    final minor = yuan * 100 + cents;
    return neg ? -minor : minor;
  }
}
