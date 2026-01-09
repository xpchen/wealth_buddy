import 'package:drift/drift.dart';
//lib\data\db\ledger\ledger_tables.dart
// import '../shared/converters.dart';

enum IconSource { material, cupertino, asset, upload }

enum CategoryType { expense, income }

enum AccountType {
  cash,
  debitCard,
  creditCard,
  ewallet,
  investment,
  loan,
  other,
}

enum PartyType {
  merchant,
  vendor,
  customer,
  employer,
  platform,
  bank,
  government,
  person,
  internal,
  other,
}

enum TxnType { expense, income, transfer }

enum TxnStatus { posted, voided, pending }

enum AttachmentPurpose { receipt, invoice, chat, other }

enum BudgetScopeType { total, category, account }

enum RolloverRule { none, carryOver, reset }

class LedgerInfo extends Table {
  TextColumn get ledgerId => text()();
  TextColumn get name => text()();
  TextColumn get currencyCode => text().withDefault(const Constant('CNY'))();
  TextColumn get timezone =>
      text().withDefault(const Constant('Asia/Shanghai'))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {ledgerId};
}

class IconResources extends Table {
  TextColumn get iconId => text()(); // UUID
  TextColumn get source =>
      text().map(const EnumNameConverter(IconSource.values))();
  IntColumn get codepoint => integer().nullable()();
  TextColumn get fontFamily => text().nullable()();
  TextColumn get assetPath => text().nullable()();
  TextColumn get mediaId =>
      text().nullable()(); // 跨库引用 media_file.media_id（不做FK）
  TextColumn get fgColor => text().nullable()();
  TextColumn get bgColor => text().nullable()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {iconId};
}

class Categories extends Table {
  TextColumn get categoryId => text()(); // UUID
  TextColumn get type =>
      text().map(const EnumNameConverter(CategoryType.values))();
  TextColumn get parentId => text().nullable()(); // 先不做自引用FK，避免迁移复杂
  TextColumn get name => text()();
  TextColumn get iconId =>
      text().nullable().references(IconResources, #iconId)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {categoryId};
}

class Accounts extends Table {
  TextColumn get accountId => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get accountType =>
      text().map(const EnumNameConverter(AccountType.values))();
  TextColumn get currencyCode => text().withDefault(const Constant('CNY'))();
  TextColumn get iconId =>
      text().nullable().references(IconResources, #iconId)();

  /// 金额单位：分（minor units）
  IntColumn get initialBalanceMinor =>
      integer().withDefault(const Constant(0))();
  IntColumn get initialBalanceAtMs => integer().nullable()();

  IntColumn get creditLimitMinor => integer().nullable()();
  IntColumn get billingDay => integer().nullable()();
  IntColumn get repaymentDay => integer().nullable()();

  TextColumn get note => text().nullable()();

  /// v2: 是否参与总资产/总负债/净资产等统计（默认参与）
  BoolColumn get includeInTotals =>
      boolean().withDefault(const Constant(true))();

  /// v2: 排序（越小越靠前）
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// 归档/隐藏（不在默认列表展示）
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {accountId};
}

class Parties extends Table {
  TextColumn get partyId => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get partyType =>
      text().map(const EnumNameConverter(PartyType.values))();
  TextColumn get iconId =>
      text().nullable().references(IconResources, #iconId)();
  TextColumn get phone => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get defaultCategoryId =>
      text().nullable().references(Categories, #categoryId)();
  TextColumn get defaultAccountId =>
      text().nullable().references(Accounts, #accountId)();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {partyId};
}

class Items extends Table {
  TextColumn get itemId => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get iconId =>
      text().nullable().references(IconResources, #iconId)();
  TextColumn get defaultCategoryId =>
      text().nullable().references(Categories, #categoryId)();
  TextColumn get defaultPartyId =>
      text().nullable().references(Parties, #partyId)();
  TextColumn get note => text().nullable()();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {itemId};
}

class Txns extends Table {
  TextColumn get txnId => text()(); // UUID
  TextColumn get txnType =>
      text().map(const EnumNameConverter(TxnType.values))();
  TextColumn get status => text()
      .map(const EnumNameConverter(TxnStatus.values))
      .withDefault(const Constant('posted'))();

  IntColumn get occurredAtMs => integer()();
  TextColumn get currencyCode => text().withDefault(const Constant('CNY'))();

  /// 金额单位：分（minor units），永远存正数
  IntColumn get amountMinor => integer()();
  @ReferenceName('txnsByAccount')
  // expense/income 用
  TextColumn get accountId =>
      text().nullable().references(Accounts, #accountId)();
  TextColumn get categoryId =>
      text().nullable().references(Categories, #categoryId)();
  TextColumn get partyId => text().nullable().references(Parties, #partyId)();
  TextColumn get itemId => text().nullable().references(Items, #itemId)();

  @ReferenceName('txnsByFromAccount')
  TextColumn get fromAccountId =>
      text().nullable().references(Accounts, #accountId)();
  @ReferenceName('txnsByToAccount')
  TextColumn get toAccountId =>
      text().nullable().references(Accounts, #accountId)();
  IntColumn get feeAmountMinor => integer().withDefault(const Constant(0))();
  @ReferenceName('txnsByFeeAccount')
  TextColumn get feeAccountId =>
      text().nullable().references(Accounts, #accountId)();

  TextColumn get note => text().nullable()();

  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {txnId};
}

class TxnAttachments extends Table {
  TextColumn get attachmentId => text()(); // UUID
  TextColumn get txnId => text().references(Txns, #txnId)();
  TextColumn get mediaId => text()(); // 跨库引用 media_files.media_id
  TextColumn get purpose => text()
      .map(const EnumNameConverter(AttachmentPurpose.values))
      .withDefault(const Constant('receipt'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {attachmentId};
}

class BudgetPlans extends Table {
  TextColumn get budgetId => text()(); // UUID
  TextColumn get month => text()(); // 'YYYY-MM'
  TextColumn get scopeType =>
      text().map(const EnumNameConverter(BudgetScopeType.values))();
  TextColumn get scopeId =>
      text().nullable()(); // total 时为空；category/account 时存ID

  /// 金额单位：分（minor units）
  IntColumn get amountMinor => integer()();

  TextColumn get rolloverRule => text()
      .map(const EnumNameConverter(RolloverRule.values))
      .withDefault(const Constant('none'))();
  TextColumn get note => text().nullable()();

  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {budgetId};
}
