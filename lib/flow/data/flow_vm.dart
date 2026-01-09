// lib/flow/data/flow_vm.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/db/ledger/ledger_tables.dart';

@immutable
class FlowTxnVM {
  final String txnId;
  final TxnType txnType;

  /// 毫秒时间戳
  final int occurredAtMs;

  /// 永远为正（数据库 amountMinor）
  final int amountMinor;

  /// 结合筛选账户后的“带符号金额”
  /// expense=-, income=+, transfer 视账户而定；全局模式 transfer=0
  final int signedAmountMinor;

  final String title;
  final String subTitle;

  final String? categoryId;
  final String? categoryName;
  final String? parentCategoryId;
  final String? parentCategoryName;

  // —— 二级分类 icon（流水行用它）——
  final IconSource? categoryIconSource;
  final int? categoryIconCodepoint;
  final String? categoryIconFontFamily;
  final String? categoryIconAssetPath;
  final String? categoryIconFgColor; // '#RRGGBB' 或 '#AARRGGBB'
  final String? categoryIconBgColor;

  final String? accountId;
  final String? accountName;

  final String? fromAccountId;
  final String? fromAccountName;
  final String? toAccountId;
  final String? toAccountName;

  final String? feeAccountId;
  final String? feeAccountName;

  final String? itemId;
  final String? itemName;

  final String? partyId;
  final String? partyName;
  final String? partyPhone;

  final String? note;

  const FlowTxnVM({
    required this.txnId,
    required this.txnType,
    required this.occurredAtMs,
    required this.amountMinor,
    required this.signedAmountMinor,
    required this.title,
    required this.subTitle,
    this.categoryId,
    this.categoryName,
    this.parentCategoryId,
    this.parentCategoryName,
    this.categoryIconSource,
    this.categoryIconCodepoint,
    this.categoryIconFontFamily,
    this.categoryIconAssetPath,
    this.categoryIconFgColor,
    this.categoryIconBgColor,
    this.accountId,
    this.accountName,
    this.fromAccountId,
    this.fromAccountName,
    this.toAccountId,
    this.toAccountName,
    this.feeAccountId,
    this.feeAccountName,
    this.itemId,
    this.itemName,
    this.partyId,
    this.partyName,
    this.partyPhone,
    this.note,
  });

  DateTime get occurredAt => DateTime.fromMillisecondsSinceEpoch(occurredAtMs);
  // 在 FlowTxnVM 类里新增
  int signedForAccount(String? contextAccountId) {
    // income/expense：和账户无关
    if (txnType == TxnType.income) return amountMinor;
    if (txnType == TxnType.expense) return -amountMinor;

    // transfer：全局或未知上下文 => 0
    if (contextAccountId == null || contextAccountId.isEmpty) return 0;

    var s = 0;
    if (fromAccountId == contextAccountId) s -= amountMinor;
    if (toAccountId == contextAccountId) s += amountMinor;

    // 如果你未来要把手续费也算进账户收支，可以在 VM 里补 feeAmountMinor 字段并在这里扣掉
    // if (feeAccountId == contextAccountId) s -= feeAmountMinor;

    return s;
  }

  /// 你 FlowPage 里用的 getter：分类图标（优先 material）
  IconData? get categoryIcon {
    if (categoryIconSource == IconSource.material &&
        categoryIconCodepoint != null) {
      return IconData(
        categoryIconCodepoint!,
        fontFamily: categoryIconFontFamily ?? 'MaterialIcons',
      );
    }
    // cupertino/asset/upload：这里返回 null，由 FlowPage 决定用 ImageIcon 或 fallback
    return null;
  }

  Color get categoryIconColor =>
      _parseColor(categoryIconFgColor) ?? const Color(0xFF1F2329);

  Color get categoryIconBg =>
      _parseColor(categoryIconBgColor) ?? const Color(0x00000000);

  static Color? _parseColor(String? v) {
    if (v == null) return null;
    var s = v.trim();
    if (s.isEmpty) return null;
    if (s.startsWith('#')) s = s.substring(1);

    // 支持 RRGGBB / AARRGGBB
    if (s.length == 6) s = 'FF$s';
    if (s.length != 8) return null;

    final n = int.tryParse(s, radix: 16);
    if (n == null) return null;
    return Color(n);
  }
}

@immutable
class FlowOption {
  final String id;
  final String name;
  const FlowOption(this.id, this.name);
}
