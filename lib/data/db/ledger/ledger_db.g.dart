// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_db.dart';

// ignore_for_file: type=lint
class $LedgerInfoTable extends LedgerInfo
    with TableInfo<$LedgerInfoTable, LedgerInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ledgerIdMeta = const VerificationMeta(
    'ledgerId',
  );
  @override
  late final GeneratedColumn<String> ledgerId = GeneratedColumn<String>(
    'ledger_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CNY'),
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Asia/Shanghai'),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    ledgerId,
    name,
    currencyCode,
    timezone,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ledger_id')) {
      context.handle(
        _ledgerIdMeta,
        ledgerId.isAcceptableOrUnknown(data['ledger_id']!, _ledgerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ledgerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ledgerId};
  @override
  LedgerInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerInfoData(
      ledgerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $LedgerInfoTable createAlias(String alias) {
    return $LedgerInfoTable(attachedDatabase, alias);
  }
}

class LedgerInfoData extends DataClass implements Insertable<LedgerInfoData> {
  final String ledgerId;
  final String name;
  final String currencyCode;
  final String timezone;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const LedgerInfoData({
    required this.ledgerId,
    required this.name,
    required this.currencyCode,
    required this.timezone,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ledger_id'] = Variable<String>(ledgerId);
    map['name'] = Variable<String>(name);
    map['currency_code'] = Variable<String>(currencyCode);
    map['timezone'] = Variable<String>(timezone);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  LedgerInfoCompanion toCompanion(bool nullToAbsent) {
    return LedgerInfoCompanion(
      ledgerId: Value(ledgerId),
      name: Value(name),
      currencyCode: Value(currencyCode),
      timezone: Value(timezone),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory LedgerInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerInfoData(
      ledgerId: serializer.fromJson<String>(json['ledgerId']),
      name: serializer.fromJson<String>(json['name']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      timezone: serializer.fromJson<String>(json['timezone']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ledgerId': serializer.toJson<String>(ledgerId),
      'name': serializer.toJson<String>(name),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'timezone': serializer.toJson<String>(timezone),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  LedgerInfoData copyWith({
    String? ledgerId,
    String? name,
    String? currencyCode,
    String? timezone,
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => LedgerInfoData(
    ledgerId: ledgerId ?? this.ledgerId,
    name: name ?? this.name,
    currencyCode: currencyCode ?? this.currencyCode,
    timezone: timezone ?? this.timezone,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  LedgerInfoData copyWithCompanion(LedgerInfoCompanion data) {
    return LedgerInfoData(
      ledgerId: data.ledgerId.present ? data.ledgerId.value : this.ledgerId,
      name: data.name.present ? data.name.value : this.name,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerInfoData(')
          ..write('ledgerId: $ledgerId, ')
          ..write('name: $name, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('timezone: $timezone, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ledgerId,
    name,
    currencyCode,
    timezone,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerInfoData &&
          other.ledgerId == this.ledgerId &&
          other.name == this.name &&
          other.currencyCode == this.currencyCode &&
          other.timezone == this.timezone &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class LedgerInfoCompanion extends UpdateCompanion<LedgerInfoData> {
  final Value<String> ledgerId;
  final Value<String> name;
  final Value<String> currencyCode;
  final Value<String> timezone;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const LedgerInfoCompanion({
    this.ledgerId = const Value.absent(),
    this.name = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.timezone = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LedgerInfoCompanion.insert({
    required String ledgerId,
    required String name,
    this.currencyCode = const Value.absent(),
    this.timezone = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ledgerId = Value(ledgerId),
       name = Value(name),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<LedgerInfoData> custom({
    Expression<String>? ledgerId,
    Expression<String>? name,
    Expression<String>? currencyCode,
    Expression<String>? timezone,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ledgerId != null) 'ledger_id': ledgerId,
      if (name != null) 'name': name,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (timezone != null) 'timezone': timezone,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LedgerInfoCompanion copyWith({
    Value<String>? ledgerId,
    Value<String>? name,
    Value<String>? currencyCode,
    Value<String>? timezone,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return LedgerInfoCompanion(
      ledgerId: ledgerId ?? this.ledgerId,
      name: name ?? this.name,
      currencyCode: currencyCode ?? this.currencyCode,
      timezone: timezone ?? this.timezone,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ledgerId.present) {
      map['ledger_id'] = Variable<String>(ledgerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerInfoCompanion(')
          ..write('ledgerId: $ledgerId, ')
          ..write('name: $name, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('timezone: $timezone, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IconResourcesTable extends IconResources
    with TableInfo<$IconResourcesTable, IconResource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IconResourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<IconSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<IconSource>($IconResourcesTable.$convertersource);
  static const VerificationMeta _codepointMeta = const VerificationMeta(
    'codepoint',
  );
  @override
  late final GeneratedColumn<int> codepoint = GeneratedColumn<int>(
    'codepoint',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assetPathMeta = const VerificationMeta(
    'assetPath',
  );
  @override
  late final GeneratedColumn<String> assetPath = GeneratedColumn<String>(
    'asset_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fgColorMeta = const VerificationMeta(
    'fgColor',
  );
  @override
  late final GeneratedColumn<String> fgColor = GeneratedColumn<String>(
    'fg_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bgColorMeta = const VerificationMeta(
    'bgColor',
  );
  @override
  late final GeneratedColumn<String> bgColor = GeneratedColumn<String>(
    'bg_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    iconId,
    source,
    codepoint,
    fontFamily,
    assetPath,
    mediaId,
    fgColor,
    bgColor,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'icon_resources';
  @override
  VerificationContext validateIntegrity(
    Insertable<IconResource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    } else if (isInserting) {
      context.missing(_iconIdMeta);
    }
    if (data.containsKey('codepoint')) {
      context.handle(
        _codepointMeta,
        codepoint.isAcceptableOrUnknown(data['codepoint']!, _codepointMeta),
      );
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    }
    if (data.containsKey('asset_path')) {
      context.handle(
        _assetPathMeta,
        assetPath.isAcceptableOrUnknown(data['asset_path']!, _assetPathMeta),
      );
    }
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    }
    if (data.containsKey('fg_color')) {
      context.handle(
        _fgColorMeta,
        fgColor.isAcceptableOrUnknown(data['fg_color']!, _fgColorMeta),
      );
    }
    if (data.containsKey('bg_color')) {
      context.handle(
        _bgColorMeta,
        bgColor.isAcceptableOrUnknown(data['bg_color']!, _bgColorMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {iconId};
  @override
  IconResource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IconResource(
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      )!,
      source: $IconResourcesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      codepoint: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}codepoint'],
      ),
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      ),
      assetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_path'],
      ),
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      ),
      fgColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fg_color'],
      ),
      bgColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bg_color'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $IconResourcesTable createAlias(String alias) {
    return $IconResourcesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<IconSource, String, String> $convertersource =
      const EnumNameConverter(IconSource.values);
}

class IconResource extends DataClass implements Insertable<IconResource> {
  final String iconId;
  final IconSource source;
  final int? codepoint;
  final String? fontFamily;
  final String? assetPath;
  final String? mediaId;
  final String? fgColor;
  final String? bgColor;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const IconResource({
    required this.iconId,
    required this.source,
    this.codepoint,
    this.fontFamily,
    this.assetPath,
    this.mediaId,
    this.fgColor,
    this.bgColor,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['icon_id'] = Variable<String>(iconId);
    {
      map['source'] = Variable<String>(
        $IconResourcesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || codepoint != null) {
      map['codepoint'] = Variable<int>(codepoint);
    }
    if (!nullToAbsent || fontFamily != null) {
      map['font_family'] = Variable<String>(fontFamily);
    }
    if (!nullToAbsent || assetPath != null) {
      map['asset_path'] = Variable<String>(assetPath);
    }
    if (!nullToAbsent || mediaId != null) {
      map['media_id'] = Variable<String>(mediaId);
    }
    if (!nullToAbsent || fgColor != null) {
      map['fg_color'] = Variable<String>(fgColor);
    }
    if (!nullToAbsent || bgColor != null) {
      map['bg_color'] = Variable<String>(bgColor);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  IconResourcesCompanion toCompanion(bool nullToAbsent) {
    return IconResourcesCompanion(
      iconId: Value(iconId),
      source: Value(source),
      codepoint: codepoint == null && nullToAbsent
          ? const Value.absent()
          : Value(codepoint),
      fontFamily: fontFamily == null && nullToAbsent
          ? const Value.absent()
          : Value(fontFamily),
      assetPath: assetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(assetPath),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
      fgColor: fgColor == null && nullToAbsent
          ? const Value.absent()
          : Value(fgColor),
      bgColor: bgColor == null && nullToAbsent
          ? const Value.absent()
          : Value(bgColor),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory IconResource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IconResource(
      iconId: serializer.fromJson<String>(json['iconId']),
      source: $IconResourcesTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      codepoint: serializer.fromJson<int?>(json['codepoint']),
      fontFamily: serializer.fromJson<String?>(json['fontFamily']),
      assetPath: serializer.fromJson<String?>(json['assetPath']),
      mediaId: serializer.fromJson<String?>(json['mediaId']),
      fgColor: serializer.fromJson<String?>(json['fgColor']),
      bgColor: serializer.fromJson<String?>(json['bgColor']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'iconId': serializer.toJson<String>(iconId),
      'source': serializer.toJson<String>(
        $IconResourcesTable.$convertersource.toJson(source),
      ),
      'codepoint': serializer.toJson<int?>(codepoint),
      'fontFamily': serializer.toJson<String?>(fontFamily),
      'assetPath': serializer.toJson<String?>(assetPath),
      'mediaId': serializer.toJson<String?>(mediaId),
      'fgColor': serializer.toJson<String?>(fgColor),
      'bgColor': serializer.toJson<String?>(bgColor),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  IconResource copyWith({
    String? iconId,
    IconSource? source,
    Value<int?> codepoint = const Value.absent(),
    Value<String?> fontFamily = const Value.absent(),
    Value<String?> assetPath = const Value.absent(),
    Value<String?> mediaId = const Value.absent(),
    Value<String?> fgColor = const Value.absent(),
    Value<String?> bgColor = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => IconResource(
    iconId: iconId ?? this.iconId,
    source: source ?? this.source,
    codepoint: codepoint.present ? codepoint.value : this.codepoint,
    fontFamily: fontFamily.present ? fontFamily.value : this.fontFamily,
    assetPath: assetPath.present ? assetPath.value : this.assetPath,
    mediaId: mediaId.present ? mediaId.value : this.mediaId,
    fgColor: fgColor.present ? fgColor.value : this.fgColor,
    bgColor: bgColor.present ? bgColor.value : this.bgColor,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  IconResource copyWithCompanion(IconResourcesCompanion data) {
    return IconResource(
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      source: data.source.present ? data.source.value : this.source,
      codepoint: data.codepoint.present ? data.codepoint.value : this.codepoint,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      assetPath: data.assetPath.present ? data.assetPath.value : this.assetPath,
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      fgColor: data.fgColor.present ? data.fgColor.value : this.fgColor,
      bgColor: data.bgColor.present ? data.bgColor.value : this.bgColor,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IconResource(')
          ..write('iconId: $iconId, ')
          ..write('source: $source, ')
          ..write('codepoint: $codepoint, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('assetPath: $assetPath, ')
          ..write('mediaId: $mediaId, ')
          ..write('fgColor: $fgColor, ')
          ..write('bgColor: $bgColor, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    iconId,
    source,
    codepoint,
    fontFamily,
    assetPath,
    mediaId,
    fgColor,
    bgColor,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IconResource &&
          other.iconId == this.iconId &&
          other.source == this.source &&
          other.codepoint == this.codepoint &&
          other.fontFamily == this.fontFamily &&
          other.assetPath == this.assetPath &&
          other.mediaId == this.mediaId &&
          other.fgColor == this.fgColor &&
          other.bgColor == this.bgColor &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class IconResourcesCompanion extends UpdateCompanion<IconResource> {
  final Value<String> iconId;
  final Value<IconSource> source;
  final Value<int?> codepoint;
  final Value<String?> fontFamily;
  final Value<String?> assetPath;
  final Value<String?> mediaId;
  final Value<String?> fgColor;
  final Value<String?> bgColor;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const IconResourcesCompanion({
    this.iconId = const Value.absent(),
    this.source = const Value.absent(),
    this.codepoint = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.fgColor = const Value.absent(),
    this.bgColor = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IconResourcesCompanion.insert({
    required String iconId,
    required IconSource source,
    this.codepoint = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.assetPath = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.fgColor = const Value.absent(),
    this.bgColor = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : iconId = Value(iconId),
       source = Value(source),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<IconResource> custom({
    Expression<String>? iconId,
    Expression<String>? source,
    Expression<int>? codepoint,
    Expression<String>? fontFamily,
    Expression<String>? assetPath,
    Expression<String>? mediaId,
    Expression<String>? fgColor,
    Expression<String>? bgColor,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (iconId != null) 'icon_id': iconId,
      if (source != null) 'source': source,
      if (codepoint != null) 'codepoint': codepoint,
      if (fontFamily != null) 'font_family': fontFamily,
      if (assetPath != null) 'asset_path': assetPath,
      if (mediaId != null) 'media_id': mediaId,
      if (fgColor != null) 'fg_color': fgColor,
      if (bgColor != null) 'bg_color': bgColor,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IconResourcesCompanion copyWith({
    Value<String>? iconId,
    Value<IconSource>? source,
    Value<int?>? codepoint,
    Value<String?>? fontFamily,
    Value<String?>? assetPath,
    Value<String?>? mediaId,
    Value<String?>? fgColor,
    Value<String?>? bgColor,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return IconResourcesCompanion(
      iconId: iconId ?? this.iconId,
      source: source ?? this.source,
      codepoint: codepoint ?? this.codepoint,
      fontFamily: fontFamily ?? this.fontFamily,
      assetPath: assetPath ?? this.assetPath,
      mediaId: mediaId ?? this.mediaId,
      fgColor: fgColor ?? this.fgColor,
      bgColor: bgColor ?? this.bgColor,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $IconResourcesTable.$convertersource.toSql(source.value),
      );
    }
    if (codepoint.present) {
      map['codepoint'] = Variable<int>(codepoint.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (assetPath.present) {
      map['asset_path'] = Variable<String>(assetPath.value);
    }
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (fgColor.present) {
      map['fg_color'] = Variable<String>(fgColor.value);
    }
    if (bgColor.present) {
      map['bg_color'] = Variable<String>(bgColor.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IconResourcesCompanion(')
          ..write('iconId: $iconId, ')
          ..write('source: $source, ')
          ..write('codepoint: $codepoint, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('assetPath: $assetPath, ')
          ..write('mediaId: $mediaId, ')
          ..write('fgColor: $fgColor, ')
          ..write('bgColor: $bgColor, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategoryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CategoryType>($CategoriesTable.$convertertype);
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES icon_resources (icon_id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    categoryId,
    type,
    parentId,
    name,
    iconId,
    sortOrder,
    isHidden,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      type: $CategoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryType, String, String> $convertertype =
      const EnumNameConverter(CategoryType.values);
}

class Category extends DataClass implements Insertable<Category> {
  final String categoryId;
  final CategoryType type;
  final String? parentId;
  final String name;
  final String? iconId;
  final int sortOrder;
  final bool isHidden;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const Category({
    required this.categoryId,
    required this.type,
    this.parentId,
    required this.name,
    this.iconId,
    required this.sortOrder,
    required this.isHidden,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<String>(categoryId);
    {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<String>(iconId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_hidden'] = Variable<bool>(isHidden);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      categoryId: Value(categoryId),
      type: Value(type),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      iconId: iconId == null && nullToAbsent
          ? const Value.absent()
          : Value(iconId),
      sortOrder: Value(sortOrder),
      isHidden: Value(isHidden),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      categoryId: serializer.fromJson<String>(json['categoryId']),
      type: $CategoriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      parentId: serializer.fromJson<String?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      iconId: serializer.fromJson<String?>(json['iconId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<String>(categoryId),
      'type': serializer.toJson<String>(
        $CategoriesTable.$convertertype.toJson(type),
      ),
      'parentId': serializer.toJson<String?>(parentId),
      'name': serializer.toJson<String>(name),
      'iconId': serializer.toJson<String?>(iconId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isHidden': serializer.toJson<bool>(isHidden),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Category copyWith({
    String? categoryId,
    CategoryType? type,
    Value<String?> parentId = const Value.absent(),
    String? name,
    Value<String?> iconId = const Value.absent(),
    int? sortOrder,
    bool? isHidden,
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => Category(
    categoryId: categoryId ?? this.categoryId,
    type: type ?? this.type,
    parentId: parentId.present ? parentId.value : this.parentId,
    name: name ?? this.name,
    iconId: iconId.present ? iconId.value : this.iconId,
    sortOrder: sortOrder ?? this.sortOrder,
    isHidden: isHidden ?? this.isHidden,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      type: data.type.present ? data.type.value : this.type,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('categoryId: $categoryId, ')
          ..write('type: $type, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isHidden: $isHidden, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    categoryId,
    type,
    parentId,
    name,
    iconId,
    sortOrder,
    isHidden,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.categoryId == this.categoryId &&
          other.type == this.type &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.iconId == this.iconId &&
          other.sortOrder == this.sortOrder &&
          other.isHidden == this.isHidden &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> categoryId;
  final Value<CategoryType> type;
  final Value<String?> parentId;
  final Value<String> name;
  final Value<String?> iconId;
  final Value<int> sortOrder;
  final Value<bool> isHidden;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.categoryId = const Value.absent(),
    this.type = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.iconId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String categoryId,
    required CategoryType type,
    this.parentId = const Value.absent(),
    required String name,
    this.iconId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isHidden = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : categoryId = Value(categoryId),
       type = Value(type),
       name = Value(name),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Category> custom({
    Expression<String>? categoryId,
    Expression<String>? type,
    Expression<String>? parentId,
    Expression<String>? name,
    Expression<String>? iconId,
    Expression<int>? sortOrder,
    Expression<bool>? isHidden,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (type != null) 'type': type,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (iconId != null) 'icon_id': iconId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isHidden != null) 'is_hidden': isHidden,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? categoryId,
    Value<CategoryType>? type,
    Value<String?>? parentId,
    Value<String>? name,
    Value<String?>? iconId,
    Value<int>? sortOrder,
    Value<bool>? isHidden,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      iconId: iconId ?? this.iconId,
      sortOrder: sortOrder ?? this.sortOrder,
      isHidden: isHidden ?? this.isHidden,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type.value),
      );
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('type: $type, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isHidden: $isHidden, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, String> accountType =
      GeneratedColumn<String>(
        'account_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AccountType>($AccountsTable.$converteraccountType);
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CNY'),
  );
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES icon_resources (icon_id)',
    ),
  );
  static const VerificationMeta _initialBalanceMinorMeta =
      const VerificationMeta('initialBalanceMinor');
  @override
  late final GeneratedColumn<int> initialBalanceMinor = GeneratedColumn<int>(
    'initial_balance_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _initialBalanceAtMsMeta =
      const VerificationMeta('initialBalanceAtMs');
  @override
  late final GeneratedColumn<int> initialBalanceAtMs = GeneratedColumn<int>(
    'initial_balance_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditLimitMinorMeta = const VerificationMeta(
    'creditLimitMinor',
  );
  @override
  late final GeneratedColumn<int> creditLimitMinor = GeneratedColumn<int>(
    'credit_limit_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingDayMeta = const VerificationMeta(
    'billingDay',
  );
  @override
  late final GeneratedColumn<int> billingDay = GeneratedColumn<int>(
    'billing_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repaymentDayMeta = const VerificationMeta(
    'repaymentDay',
  );
  @override
  late final GeneratedColumn<int> repaymentDay = GeneratedColumn<int>(
    'repayment_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _includeInTotalsMeta = const VerificationMeta(
    'includeInTotals',
  );
  @override
  late final GeneratedColumn<bool> includeInTotals = GeneratedColumn<bool>(
    'include_in_totals',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_in_totals" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    name,
    accountType,
    currencyCode,
    iconId,
    initialBalanceMinor,
    initialBalanceAtMs,
    creditLimitMinor,
    billingDay,
    repaymentDay,
    note,
    includeInTotals,
    sortOrder,
    isArchived,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    }
    if (data.containsKey('initial_balance_minor')) {
      context.handle(
        _initialBalanceMinorMeta,
        initialBalanceMinor.isAcceptableOrUnknown(
          data['initial_balance_minor']!,
          _initialBalanceMinorMeta,
        ),
      );
    }
    if (data.containsKey('initial_balance_at_ms')) {
      context.handle(
        _initialBalanceAtMsMeta,
        initialBalanceAtMs.isAcceptableOrUnknown(
          data['initial_balance_at_ms']!,
          _initialBalanceAtMsMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit_minor')) {
      context.handle(
        _creditLimitMinorMeta,
        creditLimitMinor.isAcceptableOrUnknown(
          data['credit_limit_minor']!,
          _creditLimitMinorMeta,
        ),
      );
    }
    if (data.containsKey('billing_day')) {
      context.handle(
        _billingDayMeta,
        billingDay.isAcceptableOrUnknown(data['billing_day']!, _billingDayMeta),
      );
    }
    if (data.containsKey('repayment_day')) {
      context.handle(
        _repaymentDayMeta,
        repaymentDay.isAcceptableOrUnknown(
          data['repayment_day']!,
          _repaymentDayMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('include_in_totals')) {
      context.handle(
        _includeInTotalsMeta,
        includeInTotals.isAcceptableOrUnknown(
          data['include_in_totals']!,
          _includeInTotalsMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      accountType: $AccountsTable.$converteraccountType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}account_type'],
        )!,
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      ),
      initialBalanceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_balance_minor'],
      )!,
      initialBalanceAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_balance_at_ms'],
      ),
      creditLimitMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit_minor'],
      ),
      billingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_day'],
      ),
      repaymentDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repayment_day'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      includeInTotals: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_in_totals'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountType, String, String> $converteraccountType =
      const EnumNameConverter(AccountType.values);
}

class Account extends DataClass implements Insertable<Account> {
  final String accountId;
  final String name;
  final AccountType accountType;
  final String currencyCode;
  final String? iconId;

  /// 金额单位：分（minor units）
  final int initialBalanceMinor;
  final int? initialBalanceAtMs;
  final int? creditLimitMinor;
  final int? billingDay;
  final int? repaymentDay;
  final String? note;

  /// v2: 是否参与总资产/总负债/净资产等统计（默认参与）
  final bool includeInTotals;

  /// v2: 排序（越小越靠前）
  final int sortOrder;

  /// 归档/隐藏（不在默认列表展示）
  final bool isArchived;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const Account({
    required this.accountId,
    required this.name,
    required this.accountType,
    required this.currencyCode,
    this.iconId,
    required this.initialBalanceMinor,
    this.initialBalanceAtMs,
    this.creditLimitMinor,
    this.billingDay,
    this.repaymentDay,
    this.note,
    required this.includeInTotals,
    required this.sortOrder,
    required this.isArchived,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['name'] = Variable<String>(name);
    {
      map['account_type'] = Variable<String>(
        $AccountsTable.$converteraccountType.toSql(accountType),
      );
    }
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<String>(iconId);
    }
    map['initial_balance_minor'] = Variable<int>(initialBalanceMinor);
    if (!nullToAbsent || initialBalanceAtMs != null) {
      map['initial_balance_at_ms'] = Variable<int>(initialBalanceAtMs);
    }
    if (!nullToAbsent || creditLimitMinor != null) {
      map['credit_limit_minor'] = Variable<int>(creditLimitMinor);
    }
    if (!nullToAbsent || billingDay != null) {
      map['billing_day'] = Variable<int>(billingDay);
    }
    if (!nullToAbsent || repaymentDay != null) {
      map['repayment_day'] = Variable<int>(repaymentDay);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['include_in_totals'] = Variable<bool>(includeInTotals);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      accountId: Value(accountId),
      name: Value(name),
      accountType: Value(accountType),
      currencyCode: Value(currencyCode),
      iconId: iconId == null && nullToAbsent
          ? const Value.absent()
          : Value(iconId),
      initialBalanceMinor: Value(initialBalanceMinor),
      initialBalanceAtMs: initialBalanceAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(initialBalanceAtMs),
      creditLimitMinor: creditLimitMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimitMinor),
      billingDay: billingDay == null && nullToAbsent
          ? const Value.absent()
          : Value(billingDay),
      repaymentDay: repaymentDay == null && nullToAbsent
          ? const Value.absent()
          : Value(repaymentDay),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      includeInTotals: Value(includeInTotals),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      accountId: serializer.fromJson<String>(json['accountId']),
      name: serializer.fromJson<String>(json['name']),
      accountType: $AccountsTable.$converteraccountType.fromJson(
        serializer.fromJson<String>(json['accountType']),
      ),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      iconId: serializer.fromJson<String?>(json['iconId']),
      initialBalanceMinor: serializer.fromJson<int>(
        json['initialBalanceMinor'],
      ),
      initialBalanceAtMs: serializer.fromJson<int?>(json['initialBalanceAtMs']),
      creditLimitMinor: serializer.fromJson<int?>(json['creditLimitMinor']),
      billingDay: serializer.fromJson<int?>(json['billingDay']),
      repaymentDay: serializer.fromJson<int?>(json['repaymentDay']),
      note: serializer.fromJson<String?>(json['note']),
      includeInTotals: serializer.fromJson<bool>(json['includeInTotals']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'name': serializer.toJson<String>(name),
      'accountType': serializer.toJson<String>(
        $AccountsTable.$converteraccountType.toJson(accountType),
      ),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'iconId': serializer.toJson<String?>(iconId),
      'initialBalanceMinor': serializer.toJson<int>(initialBalanceMinor),
      'initialBalanceAtMs': serializer.toJson<int?>(initialBalanceAtMs),
      'creditLimitMinor': serializer.toJson<int?>(creditLimitMinor),
      'billingDay': serializer.toJson<int?>(billingDay),
      'repaymentDay': serializer.toJson<int?>(repaymentDay),
      'note': serializer.toJson<String?>(note),
      'includeInTotals': serializer.toJson<bool>(includeInTotals),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Account copyWith({
    String? accountId,
    String? name,
    AccountType? accountType,
    String? currencyCode,
    Value<String?> iconId = const Value.absent(),
    int? initialBalanceMinor,
    Value<int?> initialBalanceAtMs = const Value.absent(),
    Value<int?> creditLimitMinor = const Value.absent(),
    Value<int?> billingDay = const Value.absent(),
    Value<int?> repaymentDay = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? includeInTotals,
    int? sortOrder,
    bool? isArchived,
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => Account(
    accountId: accountId ?? this.accountId,
    name: name ?? this.name,
    accountType: accountType ?? this.accountType,
    currencyCode: currencyCode ?? this.currencyCode,
    iconId: iconId.present ? iconId.value : this.iconId,
    initialBalanceMinor: initialBalanceMinor ?? this.initialBalanceMinor,
    initialBalanceAtMs: initialBalanceAtMs.present
        ? initialBalanceAtMs.value
        : this.initialBalanceAtMs,
    creditLimitMinor: creditLimitMinor.present
        ? creditLimitMinor.value
        : this.creditLimitMinor,
    billingDay: billingDay.present ? billingDay.value : this.billingDay,
    repaymentDay: repaymentDay.present ? repaymentDay.value : this.repaymentDay,
    note: note.present ? note.value : this.note,
    includeInTotals: includeInTotals ?? this.includeInTotals,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      name: data.name.present ? data.name.value : this.name,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      initialBalanceMinor: data.initialBalanceMinor.present
          ? data.initialBalanceMinor.value
          : this.initialBalanceMinor,
      initialBalanceAtMs: data.initialBalanceAtMs.present
          ? data.initialBalanceAtMs.value
          : this.initialBalanceAtMs,
      creditLimitMinor: data.creditLimitMinor.present
          ? data.creditLimitMinor.value
          : this.creditLimitMinor,
      billingDay: data.billingDay.present
          ? data.billingDay.value
          : this.billingDay,
      repaymentDay: data.repaymentDay.present
          ? data.repaymentDay.value
          : this.repaymentDay,
      note: data.note.present ? data.note.value : this.note,
      includeInTotals: data.includeInTotals.present
          ? data.includeInTotals.value
          : this.includeInTotals,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('accountType: $accountType, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('iconId: $iconId, ')
          ..write('initialBalanceMinor: $initialBalanceMinor, ')
          ..write('initialBalanceAtMs: $initialBalanceAtMs, ')
          ..write('creditLimitMinor: $creditLimitMinor, ')
          ..write('billingDay: $billingDay, ')
          ..write('repaymentDay: $repaymentDay, ')
          ..write('note: $note, ')
          ..write('includeInTotals: $includeInTotals, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    name,
    accountType,
    currencyCode,
    iconId,
    initialBalanceMinor,
    initialBalanceAtMs,
    creditLimitMinor,
    billingDay,
    repaymentDay,
    note,
    includeInTotals,
    sortOrder,
    isArchived,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.accountId == this.accountId &&
          other.name == this.name &&
          other.accountType == this.accountType &&
          other.currencyCode == this.currencyCode &&
          other.iconId == this.iconId &&
          other.initialBalanceMinor == this.initialBalanceMinor &&
          other.initialBalanceAtMs == this.initialBalanceAtMs &&
          other.creditLimitMinor == this.creditLimitMinor &&
          other.billingDay == this.billingDay &&
          other.repaymentDay == this.repaymentDay &&
          other.note == this.note &&
          other.includeInTotals == this.includeInTotals &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> accountId;
  final Value<String> name;
  final Value<AccountType> accountType;
  final Value<String> currencyCode;
  final Value<String?> iconId;
  final Value<int> initialBalanceMinor;
  final Value<int?> initialBalanceAtMs;
  final Value<int?> creditLimitMinor;
  final Value<int?> billingDay;
  final Value<int?> repaymentDay;
  final Value<String?> note;
  final Value<bool> includeInTotals;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const AccountsCompanion({
    this.accountId = const Value.absent(),
    this.name = const Value.absent(),
    this.accountType = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.iconId = const Value.absent(),
    this.initialBalanceMinor = const Value.absent(),
    this.initialBalanceAtMs = const Value.absent(),
    this.creditLimitMinor = const Value.absent(),
    this.billingDay = const Value.absent(),
    this.repaymentDay = const Value.absent(),
    this.note = const Value.absent(),
    this.includeInTotals = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String accountId,
    required String name,
    required AccountType accountType,
    this.currencyCode = const Value.absent(),
    this.iconId = const Value.absent(),
    this.initialBalanceMinor = const Value.absent(),
    this.initialBalanceAtMs = const Value.absent(),
    this.creditLimitMinor = const Value.absent(),
    this.billingDay = const Value.absent(),
    this.repaymentDay = const Value.absent(),
    this.note = const Value.absent(),
    this.includeInTotals = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       name = Value(name),
       accountType = Value(accountType),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Account> custom({
    Expression<String>? accountId,
    Expression<String>? name,
    Expression<String>? accountType,
    Expression<String>? currencyCode,
    Expression<String>? iconId,
    Expression<int>? initialBalanceMinor,
    Expression<int>? initialBalanceAtMs,
    Expression<int>? creditLimitMinor,
    Expression<int>? billingDay,
    Expression<int>? repaymentDay,
    Expression<String>? note,
    Expression<bool>? includeInTotals,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (name != null) 'name': name,
      if (accountType != null) 'account_type': accountType,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (iconId != null) 'icon_id': iconId,
      if (initialBalanceMinor != null)
        'initial_balance_minor': initialBalanceMinor,
      if (initialBalanceAtMs != null)
        'initial_balance_at_ms': initialBalanceAtMs,
      if (creditLimitMinor != null) 'credit_limit_minor': creditLimitMinor,
      if (billingDay != null) 'billing_day': billingDay,
      if (repaymentDay != null) 'repayment_day': repaymentDay,
      if (note != null) 'note': note,
      if (includeInTotals != null) 'include_in_totals': includeInTotals,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? accountId,
    Value<String>? name,
    Value<AccountType>? accountType,
    Value<String>? currencyCode,
    Value<String?>? iconId,
    Value<int>? initialBalanceMinor,
    Value<int?>? initialBalanceAtMs,
    Value<int?>? creditLimitMinor,
    Value<int?>? billingDay,
    Value<int?>? repaymentDay,
    Value<String?>? note,
    Value<bool>? includeInTotals,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      accountType: accountType ?? this.accountType,
      currencyCode: currencyCode ?? this.currencyCode,
      iconId: iconId ?? this.iconId,
      initialBalanceMinor: initialBalanceMinor ?? this.initialBalanceMinor,
      initialBalanceAtMs: initialBalanceAtMs ?? this.initialBalanceAtMs,
      creditLimitMinor: creditLimitMinor ?? this.creditLimitMinor,
      billingDay: billingDay ?? this.billingDay,
      repaymentDay: repaymentDay ?? this.repaymentDay,
      note: note ?? this.note,
      includeInTotals: includeInTotals ?? this.includeInTotals,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(
        $AccountsTable.$converteraccountType.toSql(accountType.value),
      );
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (initialBalanceMinor.present) {
      map['initial_balance_minor'] = Variable<int>(initialBalanceMinor.value);
    }
    if (initialBalanceAtMs.present) {
      map['initial_balance_at_ms'] = Variable<int>(initialBalanceAtMs.value);
    }
    if (creditLimitMinor.present) {
      map['credit_limit_minor'] = Variable<int>(creditLimitMinor.value);
    }
    if (billingDay.present) {
      map['billing_day'] = Variable<int>(billingDay.value);
    }
    if (repaymentDay.present) {
      map['repayment_day'] = Variable<int>(repaymentDay.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (includeInTotals.present) {
      map['include_in_totals'] = Variable<bool>(includeInTotals.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('accountType: $accountType, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('iconId: $iconId, ')
          ..write('initialBalanceMinor: $initialBalanceMinor, ')
          ..write('initialBalanceAtMs: $initialBalanceAtMs, ')
          ..write('creditLimitMinor: $creditLimitMinor, ')
          ..write('billingDay: $billingDay, ')
          ..write('repaymentDay: $repaymentDay, ')
          ..write('note: $note, ')
          ..write('includeInTotals: $includeInTotals, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PartiesTable extends Parties with TableInfo<$PartiesTable, Party> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partyIdMeta = const VerificationMeta(
    'partyId',
  );
  @override
  late final GeneratedColumn<String> partyId = GeneratedColumn<String>(
    'party_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PartyType, String> partyType =
      GeneratedColumn<String>(
        'party_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PartyType>($PartiesTable.$converterpartyType);
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES icon_resources (icon_id)',
    ),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultCategoryIdMeta = const VerificationMeta(
    'defaultCategoryId',
  );
  @override
  late final GeneratedColumn<String> defaultCategoryId =
      GeneratedColumn<String>(
        'default_category_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (category_id)',
        ),
      );
  static const VerificationMeta _defaultAccountIdMeta = const VerificationMeta(
    'defaultAccountId',
  );
  @override
  late final GeneratedColumn<String> defaultAccountId = GeneratedColumn<String>(
    'default_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (account_id)',
    ),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    partyId,
    name,
    partyType,
    iconId,
    phone,
    note,
    defaultCategoryId,
    defaultAccountId,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Party> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('party_id')) {
      context.handle(
        _partyIdMeta,
        partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('default_category_id')) {
      context.handle(
        _defaultCategoryIdMeta,
        defaultCategoryId.isAcceptableOrUnknown(
          data['default_category_id']!,
          _defaultCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('default_account_id')) {
      context.handle(
        _defaultAccountIdMeta,
        defaultAccountId.isAcceptableOrUnknown(
          data['default_account_id']!,
          _defaultAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {partyId};
  @override
  Party map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Party(
      partyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      partyType: $PartiesTable.$converterpartyType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}party_type'],
        )!,
      ),
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      defaultCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_category_id'],
      ),
      defaultAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_account_id'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $PartiesTable createAlias(String alias) {
    return $PartiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PartyType, String, String> $converterpartyType =
      const EnumNameConverter(PartyType.values);
}

class Party extends DataClass implements Insertable<Party> {
  final String partyId;
  final String name;
  final PartyType partyType;
  final String? iconId;
  final String? phone;
  final String? note;
  final String? defaultCategoryId;
  final String? defaultAccountId;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const Party({
    required this.partyId,
    required this.name,
    required this.partyType,
    this.iconId,
    this.phone,
    this.note,
    this.defaultCategoryId,
    this.defaultAccountId,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['party_id'] = Variable<String>(partyId);
    map['name'] = Variable<String>(name);
    {
      map['party_type'] = Variable<String>(
        $PartiesTable.$converterpartyType.toSql(partyType),
      );
    }
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<String>(iconId);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || defaultCategoryId != null) {
      map['default_category_id'] = Variable<String>(defaultCategoryId);
    }
    if (!nullToAbsent || defaultAccountId != null) {
      map['default_account_id'] = Variable<String>(defaultAccountId);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  PartiesCompanion toCompanion(bool nullToAbsent) {
    return PartiesCompanion(
      partyId: Value(partyId),
      name: Value(name),
      partyType: Value(partyType),
      iconId: iconId == null && nullToAbsent
          ? const Value.absent()
          : Value(iconId),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      defaultCategoryId: defaultCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCategoryId),
      defaultAccountId: defaultAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultAccountId),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory Party.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Party(
      partyId: serializer.fromJson<String>(json['partyId']),
      name: serializer.fromJson<String>(json['name']),
      partyType: $PartiesTable.$converterpartyType.fromJson(
        serializer.fromJson<String>(json['partyType']),
      ),
      iconId: serializer.fromJson<String?>(json['iconId']),
      phone: serializer.fromJson<String?>(json['phone']),
      note: serializer.fromJson<String?>(json['note']),
      defaultCategoryId: serializer.fromJson<String?>(
        json['defaultCategoryId'],
      ),
      defaultAccountId: serializer.fromJson<String?>(json['defaultAccountId']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partyId': serializer.toJson<String>(partyId),
      'name': serializer.toJson<String>(name),
      'partyType': serializer.toJson<String>(
        $PartiesTable.$converterpartyType.toJson(partyType),
      ),
      'iconId': serializer.toJson<String?>(iconId),
      'phone': serializer.toJson<String?>(phone),
      'note': serializer.toJson<String?>(note),
      'defaultCategoryId': serializer.toJson<String?>(defaultCategoryId),
      'defaultAccountId': serializer.toJson<String?>(defaultAccountId),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Party copyWith({
    String? partyId,
    String? name,
    PartyType? partyType,
    Value<String?> iconId = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> defaultCategoryId = const Value.absent(),
    Value<String?> defaultAccountId = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => Party(
    partyId: partyId ?? this.partyId,
    name: name ?? this.name,
    partyType: partyType ?? this.partyType,
    iconId: iconId.present ? iconId.value : this.iconId,
    phone: phone.present ? phone.value : this.phone,
    note: note.present ? note.value : this.note,
    defaultCategoryId: defaultCategoryId.present
        ? defaultCategoryId.value
        : this.defaultCategoryId,
    defaultAccountId: defaultAccountId.present
        ? defaultAccountId.value
        : this.defaultAccountId,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Party copyWithCompanion(PartiesCompanion data) {
    return Party(
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      name: data.name.present ? data.name.value : this.name,
      partyType: data.partyType.present ? data.partyType.value : this.partyType,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      phone: data.phone.present ? data.phone.value : this.phone,
      note: data.note.present ? data.note.value : this.note,
      defaultCategoryId: data.defaultCategoryId.present
          ? data.defaultCategoryId.value
          : this.defaultCategoryId,
      defaultAccountId: data.defaultAccountId.present
          ? data.defaultAccountId.value
          : this.defaultAccountId,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Party(')
          ..write('partyId: $partyId, ')
          ..write('name: $name, ')
          ..write('partyType: $partyType, ')
          ..write('iconId: $iconId, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultAccountId: $defaultAccountId, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    partyId,
    name,
    partyType,
    iconId,
    phone,
    note,
    defaultCategoryId,
    defaultAccountId,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Party &&
          other.partyId == this.partyId &&
          other.name == this.name &&
          other.partyType == this.partyType &&
          other.iconId == this.iconId &&
          other.phone == this.phone &&
          other.note == this.note &&
          other.defaultCategoryId == this.defaultCategoryId &&
          other.defaultAccountId == this.defaultAccountId &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class PartiesCompanion extends UpdateCompanion<Party> {
  final Value<String> partyId;
  final Value<String> name;
  final Value<PartyType> partyType;
  final Value<String?> iconId;
  final Value<String?> phone;
  final Value<String?> note;
  final Value<String?> defaultCategoryId;
  final Value<String?> defaultAccountId;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const PartiesCompanion({
    this.partyId = const Value.absent(),
    this.name = const Value.absent(),
    this.partyType = const Value.absent(),
    this.iconId = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultAccountId = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PartiesCompanion.insert({
    required String partyId,
    required String name,
    required PartyType partyType,
    this.iconId = const Value.absent(),
    this.phone = const Value.absent(),
    this.note = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultAccountId = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : partyId = Value(partyId),
       name = Value(name),
       partyType = Value(partyType),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Party> custom({
    Expression<String>? partyId,
    Expression<String>? name,
    Expression<String>? partyType,
    Expression<String>? iconId,
    Expression<String>? phone,
    Expression<String>? note,
    Expression<String>? defaultCategoryId,
    Expression<String>? defaultAccountId,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partyId != null) 'party_id': partyId,
      if (name != null) 'name': name,
      if (partyType != null) 'party_type': partyType,
      if (iconId != null) 'icon_id': iconId,
      if (phone != null) 'phone': phone,
      if (note != null) 'note': note,
      if (defaultCategoryId != null) 'default_category_id': defaultCategoryId,
      if (defaultAccountId != null) 'default_account_id': defaultAccountId,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PartiesCompanion copyWith({
    Value<String>? partyId,
    Value<String>? name,
    Value<PartyType>? partyType,
    Value<String?>? iconId,
    Value<String?>? phone,
    Value<String?>? note,
    Value<String?>? defaultCategoryId,
    Value<String?>? defaultAccountId,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return PartiesCompanion(
      partyId: partyId ?? this.partyId,
      name: name ?? this.name,
      partyType: partyType ?? this.partyType,
      iconId: iconId ?? this.iconId,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      defaultAccountId: defaultAccountId ?? this.defaultAccountId,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partyId.present) {
      map['party_id'] = Variable<String>(partyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (partyType.present) {
      map['party_type'] = Variable<String>(
        $PartiesTable.$converterpartyType.toSql(partyType.value),
      );
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (defaultCategoryId.present) {
      map['default_category_id'] = Variable<String>(defaultCategoryId.value);
    }
    if (defaultAccountId.present) {
      map['default_account_id'] = Variable<String>(defaultAccountId.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartiesCompanion(')
          ..write('partyId: $partyId, ')
          ..write('name: $name, ')
          ..write('partyType: $partyType, ')
          ..write('iconId: $iconId, ')
          ..write('phone: $phone, ')
          ..write('note: $note, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultAccountId: $defaultAccountId, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES icon_resources (icon_id)',
    ),
  );
  static const VerificationMeta _defaultCategoryIdMeta = const VerificationMeta(
    'defaultCategoryId',
  );
  @override
  late final GeneratedColumn<String> defaultCategoryId =
      GeneratedColumn<String>(
        'default_category_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories (category_id)',
        ),
      );
  static const VerificationMeta _defaultPartyIdMeta = const VerificationMeta(
    'defaultPartyId',
  );
  @override
  late final GeneratedColumn<String> defaultPartyId = GeneratedColumn<String>(
    'default_party_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parties (party_id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    itemId,
    name,
    iconId,
    defaultCategoryId,
    defaultPartyId,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    }
    if (data.containsKey('default_category_id')) {
      context.handle(
        _defaultCategoryIdMeta,
        defaultCategoryId.isAcceptableOrUnknown(
          data['default_category_id']!,
          _defaultCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('default_party_id')) {
      context.handle(
        _defaultPartyIdMeta,
        defaultPartyId.isAcceptableOrUnknown(
          data['default_party_id']!,
          _defaultPartyIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      ),
      defaultCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_category_id'],
      ),
      defaultPartyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_party_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final String itemId;
  final String name;
  final String? iconId;
  final String? defaultCategoryId;
  final String? defaultPartyId;
  final String? note;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const Item({
    required this.itemId,
    required this.name,
    this.iconId,
    this.defaultCategoryId,
    this.defaultPartyId,
    this.note,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<String>(iconId);
    }
    if (!nullToAbsent || defaultCategoryId != null) {
      map['default_category_id'] = Variable<String>(defaultCategoryId);
    }
    if (!nullToAbsent || defaultPartyId != null) {
      map['default_party_id'] = Variable<String>(defaultPartyId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      itemId: Value(itemId),
      name: Value(name),
      iconId: iconId == null && nullToAbsent
          ? const Value.absent()
          : Value(iconId),
      defaultCategoryId: defaultCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCategoryId),
      defaultPartyId: defaultPartyId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPartyId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      itemId: serializer.fromJson<String>(json['itemId']),
      name: serializer.fromJson<String>(json['name']),
      iconId: serializer.fromJson<String?>(json['iconId']),
      defaultCategoryId: serializer.fromJson<String?>(
        json['defaultCategoryId'],
      ),
      defaultPartyId: serializer.fromJson<String?>(json['defaultPartyId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'name': serializer.toJson<String>(name),
      'iconId': serializer.toJson<String?>(iconId),
      'defaultCategoryId': serializer.toJson<String?>(defaultCategoryId),
      'defaultPartyId': serializer.toJson<String?>(defaultPartyId),
      'note': serializer.toJson<String?>(note),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Item copyWith({
    String? itemId,
    String? name,
    Value<String?> iconId = const Value.absent(),
    Value<String?> defaultCategoryId = const Value.absent(),
    Value<String?> defaultPartyId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => Item(
    itemId: itemId ?? this.itemId,
    name: name ?? this.name,
    iconId: iconId.present ? iconId.value : this.iconId,
    defaultCategoryId: defaultCategoryId.present
        ? defaultCategoryId.value
        : this.defaultCategoryId,
    defaultPartyId: defaultPartyId.present
        ? defaultPartyId.value
        : this.defaultPartyId,
    note: note.present ? note.value : this.note,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      name: data.name.present ? data.name.value : this.name,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      defaultCategoryId: data.defaultCategoryId.present
          ? data.defaultCategoryId.value
          : this.defaultCategoryId,
      defaultPartyId: data.defaultPartyId.present
          ? data.defaultPartyId.value
          : this.defaultPartyId,
      note: data.note.present ? data.note.value : this.note,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultPartyId: $defaultPartyId, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    itemId,
    name,
    iconId,
    defaultCategoryId,
    defaultPartyId,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.itemId == this.itemId &&
          other.name == this.name &&
          other.iconId == this.iconId &&
          other.defaultCategoryId == this.defaultCategoryId &&
          other.defaultPartyId == this.defaultPartyId &&
          other.note == this.note &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<String> itemId;
  final Value<String> name;
  final Value<String?> iconId;
  final Value<String?> defaultCategoryId;
  final Value<String?> defaultPartyId;
  final Value<String?> note;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ItemsCompanion({
    this.itemId = const Value.absent(),
    this.name = const Value.absent(),
    this.iconId = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultPartyId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    required String itemId,
    required String name,
    this.iconId = const Value.absent(),
    this.defaultCategoryId = const Value.absent(),
    this.defaultPartyId = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       name = Value(name),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Item> custom({
    Expression<String>? itemId,
    Expression<String>? name,
    Expression<String>? iconId,
    Expression<String>? defaultCategoryId,
    Expression<String>? defaultPartyId,
    Expression<String>? note,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (name != null) 'name': name,
      if (iconId != null) 'icon_id': iconId,
      if (defaultCategoryId != null) 'default_category_id': defaultCategoryId,
      if (defaultPartyId != null) 'default_party_id': defaultPartyId,
      if (note != null) 'note': note,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith({
    Value<String>? itemId,
    Value<String>? name,
    Value<String?>? iconId,
    Value<String?>? defaultCategoryId,
    Value<String?>? defaultPartyId,
    Value<String?>? note,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return ItemsCompanion(
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      iconId: iconId ?? this.iconId,
      defaultCategoryId: defaultCategoryId ?? this.defaultCategoryId,
      defaultPartyId: defaultPartyId ?? this.defaultPartyId,
      note: note ?? this.note,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (defaultCategoryId.present) {
      map['default_category_id'] = Variable<String>(defaultCategoryId.value);
    }
    if (defaultPartyId.present) {
      map['default_party_id'] = Variable<String>(defaultPartyId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('name: $name, ')
          ..write('iconId: $iconId, ')
          ..write('defaultCategoryId: $defaultCategoryId, ')
          ..write('defaultPartyId: $defaultPartyId, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxnsTable extends Txns with TableInfo<$TxnsTable, Txn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _txnIdMeta = const VerificationMeta('txnId');
  @override
  late final GeneratedColumn<String> txnId = GeneratedColumn<String>(
    'txn_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TxnType, String> txnType =
      GeneratedColumn<String>(
        'txn_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TxnType>($TxnsTable.$convertertxnType);
  @override
  late final GeneratedColumnWithTypeConverter<TxnStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('posted'),
      ).withConverter<TxnStatus>($TxnsTable.$converterstatus);
  static const VerificationMeta _occurredAtMsMeta = const VerificationMeta(
    'occurredAtMs',
  );
  @override
  late final GeneratedColumn<int> occurredAtMs = GeneratedColumn<int>(
    'occurred_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CNY'),
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (account_id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (category_id)',
    ),
  );
  static const VerificationMeta _partyIdMeta = const VerificationMeta(
    'partyId',
  );
  @override
  late final GeneratedColumn<String> partyId = GeneratedColumn<String>(
    'party_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parties (party_id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (item_id)',
    ),
  );
  static const VerificationMeta _fromAccountIdMeta = const VerificationMeta(
    'fromAccountId',
  );
  @override
  late final GeneratedColumn<String> fromAccountId = GeneratedColumn<String>(
    'from_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (account_id)',
    ),
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<String> toAccountId = GeneratedColumn<String>(
    'to_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (account_id)',
    ),
  );
  static const VerificationMeta _feeAmountMinorMeta = const VerificationMeta(
    'feeAmountMinor',
  );
  @override
  late final GeneratedColumn<int> feeAmountMinor = GeneratedColumn<int>(
    'fee_amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _feeAccountIdMeta = const VerificationMeta(
    'feeAccountId',
  );
  @override
  late final GeneratedColumn<String> feeAccountId = GeneratedColumn<String>(
    'fee_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (account_id)',
    ),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    txnId,
    txnType,
    status,
    occurredAtMs,
    currencyCode,
    amountMinor,
    accountId,
    categoryId,
    partyId,
    itemId,
    fromAccountId,
    toAccountId,
    feeAmountMinor,
    feeAccountId,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Txn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('txn_id')) {
      context.handle(
        _txnIdMeta,
        txnId.isAcceptableOrUnknown(data['txn_id']!, _txnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_txnIdMeta);
    }
    if (data.containsKey('occurred_at_ms')) {
      context.handle(
        _occurredAtMsMeta,
        occurredAtMs.isAcceptableOrUnknown(
          data['occurred_at_ms']!,
          _occurredAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMsMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('party_id')) {
      context.handle(
        _partyIdMeta,
        partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta),
      );
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    }
    if (data.containsKey('from_account_id')) {
      context.handle(
        _fromAccountIdMeta,
        fromAccountId.isAcceptableOrUnknown(
          data['from_account_id']!,
          _fromAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('fee_amount_minor')) {
      context.handle(
        _feeAmountMinorMeta,
        feeAmountMinor.isAcceptableOrUnknown(
          data['fee_amount_minor']!,
          _feeAmountMinorMeta,
        ),
      );
    }
    if (data.containsKey('fee_account_id')) {
      context.handle(
        _feeAccountIdMeta,
        feeAccountId.isAcceptableOrUnknown(
          data['fee_account_id']!,
          _feeAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {txnId};
  @override
  Txn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Txn(
      txnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_id'],
      )!,
      txnType: $TxnsTable.$convertertxnType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}txn_type'],
        )!,
      ),
      status: $TxnsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      occurredAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurred_at_ms'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      partyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_id'],
      ),
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      ),
      fromAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_account_id'],
      ),
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_account_id'],
      ),
      feeAmountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fee_amount_minor'],
      )!,
      feeAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fee_account_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $TxnsTable createAlias(String alias) {
    return $TxnsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TxnType, String, String> $convertertxnType =
      const EnumNameConverter(TxnType.values);
  static JsonTypeConverter2<TxnStatus, String, String> $converterstatus =
      const EnumNameConverter(TxnStatus.values);
}

class Txn extends DataClass implements Insertable<Txn> {
  final String txnId;
  final TxnType txnType;
  final TxnStatus status;
  final int occurredAtMs;
  final String currencyCode;

  /// 金额单位：分（minor units），永远存正数
  final int amountMinor;
  final String? accountId;
  final String? categoryId;
  final String? partyId;
  final String? itemId;
  final String? fromAccountId;
  final String? toAccountId;
  final int feeAmountMinor;
  final String? feeAccountId;
  final String? note;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const Txn({
    required this.txnId,
    required this.txnType,
    required this.status,
    required this.occurredAtMs,
    required this.currencyCode,
    required this.amountMinor,
    this.accountId,
    this.categoryId,
    this.partyId,
    this.itemId,
    this.fromAccountId,
    this.toAccountId,
    required this.feeAmountMinor,
    this.feeAccountId,
    this.note,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['txn_id'] = Variable<String>(txnId);
    {
      map['txn_type'] = Variable<String>(
        $TxnsTable.$convertertxnType.toSql(txnType),
      );
    }
    {
      map['status'] = Variable<String>(
        $TxnsTable.$converterstatus.toSql(status),
      );
    }
    map['occurred_at_ms'] = Variable<int>(occurredAtMs);
    map['currency_code'] = Variable<String>(currencyCode);
    map['amount_minor'] = Variable<int>(amountMinor);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || partyId != null) {
      map['party_id'] = Variable<String>(partyId);
    }
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<String>(itemId);
    }
    if (!nullToAbsent || fromAccountId != null) {
      map['from_account_id'] = Variable<String>(fromAccountId);
    }
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<String>(toAccountId);
    }
    map['fee_amount_minor'] = Variable<int>(feeAmountMinor);
    if (!nullToAbsent || feeAccountId != null) {
      map['fee_account_id'] = Variable<String>(feeAccountId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TxnsCompanion toCompanion(bool nullToAbsent) {
    return TxnsCompanion(
      txnId: Value(txnId),
      txnType: Value(txnType),
      status: Value(status),
      occurredAtMs: Value(occurredAtMs),
      currencyCode: Value(currencyCode),
      amountMinor: Value(amountMinor),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      partyId: partyId == null && nullToAbsent
          ? const Value.absent()
          : Value(partyId),
      itemId: itemId == null && nullToAbsent
          ? const Value.absent()
          : Value(itemId),
      fromAccountId: fromAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromAccountId),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      feeAmountMinor: Value(feeAmountMinor),
      feeAccountId: feeAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(feeAccountId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory Txn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Txn(
      txnId: serializer.fromJson<String>(json['txnId']),
      txnType: $TxnsTable.$convertertxnType.fromJson(
        serializer.fromJson<String>(json['txnType']),
      ),
      status: $TxnsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      occurredAtMs: serializer.fromJson<int>(json['occurredAtMs']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      partyId: serializer.fromJson<String?>(json['partyId']),
      itemId: serializer.fromJson<String?>(json['itemId']),
      fromAccountId: serializer.fromJson<String?>(json['fromAccountId']),
      toAccountId: serializer.fromJson<String?>(json['toAccountId']),
      feeAmountMinor: serializer.fromJson<int>(json['feeAmountMinor']),
      feeAccountId: serializer.fromJson<String?>(json['feeAccountId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'txnId': serializer.toJson<String>(txnId),
      'txnType': serializer.toJson<String>(
        $TxnsTable.$convertertxnType.toJson(txnType),
      ),
      'status': serializer.toJson<String>(
        $TxnsTable.$converterstatus.toJson(status),
      ),
      'occurredAtMs': serializer.toJson<int>(occurredAtMs),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'accountId': serializer.toJson<String?>(accountId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'partyId': serializer.toJson<String?>(partyId),
      'itemId': serializer.toJson<String?>(itemId),
      'fromAccountId': serializer.toJson<String?>(fromAccountId),
      'toAccountId': serializer.toJson<String?>(toAccountId),
      'feeAmountMinor': serializer.toJson<int>(feeAmountMinor),
      'feeAccountId': serializer.toJson<String?>(feeAccountId),
      'note': serializer.toJson<String?>(note),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Txn copyWith({
    String? txnId,
    TxnType? txnType,
    TxnStatus? status,
    int? occurredAtMs,
    String? currencyCode,
    int? amountMinor,
    Value<String?> accountId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> partyId = const Value.absent(),
    Value<String?> itemId = const Value.absent(),
    Value<String?> fromAccountId = const Value.absent(),
    Value<String?> toAccountId = const Value.absent(),
    int? feeAmountMinor,
    Value<String?> feeAccountId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => Txn(
    txnId: txnId ?? this.txnId,
    txnType: txnType ?? this.txnType,
    status: status ?? this.status,
    occurredAtMs: occurredAtMs ?? this.occurredAtMs,
    currencyCode: currencyCode ?? this.currencyCode,
    amountMinor: amountMinor ?? this.amountMinor,
    accountId: accountId.present ? accountId.value : this.accountId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    partyId: partyId.present ? partyId.value : this.partyId,
    itemId: itemId.present ? itemId.value : this.itemId,
    fromAccountId: fromAccountId.present
        ? fromAccountId.value
        : this.fromAccountId,
    toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
    feeAmountMinor: feeAmountMinor ?? this.feeAmountMinor,
    feeAccountId: feeAccountId.present ? feeAccountId.value : this.feeAccountId,
    note: note.present ? note.value : this.note,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Txn copyWithCompanion(TxnsCompanion data) {
    return Txn(
      txnId: data.txnId.present ? data.txnId.value : this.txnId,
      txnType: data.txnType.present ? data.txnType.value : this.txnType,
      status: data.status.present ? data.status.value : this.status,
      occurredAtMs: data.occurredAtMs.present
          ? data.occurredAtMs.value
          : this.occurredAtMs,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      fromAccountId: data.fromAccountId.present
          ? data.fromAccountId.value
          : this.fromAccountId,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      feeAmountMinor: data.feeAmountMinor.present
          ? data.feeAmountMinor.value
          : this.feeAmountMinor,
      feeAccountId: data.feeAccountId.present
          ? data.feeAccountId.value
          : this.feeAccountId,
      note: data.note.present ? data.note.value : this.note,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Txn(')
          ..write('txnId: $txnId, ')
          ..write('txnType: $txnType, ')
          ..write('status: $status, ')
          ..write('occurredAtMs: $occurredAtMs, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('partyId: $partyId, ')
          ..write('itemId: $itemId, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('feeAmountMinor: $feeAmountMinor, ')
          ..write('feeAccountId: $feeAccountId, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    txnId,
    txnType,
    status,
    occurredAtMs,
    currencyCode,
    amountMinor,
    accountId,
    categoryId,
    partyId,
    itemId,
    fromAccountId,
    toAccountId,
    feeAmountMinor,
    feeAccountId,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Txn &&
          other.txnId == this.txnId &&
          other.txnType == this.txnType &&
          other.status == this.status &&
          other.occurredAtMs == this.occurredAtMs &&
          other.currencyCode == this.currencyCode &&
          other.amountMinor == this.amountMinor &&
          other.accountId == this.accountId &&
          other.categoryId == this.categoryId &&
          other.partyId == this.partyId &&
          other.itemId == this.itemId &&
          other.fromAccountId == this.fromAccountId &&
          other.toAccountId == this.toAccountId &&
          other.feeAmountMinor == this.feeAmountMinor &&
          other.feeAccountId == this.feeAccountId &&
          other.note == this.note &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class TxnsCompanion extends UpdateCompanion<Txn> {
  final Value<String> txnId;
  final Value<TxnType> txnType;
  final Value<TxnStatus> status;
  final Value<int> occurredAtMs;
  final Value<String> currencyCode;
  final Value<int> amountMinor;
  final Value<String?> accountId;
  final Value<String?> categoryId;
  final Value<String?> partyId;
  final Value<String?> itemId;
  final Value<String?> fromAccountId;
  final Value<String?> toAccountId;
  final Value<int> feeAmountMinor;
  final Value<String?> feeAccountId;
  final Value<String?> note;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const TxnsCompanion({
    this.txnId = const Value.absent(),
    this.txnType = const Value.absent(),
    this.status = const Value.absent(),
    this.occurredAtMs = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.partyId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.feeAmountMinor = const Value.absent(),
    this.feeAccountId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TxnsCompanion.insert({
    required String txnId,
    required TxnType txnType,
    this.status = const Value.absent(),
    required int occurredAtMs,
    this.currencyCode = const Value.absent(),
    required int amountMinor,
    this.accountId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.partyId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.feeAmountMinor = const Value.absent(),
    this.feeAccountId = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : txnId = Value(txnId),
       txnType = Value(txnType),
       occurredAtMs = Value(occurredAtMs),
       amountMinor = Value(amountMinor),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<Txn> custom({
    Expression<String>? txnId,
    Expression<String>? txnType,
    Expression<String>? status,
    Expression<int>? occurredAtMs,
    Expression<String>? currencyCode,
    Expression<int>? amountMinor,
    Expression<String>? accountId,
    Expression<String>? categoryId,
    Expression<String>? partyId,
    Expression<String>? itemId,
    Expression<String>? fromAccountId,
    Expression<String>? toAccountId,
    Expression<int>? feeAmountMinor,
    Expression<String>? feeAccountId,
    Expression<String>? note,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (txnId != null) 'txn_id': txnId,
      if (txnType != null) 'txn_type': txnType,
      if (status != null) 'status': status,
      if (occurredAtMs != null) 'occurred_at_ms': occurredAtMs,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (accountId != null) 'account_id': accountId,
      if (categoryId != null) 'category_id': categoryId,
      if (partyId != null) 'party_id': partyId,
      if (itemId != null) 'item_id': itemId,
      if (fromAccountId != null) 'from_account_id': fromAccountId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (feeAmountMinor != null) 'fee_amount_minor': feeAmountMinor,
      if (feeAccountId != null) 'fee_account_id': feeAccountId,
      if (note != null) 'note': note,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TxnsCompanion copyWith({
    Value<String>? txnId,
    Value<TxnType>? txnType,
    Value<TxnStatus>? status,
    Value<int>? occurredAtMs,
    Value<String>? currencyCode,
    Value<int>? amountMinor,
    Value<String?>? accountId,
    Value<String?>? categoryId,
    Value<String?>? partyId,
    Value<String?>? itemId,
    Value<String?>? fromAccountId,
    Value<String?>? toAccountId,
    Value<int>? feeAmountMinor,
    Value<String?>? feeAccountId,
    Value<String?>? note,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return TxnsCompanion(
      txnId: txnId ?? this.txnId,
      txnType: txnType ?? this.txnType,
      status: status ?? this.status,
      occurredAtMs: occurredAtMs ?? this.occurredAtMs,
      currencyCode: currencyCode ?? this.currencyCode,
      amountMinor: amountMinor ?? this.amountMinor,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
      partyId: partyId ?? this.partyId,
      itemId: itemId ?? this.itemId,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      feeAmountMinor: feeAmountMinor ?? this.feeAmountMinor,
      feeAccountId: feeAccountId ?? this.feeAccountId,
      note: note ?? this.note,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (txnId.present) {
      map['txn_id'] = Variable<String>(txnId.value);
    }
    if (txnType.present) {
      map['txn_type'] = Variable<String>(
        $TxnsTable.$convertertxnType.toSql(txnType.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $TxnsTable.$converterstatus.toSql(status.value),
      );
    }
    if (occurredAtMs.present) {
      map['occurred_at_ms'] = Variable<int>(occurredAtMs.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<String>(partyId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (fromAccountId.present) {
      map['from_account_id'] = Variable<String>(fromAccountId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<String>(toAccountId.value);
    }
    if (feeAmountMinor.present) {
      map['fee_amount_minor'] = Variable<int>(feeAmountMinor.value);
    }
    if (feeAccountId.present) {
      map['fee_account_id'] = Variable<String>(feeAccountId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnsCompanion(')
          ..write('txnId: $txnId, ')
          ..write('txnType: $txnType, ')
          ..write('status: $status, ')
          ..write('occurredAtMs: $occurredAtMs, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('accountId: $accountId, ')
          ..write('categoryId: $categoryId, ')
          ..write('partyId: $partyId, ')
          ..write('itemId: $itemId, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('feeAmountMinor: $feeAmountMinor, ')
          ..write('feeAccountId: $feeAccountId, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TxnAttachmentsTable extends TxnAttachments
    with TableInfo<$TxnAttachmentsTable, TxnAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attachmentIdMeta = const VerificationMeta(
    'attachmentId',
  );
  @override
  late final GeneratedColumn<String> attachmentId = GeneratedColumn<String>(
    'attachment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _txnIdMeta = const VerificationMeta('txnId');
  @override
  late final GeneratedColumn<String> txnId = GeneratedColumn<String>(
    'txn_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES txns (txn_id)',
    ),
  );
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AttachmentPurpose, String>
  purpose = GeneratedColumn<String>(
    'purpose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('receipt'),
  ).withConverter<AttachmentPurpose>($TxnAttachmentsTable.$converterpurpose);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    attachmentId,
    txnId,
    mediaId,
    purpose,
    sortOrder,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'txn_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<TxnAttachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attachment_id')) {
      context.handle(
        _attachmentIdMeta,
        attachmentId.isAcceptableOrUnknown(
          data['attachment_id']!,
          _attachmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attachmentIdMeta);
    }
    if (data.containsKey('txn_id')) {
      context.handle(
        _txnIdMeta,
        txnId.isAcceptableOrUnknown(data['txn_id']!, _txnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_txnIdMeta);
    }
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attachmentId};
  @override
  TxnAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TxnAttachment(
      attachmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_id'],
      )!,
      txnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}txn_id'],
      )!,
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      )!,
      purpose: $TxnAttachmentsTable.$converterpurpose.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}purpose'],
        )!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $TxnAttachmentsTable createAlias(String alias) {
    return $TxnAttachmentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AttachmentPurpose, String, String>
  $converterpurpose = const EnumNameConverter(AttachmentPurpose.values);
}

class TxnAttachment extends DataClass implements Insertable<TxnAttachment> {
  final String attachmentId;
  final String txnId;
  final String mediaId;
  final AttachmentPurpose purpose;
  final int sortOrder;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const TxnAttachment({
    required this.attachmentId,
    required this.txnId,
    required this.mediaId,
    required this.purpose,
    required this.sortOrder,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attachment_id'] = Variable<String>(attachmentId);
    map['txn_id'] = Variable<String>(txnId);
    map['media_id'] = Variable<String>(mediaId);
    {
      map['purpose'] = Variable<String>(
        $TxnAttachmentsTable.$converterpurpose.toSql(purpose),
      );
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  TxnAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return TxnAttachmentsCompanion(
      attachmentId: Value(attachmentId),
      txnId: Value(txnId),
      mediaId: Value(mediaId),
      purpose: Value(purpose),
      sortOrder: Value(sortOrder),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory TxnAttachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TxnAttachment(
      attachmentId: serializer.fromJson<String>(json['attachmentId']),
      txnId: serializer.fromJson<String>(json['txnId']),
      mediaId: serializer.fromJson<String>(json['mediaId']),
      purpose: $TxnAttachmentsTable.$converterpurpose.fromJson(
        serializer.fromJson<String>(json['purpose']),
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attachmentId': serializer.toJson<String>(attachmentId),
      'txnId': serializer.toJson<String>(txnId),
      'mediaId': serializer.toJson<String>(mediaId),
      'purpose': serializer.toJson<String>(
        $TxnAttachmentsTable.$converterpurpose.toJson(purpose),
      ),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  TxnAttachment copyWith({
    String? attachmentId,
    String? txnId,
    String? mediaId,
    AttachmentPurpose? purpose,
    int? sortOrder,
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => TxnAttachment(
    attachmentId: attachmentId ?? this.attachmentId,
    txnId: txnId ?? this.txnId,
    mediaId: mediaId ?? this.mediaId,
    purpose: purpose ?? this.purpose,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  TxnAttachment copyWithCompanion(TxnAttachmentsCompanion data) {
    return TxnAttachment(
      attachmentId: data.attachmentId.present
          ? data.attachmentId.value
          : this.attachmentId,
      txnId: data.txnId.present ? data.txnId.value : this.txnId,
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      purpose: data.purpose.present ? data.purpose.value : this.purpose,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TxnAttachment(')
          ..write('attachmentId: $attachmentId, ')
          ..write('txnId: $txnId, ')
          ..write('mediaId: $mediaId, ')
          ..write('purpose: $purpose, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    attachmentId,
    txnId,
    mediaId,
    purpose,
    sortOrder,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TxnAttachment &&
          other.attachmentId == this.attachmentId &&
          other.txnId == this.txnId &&
          other.mediaId == this.mediaId &&
          other.purpose == this.purpose &&
          other.sortOrder == this.sortOrder &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class TxnAttachmentsCompanion extends UpdateCompanion<TxnAttachment> {
  final Value<String> attachmentId;
  final Value<String> txnId;
  final Value<String> mediaId;
  final Value<AttachmentPurpose> purpose;
  final Value<int> sortOrder;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const TxnAttachmentsCompanion({
    this.attachmentId = const Value.absent(),
    this.txnId = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.purpose = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TxnAttachmentsCompanion.insert({
    required String attachmentId,
    required String txnId,
    required String mediaId,
    this.purpose = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : attachmentId = Value(attachmentId),
       txnId = Value(txnId),
       mediaId = Value(mediaId),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<TxnAttachment> custom({
    Expression<String>? attachmentId,
    Expression<String>? txnId,
    Expression<String>? mediaId,
    Expression<String>? purpose,
    Expression<int>? sortOrder,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attachmentId != null) 'attachment_id': attachmentId,
      if (txnId != null) 'txn_id': txnId,
      if (mediaId != null) 'media_id': mediaId,
      if (purpose != null) 'purpose': purpose,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TxnAttachmentsCompanion copyWith({
    Value<String>? attachmentId,
    Value<String>? txnId,
    Value<String>? mediaId,
    Value<AttachmentPurpose>? purpose,
    Value<int>? sortOrder,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return TxnAttachmentsCompanion(
      attachmentId: attachmentId ?? this.attachmentId,
      txnId: txnId ?? this.txnId,
      mediaId: mediaId ?? this.mediaId,
      purpose: purpose ?? this.purpose,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attachmentId.present) {
      map['attachment_id'] = Variable<String>(attachmentId.value);
    }
    if (txnId.present) {
      map['txn_id'] = Variable<String>(txnId.value);
    }
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(
        $TxnAttachmentsTable.$converterpurpose.toSql(purpose.value),
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnAttachmentsCompanion(')
          ..write('attachmentId: $attachmentId, ')
          ..write('txnId: $txnId, ')
          ..write('mediaId: $mediaId, ')
          ..write('purpose: $purpose, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetPlansTable extends BudgetPlans
    with TableInfo<$BudgetPlansTable, BudgetPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _budgetIdMeta = const VerificationMeta(
    'budgetId',
  );
  @override
  late final GeneratedColumn<String> budgetId = GeneratedColumn<String>(
    'budget_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<String> month = GeneratedColumn<String>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BudgetScopeType, String>
  scopeType = GeneratedColumn<String>(
    'scope_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<BudgetScopeType>($BudgetPlansTable.$converterscopeType);
  static const VerificationMeta _scopeIdMeta = const VerificationMeta(
    'scopeId',
  );
  @override
  late final GeneratedColumn<String> scopeId = GeneratedColumn<String>(
    'scope_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RolloverRule, String>
  rolloverRule = GeneratedColumn<String>(
    'rollover_rule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  ).withConverter<RolloverRule>($BudgetPlansTable.$converterrolloverRule);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    budgetId,
    month,
    scopeType,
    scopeId,
    amountMinor,
    rolloverRule,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('budget_id')) {
      context.handle(
        _budgetIdMeta,
        budgetId.isAcceptableOrUnknown(data['budget_id']!, _budgetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_budgetIdMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('scope_id')) {
      context.handle(
        _scopeIdMeta,
        scopeId.isAcceptableOrUnknown(data['scope_id']!, _scopeIdMeta),
      );
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {budgetId};
  @override
  BudgetPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPlan(
      budgetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}budget_id'],
      )!,
      month: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month'],
      )!,
      scopeType: $BudgetPlansTable.$converterscopeType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}scope_type'],
        )!,
      ),
      scopeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope_id'],
      ),
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      rolloverRule: $BudgetPlansTable.$converterrolloverRule.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rollover_rule'],
        )!,
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $BudgetPlansTable createAlias(String alias) {
    return $BudgetPlansTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BudgetScopeType, String, String>
  $converterscopeType = const EnumNameConverter(BudgetScopeType.values);
  static JsonTypeConverter2<RolloverRule, String, String>
  $converterrolloverRule = const EnumNameConverter(RolloverRule.values);
}

class BudgetPlan extends DataClass implements Insertable<BudgetPlan> {
  final String budgetId;
  final String month;
  final BudgetScopeType scopeType;
  final String? scopeId;

  /// 金额单位：分（minor units）
  final int amountMinor;
  final RolloverRule rolloverRule;
  final String? note;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const BudgetPlan({
    required this.budgetId,
    required this.month,
    required this.scopeType,
    this.scopeId,
    required this.amountMinor,
    required this.rolloverRule,
    this.note,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['budget_id'] = Variable<String>(budgetId);
    map['month'] = Variable<String>(month);
    {
      map['scope_type'] = Variable<String>(
        $BudgetPlansTable.$converterscopeType.toSql(scopeType),
      );
    }
    if (!nullToAbsent || scopeId != null) {
      map['scope_id'] = Variable<String>(scopeId);
    }
    map['amount_minor'] = Variable<int>(amountMinor);
    {
      map['rollover_rule'] = Variable<String>(
        $BudgetPlansTable.$converterrolloverRule.toSql(rolloverRule),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  BudgetPlansCompanion toCompanion(bool nullToAbsent) {
    return BudgetPlansCompanion(
      budgetId: Value(budgetId),
      month: Value(month),
      scopeType: Value(scopeType),
      scopeId: scopeId == null && nullToAbsent
          ? const Value.absent()
          : Value(scopeId),
      amountMinor: Value(amountMinor),
      rolloverRule: Value(rolloverRule),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory BudgetPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetPlan(
      budgetId: serializer.fromJson<String>(json['budgetId']),
      month: serializer.fromJson<String>(json['month']),
      scopeType: $BudgetPlansTable.$converterscopeType.fromJson(
        serializer.fromJson<String>(json['scopeType']),
      ),
      scopeId: serializer.fromJson<String?>(json['scopeId']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      rolloverRule: $BudgetPlansTable.$converterrolloverRule.fromJson(
        serializer.fromJson<String>(json['rolloverRule']),
      ),
      note: serializer.fromJson<String?>(json['note']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'budgetId': serializer.toJson<String>(budgetId),
      'month': serializer.toJson<String>(month),
      'scopeType': serializer.toJson<String>(
        $BudgetPlansTable.$converterscopeType.toJson(scopeType),
      ),
      'scopeId': serializer.toJson<String?>(scopeId),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'rolloverRule': serializer.toJson<String>(
        $BudgetPlansTable.$converterrolloverRule.toJson(rolloverRule),
      ),
      'note': serializer.toJson<String?>(note),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  BudgetPlan copyWith({
    String? budgetId,
    String? month,
    BudgetScopeType? scopeType,
    Value<String?> scopeId = const Value.absent(),
    int? amountMinor,
    RolloverRule? rolloverRule,
    Value<String?> note = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => BudgetPlan(
    budgetId: budgetId ?? this.budgetId,
    month: month ?? this.month,
    scopeType: scopeType ?? this.scopeType,
    scopeId: scopeId.present ? scopeId.value : this.scopeId,
    amountMinor: amountMinor ?? this.amountMinor,
    rolloverRule: rolloverRule ?? this.rolloverRule,
    note: note.present ? note.value : this.note,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  BudgetPlan copyWithCompanion(BudgetPlansCompanion data) {
    return BudgetPlan(
      budgetId: data.budgetId.present ? data.budgetId.value : this.budgetId,
      month: data.month.present ? data.month.value : this.month,
      scopeType: data.scopeType.present ? data.scopeType.value : this.scopeType,
      scopeId: data.scopeId.present ? data.scopeId.value : this.scopeId,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      rolloverRule: data.rolloverRule.present
          ? data.rolloverRule.value
          : this.rolloverRule,
      note: data.note.present ? data.note.value : this.note,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPlan(')
          ..write('budgetId: $budgetId, ')
          ..write('month: $month, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('rolloverRule: $rolloverRule, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    budgetId,
    month,
    scopeType,
    scopeId,
    amountMinor,
    rolloverRule,
    note,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetPlan &&
          other.budgetId == this.budgetId &&
          other.month == this.month &&
          other.scopeType == this.scopeType &&
          other.scopeId == this.scopeId &&
          other.amountMinor == this.amountMinor &&
          other.rolloverRule == this.rolloverRule &&
          other.note == this.note &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class BudgetPlansCompanion extends UpdateCompanion<BudgetPlan> {
  final Value<String> budgetId;
  final Value<String> month;
  final Value<BudgetScopeType> scopeType;
  final Value<String?> scopeId;
  final Value<int> amountMinor;
  final Value<RolloverRule> rolloverRule;
  final Value<String?> note;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const BudgetPlansCompanion({
    this.budgetId = const Value.absent(),
    this.month = const Value.absent(),
    this.scopeType = const Value.absent(),
    this.scopeId = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.rolloverRule = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetPlansCompanion.insert({
    required String budgetId,
    required String month,
    required BudgetScopeType scopeType,
    this.scopeId = const Value.absent(),
    required int amountMinor,
    this.rolloverRule = const Value.absent(),
    this.note = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : budgetId = Value(budgetId),
       month = Value(month),
       scopeType = Value(scopeType),
       amountMinor = Value(amountMinor),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<BudgetPlan> custom({
    Expression<String>? budgetId,
    Expression<String>? month,
    Expression<String>? scopeType,
    Expression<String>? scopeId,
    Expression<int>? amountMinor,
    Expression<String>? rolloverRule,
    Expression<String>? note,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (budgetId != null) 'budget_id': budgetId,
      if (month != null) 'month': month,
      if (scopeType != null) 'scope_type': scopeType,
      if (scopeId != null) 'scope_id': scopeId,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (rolloverRule != null) 'rollover_rule': rolloverRule,
      if (note != null) 'note': note,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetPlansCompanion copyWith({
    Value<String>? budgetId,
    Value<String>? month,
    Value<BudgetScopeType>? scopeType,
    Value<String?>? scopeId,
    Value<int>? amountMinor,
    Value<RolloverRule>? rolloverRule,
    Value<String?>? note,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return BudgetPlansCompanion(
      budgetId: budgetId ?? this.budgetId,
      month: month ?? this.month,
      scopeType: scopeType ?? this.scopeType,
      scopeId: scopeId ?? this.scopeId,
      amountMinor: amountMinor ?? this.amountMinor,
      rolloverRule: rolloverRule ?? this.rolloverRule,
      note: note ?? this.note,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (budgetId.present) {
      map['budget_id'] = Variable<String>(budgetId.value);
    }
    if (month.present) {
      map['month'] = Variable<String>(month.value);
    }
    if (scopeType.present) {
      map['scope_type'] = Variable<String>(
        $BudgetPlansTable.$converterscopeType.toSql(scopeType.value),
      );
    }
    if (scopeId.present) {
      map['scope_id'] = Variable<String>(scopeId.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (rolloverRule.present) {
      map['rollover_rule'] = Variable<String>(
        $BudgetPlansTable.$converterrolloverRule.toSql(rolloverRule.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPlansCompanion(')
          ..write('budgetId: $budgetId, ')
          ..write('month: $month, ')
          ..write('scopeType: $scopeType, ')
          ..write('scopeId: $scopeId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('rolloverRule: $rolloverRule, ')
          ..write('note: $note, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LedgerDb extends GeneratedDatabase {
  _$LedgerDb(QueryExecutor e) : super(e);
  $LedgerDbManager get managers => $LedgerDbManager(this);
  late final $LedgerInfoTable ledgerInfo = $LedgerInfoTable(this);
  late final $IconResourcesTable iconResources = $IconResourcesTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $PartiesTable parties = $PartiesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $TxnsTable txns = $TxnsTable(this);
  late final $TxnAttachmentsTable txnAttachments = $TxnAttachmentsTable(this);
  late final $BudgetPlansTable budgetPlans = $BudgetPlansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ledgerInfo,
    iconResources,
    categories,
    accounts,
    parties,
    items,
    txns,
    txnAttachments,
    budgetPlans,
  ];
}

typedef $$LedgerInfoTableCreateCompanionBuilder =
    LedgerInfoCompanion Function({
      required String ledgerId,
      required String name,
      Value<String> currencyCode,
      Value<String> timezone,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$LedgerInfoTableUpdateCompanionBuilder =
    LedgerInfoCompanion Function({
      Value<String> ledgerId,
      Value<String> name,
      Value<String> currencyCode,
      Value<String> timezone,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

class $$LedgerInfoTableFilterComposer
    extends Composer<_$LedgerDb, $LedgerInfoTable> {
  $$LedgerInfoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ledgerId => $composableBuilder(
    column: $table.ledgerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LedgerInfoTableOrderingComposer
    extends Composer<_$LedgerDb, $LedgerInfoTable> {
  $$LedgerInfoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ledgerId => $composableBuilder(
    column: $table.ledgerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerInfoTableAnnotationComposer
    extends Composer<_$LedgerDb, $LedgerInfoTable> {
  $$LedgerInfoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ledgerId =>
      $composableBuilder(column: $table.ledgerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$LedgerInfoTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $LedgerInfoTable,
          LedgerInfoData,
          $$LedgerInfoTableFilterComposer,
          $$LedgerInfoTableOrderingComposer,
          $$LedgerInfoTableAnnotationComposer,
          $$LedgerInfoTableCreateCompanionBuilder,
          $$LedgerInfoTableUpdateCompanionBuilder,
          (
            LedgerInfoData,
            BaseReferences<_$LedgerDb, $LedgerInfoTable, LedgerInfoData>,
          ),
          LedgerInfoData,
          PrefetchHooks Function()
        > {
  $$LedgerInfoTableTableManager(_$LedgerDb db, $LedgerInfoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerInfoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerInfoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerInfoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ledgerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerInfoCompanion(
                ledgerId: ledgerId,
                name: name,
                currencyCode: currencyCode,
                timezone: timezone,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ledgerId,
                required String name,
                Value<String> currencyCode = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerInfoCompanion.insert(
                ledgerId: ledgerId,
                name: name,
                currencyCode: currencyCode,
                timezone: timezone,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerInfoTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $LedgerInfoTable,
      LedgerInfoData,
      $$LedgerInfoTableFilterComposer,
      $$LedgerInfoTableOrderingComposer,
      $$LedgerInfoTableAnnotationComposer,
      $$LedgerInfoTableCreateCompanionBuilder,
      $$LedgerInfoTableUpdateCompanionBuilder,
      (
        LedgerInfoData,
        BaseReferences<_$LedgerDb, $LedgerInfoTable, LedgerInfoData>,
      ),
      LedgerInfoData,
      PrefetchHooks Function()
    >;
typedef $$IconResourcesTableCreateCompanionBuilder =
    IconResourcesCompanion Function({
      required String iconId,
      required IconSource source,
      Value<int?> codepoint,
      Value<String?> fontFamily,
      Value<String?> assetPath,
      Value<String?> mediaId,
      Value<String?> fgColor,
      Value<String?> bgColor,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$IconResourcesTableUpdateCompanionBuilder =
    IconResourcesCompanion Function({
      Value<String> iconId,
      Value<IconSource> source,
      Value<int?> codepoint,
      Value<String?> fontFamily,
      Value<String?> assetPath,
      Value<String?> mediaId,
      Value<String?> fgColor,
      Value<String?> bgColor,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$IconResourcesTableReferences
    extends BaseReferences<_$LedgerDb, $IconResourcesTable, IconResource> {
  $$IconResourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CategoriesTable, List<Category>>
  _categoriesRefsTable(_$LedgerDb db) => MultiTypedResultKey.fromTable(
    db.categories,
    aliasName: $_aliasNameGenerator(
      db.iconResources.iconId,
      db.categories.iconId,
    ),
  );

  $$CategoriesTableProcessedTableManager get categoriesRefs {
    final manager = $$CategoriesTableTableManager($_db, $_db.categories).filter(
      (f) => f.iconId.iconId.sqlEquals($_itemColumn<String>('icon_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_categoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: $_aliasNameGenerator(
      db.iconResources.iconId,
      db.accounts.iconId,
    ),
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter(
      (f) => f.iconId.iconId.sqlEquals($_itemColumn<String>('icon_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PartiesTable, List<Party>> _partiesRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.parties,
    aliasName: $_aliasNameGenerator(db.iconResources.iconId, db.parties.iconId),
  );

  $$PartiesTableProcessedTableManager get partiesRefs {
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter(
      (f) => f.iconId.iconId.sqlEquals($_itemColumn<String>('icon_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_partiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: $_aliasNameGenerator(db.iconResources.iconId, db.items.iconId),
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager($_db, $_db.items).filter(
      (f) => f.iconId.iconId.sqlEquals($_itemColumn<String>('icon_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IconResourcesTableFilterComposer
    extends Composer<_$LedgerDb, $IconResourcesTable> {
  $$IconResourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get iconId => $composableBuilder(
    column: $table.iconId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<IconSource, IconSource, String> get source =>
      $composableBuilder(
        column: $table.source,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get codepoint => $composableBuilder(
    column: $table.codepoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fgColor => $composableBuilder(
    column: $table.fgColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bgColor => $composableBuilder(
    column: $table.bgColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> categoriesRefs(
    Expression<bool> Function($$CategoriesTableFilterComposer f) f,
  ) {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> partiesRefs(
    Expression<bool> Function($$PartiesTableFilterComposer f) f,
  ) {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableFilterComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IconResourcesTableOrderingComposer
    extends Composer<_$LedgerDb, $IconResourcesTable> {
  $$IconResourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get iconId => $composableBuilder(
    column: $table.iconId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get codepoint => $composableBuilder(
    column: $table.codepoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetPath => $composableBuilder(
    column: $table.assetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fgColor => $composableBuilder(
    column: $table.fgColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bgColor => $composableBuilder(
    column: $table.bgColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IconResourcesTableAnnotationComposer
    extends Composer<_$LedgerDb, $IconResourcesTable> {
  $$IconResourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get iconId =>
      $composableBuilder(column: $table.iconId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IconSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get codepoint =>
      $composableBuilder(column: $table.codepoint, builder: (column) => column);

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetPath =>
      $composableBuilder(column: $table.assetPath, builder: (column) => column);

  GeneratedColumn<String> get mediaId =>
      $composableBuilder(column: $table.mediaId, builder: (column) => column);

  GeneratedColumn<String> get fgColor =>
      $composableBuilder(column: $table.fgColor, builder: (column) => column);

  GeneratedColumn<String> get bgColor =>
      $composableBuilder(column: $table.bgColor, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> categoriesRefs<T extends Object>(
    Expression<T> Function($$CategoriesTableAnnotationComposer a) f,
  ) {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> partiesRefs<T extends Object>(
    Expression<T> Function($$PartiesTableAnnotationComposer a) f,
  ) {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IconResourcesTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $IconResourcesTable,
          IconResource,
          $$IconResourcesTableFilterComposer,
          $$IconResourcesTableOrderingComposer,
          $$IconResourcesTableAnnotationComposer,
          $$IconResourcesTableCreateCompanionBuilder,
          $$IconResourcesTableUpdateCompanionBuilder,
          (IconResource, $$IconResourcesTableReferences),
          IconResource,
          PrefetchHooks Function({
            bool categoriesRefs,
            bool accountsRefs,
            bool partiesRefs,
            bool itemsRefs,
          })
        > {
  $$IconResourcesTableTableManager(_$LedgerDb db, $IconResourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IconResourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IconResourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IconResourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> iconId = const Value.absent(),
                Value<IconSource> source = const Value.absent(),
                Value<int?> codepoint = const Value.absent(),
                Value<String?> fontFamily = const Value.absent(),
                Value<String?> assetPath = const Value.absent(),
                Value<String?> mediaId = const Value.absent(),
                Value<String?> fgColor = const Value.absent(),
                Value<String?> bgColor = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IconResourcesCompanion(
                iconId: iconId,
                source: source,
                codepoint: codepoint,
                fontFamily: fontFamily,
                assetPath: assetPath,
                mediaId: mediaId,
                fgColor: fgColor,
                bgColor: bgColor,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String iconId,
                required IconSource source,
                Value<int?> codepoint = const Value.absent(),
                Value<String?> fontFamily = const Value.absent(),
                Value<String?> assetPath = const Value.absent(),
                Value<String?> mediaId = const Value.absent(),
                Value<String?> fgColor = const Value.absent(),
                Value<String?> bgColor = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IconResourcesCompanion.insert(
                iconId: iconId,
                source: source,
                codepoint: codepoint,
                fontFamily: fontFamily,
                assetPath: assetPath,
                mediaId: mediaId,
                fgColor: fgColor,
                bgColor: bgColor,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IconResourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoriesRefs = false,
                accountsRefs = false,
                partiesRefs = false,
                itemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (categoriesRefs) db.categories,
                    if (accountsRefs) db.accounts,
                    if (partiesRefs) db.parties,
                    if (itemsRefs) db.items,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (categoriesRefs)
                        await $_getPrefetchedData<
                          IconResource,
                          $IconResourcesTable,
                          Category
                        >(
                          currentTable: table,
                          referencedTable: $$IconResourcesTableReferences
                              ._categoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IconResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).categoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.iconId == item.iconId,
                              ),
                          typedResults: items,
                        ),
                      if (accountsRefs)
                        await $_getPrefetchedData<
                          IconResource,
                          $IconResourcesTable,
                          Account
                        >(
                          currentTable: table,
                          referencedTable: $$IconResourcesTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IconResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.iconId == item.iconId,
                              ),
                          typedResults: items,
                        ),
                      if (partiesRefs)
                        await $_getPrefetchedData<
                          IconResource,
                          $IconResourcesTable,
                          Party
                        >(
                          currentTable: table,
                          referencedTable: $$IconResourcesTableReferences
                              ._partiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IconResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).partiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.iconId == item.iconId,
                              ),
                          typedResults: items,
                        ),
                      if (itemsRefs)
                        await $_getPrefetchedData<
                          IconResource,
                          $IconResourcesTable,
                          Item
                        >(
                          currentTable: table,
                          referencedTable: $$IconResourcesTableReferences
                              ._itemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IconResourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).itemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.iconId == item.iconId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IconResourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $IconResourcesTable,
      IconResource,
      $$IconResourcesTableFilterComposer,
      $$IconResourcesTableOrderingComposer,
      $$IconResourcesTableAnnotationComposer,
      $$IconResourcesTableCreateCompanionBuilder,
      $$IconResourcesTableUpdateCompanionBuilder,
      (IconResource, $$IconResourcesTableReferences),
      IconResource,
      PrefetchHooks Function({
        bool categoriesRefs,
        bool accountsRefs,
        bool partiesRefs,
        bool itemsRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String categoryId,
      required CategoryType type,
      Value<String?> parentId,
      required String name,
      Value<String?> iconId,
      Value<int> sortOrder,
      Value<bool> isHidden,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> categoryId,
      Value<CategoryType> type,
      Value<String?> parentId,
      Value<String> name,
      Value<String?> iconId,
      Value<int> sortOrder,
      Value<bool> isHidden,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$LedgerDb, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IconResourcesTable _iconIdTable(_$LedgerDb db) =>
      db.iconResources.createAlias(
        $_aliasNameGenerator(db.categories.iconId, db.iconResources.iconId),
      );

  $$IconResourcesTableProcessedTableManager? get iconId {
    final $_column = $_itemColumn<String>('icon_id');
    if ($_column == null) return null;
    final manager = $$IconResourcesTableTableManager(
      $_db,
      $_db.iconResources,
    ).filter((f) => f.iconId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_iconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PartiesTable, List<Party>> _partiesRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.parties,
    aliasName: $_aliasNameGenerator(
      db.categories.categoryId,
      db.parties.defaultCategoryId,
    ),
  );

  $$PartiesTableProcessedTableManager get partiesRefs {
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter(
      (f) => f.defaultCategoryId.categoryId.sqlEquals(
        $_itemColumn<String>('category_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_partiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: $_aliasNameGenerator(
      db.categories.categoryId,
      db.items.defaultCategoryId,
    ),
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager($_db, $_db.items).filter(
      (f) => f.defaultCategoryId.categoryId.sqlEquals(
        $_itemColumn<String>('category_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(
      db.categories.categoryId,
      db.txns.categoryId,
    ),
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.categoryId.categoryId.sqlEquals(
        $_itemColumn<String>('category_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$LedgerDb, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategoryType, CategoryType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$IconResourcesTableFilterComposer get iconId {
    final $$IconResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableFilterComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> partiesRefs(
    Expression<bool> Function($$PartiesTableFilterComposer f) f,
  ) {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableFilterComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$LedgerDb, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$IconResourcesTableOrderingComposer get iconId {
    final $$IconResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$LedgerDb, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CategoryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$IconResourcesTableAnnotationComposer get iconId {
    final $$IconResourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> partiesRefs<T extends Object>(
    Expression<T> Function($$PartiesTableAnnotationComposer a) f,
  ) {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.defaultCategoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({
            bool iconId,
            bool partiesRefs,
            bool itemsRefs,
            bool txnsRefs,
          })
        > {
  $$CategoriesTableTableManager(_$LedgerDb db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> categoryId = const Value.absent(),
                Value<CategoryType> type = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                categoryId: categoryId,
                type: type,
                parentId: parentId,
                name: name,
                iconId: iconId,
                sortOrder: sortOrder,
                isHidden: isHidden,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String categoryId,
                required CategoryType type,
                Value<String?> parentId = const Value.absent(),
                required String name,
                Value<String?> iconId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                categoryId: categoryId,
                type: type,
                parentId: parentId,
                name: name,
                iconId: iconId,
                sortOrder: sortOrder,
                isHidden: isHidden,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                iconId = false,
                partiesRefs = false,
                itemsRefs = false,
                txnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (partiesRefs) db.parties,
                    if (itemsRefs) db.items,
                    if (txnsRefs) db.txns,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (iconId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.iconId,
                                    referencedTable: $$CategoriesTableReferences
                                        ._iconIdTable(db),
                                    referencedColumn:
                                        $$CategoriesTableReferences
                                            ._iconIdTable(db)
                                            .iconId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (partiesRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          Party
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._partiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).partiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultCategoryId == item.categoryId,
                              ),
                          typedResults: items,
                        ),
                      if (itemsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          Item
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._itemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).itemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultCategoryId == item.categoryId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsRefs)
                        await $_getPrefetchedData<
                          Category,
                          $CategoriesTable,
                          Txn
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.categoryId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({
        bool iconId,
        bool partiesRefs,
        bool itemsRefs,
        bool txnsRefs,
      })
    >;
typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      required String accountId,
      required String name,
      required AccountType accountType,
      Value<String> currencyCode,
      Value<String?> iconId,
      Value<int> initialBalanceMinor,
      Value<int?> initialBalanceAtMs,
      Value<int?> creditLimitMinor,
      Value<int?> billingDay,
      Value<int?> repaymentDay,
      Value<String?> note,
      Value<bool> includeInTotals,
      Value<int> sortOrder,
      Value<bool> isArchived,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> accountId,
      Value<String> name,
      Value<AccountType> accountType,
      Value<String> currencyCode,
      Value<String?> iconId,
      Value<int> initialBalanceMinor,
      Value<int?> initialBalanceAtMs,
      Value<int?> creditLimitMinor,
      Value<int?> billingDay,
      Value<int?> repaymentDay,
      Value<String?> note,
      Value<bool> includeInTotals,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$AccountsTableReferences
    extends BaseReferences<_$LedgerDb, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IconResourcesTable _iconIdTable(_$LedgerDb db) =>
      db.iconResources.createAlias(
        $_aliasNameGenerator(db.accounts.iconId, db.iconResources.iconId),
      );

  $$IconResourcesTableProcessedTableManager? get iconId {
    final $_column = $_itemColumn<String>('icon_id');
    if ($_column == null) return null;
    final manager = $$IconResourcesTableTableManager(
      $_db,
      $_db.iconResources,
    ).filter((f) => f.iconId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_iconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PartiesTable, List<Party>> _partiesRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.parties,
    aliasName: $_aliasNameGenerator(
      db.accounts.accountId,
      db.parties.defaultAccountId,
    ),
  );

  $$PartiesTableProcessedTableManager get partiesRefs {
    final manager = $$PartiesTableTableManager($_db, $_db.parties).filter(
      (f) => f.defaultAccountId.accountId.sqlEquals(
        $_itemColumn<String>('account_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_partiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsByAccountTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(db.accounts.accountId, db.txns.accountId),
  );

  $$TxnsTableProcessedTableManager get txnsByAccount {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) =>
          f.accountId.accountId.sqlEquals($_itemColumn<String>('account_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_txnsByAccountTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsByFromAccountTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(
      db.accounts.accountId,
      db.txns.fromAccountId,
    ),
  );

  $$TxnsTableProcessedTableManager get txnsByFromAccount {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.fromAccountId.accountId.sqlEquals(
        $_itemColumn<String>('account_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_txnsByFromAccountTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsByToAccountTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(db.accounts.accountId, db.txns.toAccountId),
  );

  $$TxnsTableProcessedTableManager get txnsByToAccount {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.toAccountId.accountId.sqlEquals(
        $_itemColumn<String>('account_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_txnsByToAccountTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsByFeeAccountTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(
      db.accounts.accountId,
      db.txns.feeAccountId,
    ),
  );

  $$TxnsTableProcessedTableManager get txnsByFeeAccount {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.feeAccountId.accountId.sqlEquals(
        $_itemColumn<String>('account_id')!,
      ),
    );

    final cache = $_typedResult.readTableOrNull(_txnsByFeeAccountTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$LedgerDb, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountType, AccountType, String>
  get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialBalanceMinor => $composableBuilder(
    column: $table.initialBalanceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialBalanceAtMs => $composableBuilder(
    column: $table.initialBalanceAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repaymentDay => $composableBuilder(
    column: $table.repaymentDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeInTotals => $composableBuilder(
    column: $table.includeInTotals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$IconResourcesTableFilterComposer get iconId {
    final $$IconResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableFilterComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> partiesRefs(
    Expression<bool> Function($$PartiesTableFilterComposer f) f,
  ) {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.defaultAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableFilterComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsByAccount(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsByFromAccount(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.fromAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsByToAccount(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.toAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsByFeeAccount(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.feeAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$LedgerDb, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialBalanceMinor => $composableBuilder(
    column: $table.initialBalanceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialBalanceAtMs => $composableBuilder(
    column: $table.initialBalanceAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repaymentDay => $composableBuilder(
    column: $table.repaymentDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeInTotals => $composableBuilder(
    column: $table.includeInTotals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$IconResourcesTableOrderingComposer get iconId {
    final $$IconResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$LedgerDb, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountType, String> get accountType =>
      $composableBuilder(
        column: $table.accountType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialBalanceMinor => $composableBuilder(
    column: $table.initialBalanceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialBalanceAtMs => $composableBuilder(
    column: $table.initialBalanceAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get creditLimitMinor => $composableBuilder(
    column: $table.creditLimitMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repaymentDay => $composableBuilder(
    column: $table.repaymentDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get includeInTotals => $composableBuilder(
    column: $table.includeInTotals,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$IconResourcesTableAnnotationComposer get iconId {
    final $$IconResourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> partiesRefs<T extends Object>(
    Expression<T> Function($$PartiesTableAnnotationComposer a) f,
  ) {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.defaultAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsByAccount<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsByFromAccount<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.fromAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsByToAccount<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.toAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsByFeeAccount<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.feeAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({
            bool iconId,
            bool partiesRefs,
            bool txnsByAccount,
            bool txnsByFromAccount,
            bool txnsByToAccount,
            bool txnsByFeeAccount,
          })
        > {
  $$AccountsTableTableManager(_$LedgerDb db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<AccountType> accountType = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String?> iconId = const Value.absent(),
                Value<int> initialBalanceMinor = const Value.absent(),
                Value<int?> initialBalanceAtMs = const Value.absent(),
                Value<int?> creditLimitMinor = const Value.absent(),
                Value<int?> billingDay = const Value.absent(),
                Value<int?> repaymentDay = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> includeInTotals = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                accountId: accountId,
                name: name,
                accountType: accountType,
                currencyCode: currencyCode,
                iconId: iconId,
                initialBalanceMinor: initialBalanceMinor,
                initialBalanceAtMs: initialBalanceAtMs,
                creditLimitMinor: creditLimitMinor,
                billingDay: billingDay,
                repaymentDay: repaymentDay,
                note: note,
                includeInTotals: includeInTotals,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                required String name,
                required AccountType accountType,
                Value<String> currencyCode = const Value.absent(),
                Value<String?> iconId = const Value.absent(),
                Value<int> initialBalanceMinor = const Value.absent(),
                Value<int?> initialBalanceAtMs = const Value.absent(),
                Value<int?> creditLimitMinor = const Value.absent(),
                Value<int?> billingDay = const Value.absent(),
                Value<int?> repaymentDay = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> includeInTotals = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                accountId: accountId,
                name: name,
                accountType: accountType,
                currencyCode: currencyCode,
                iconId: iconId,
                initialBalanceMinor: initialBalanceMinor,
                initialBalanceAtMs: initialBalanceAtMs,
                creditLimitMinor: creditLimitMinor,
                billingDay: billingDay,
                repaymentDay: repaymentDay,
                note: note,
                includeInTotals: includeInTotals,
                sortOrder: sortOrder,
                isArchived: isArchived,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                iconId = false,
                partiesRefs = false,
                txnsByAccount = false,
                txnsByFromAccount = false,
                txnsByToAccount = false,
                txnsByFeeAccount = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (partiesRefs) db.parties,
                    if (txnsByAccount) db.txns,
                    if (txnsByFromAccount) db.txns,
                    if (txnsByToAccount) db.txns,
                    if (txnsByFeeAccount) db.txns,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (iconId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.iconId,
                                    referencedTable: $$AccountsTableReferences
                                        ._iconIdTable(db),
                                    referencedColumn: $$AccountsTableReferences
                                        ._iconIdTable(db)
                                        .iconId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (partiesRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          Party
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._partiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).partiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultAccountId == item.accountId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsByAccount)
                        await $_getPrefetchedData<Account, $AccountsTable, Txn>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._txnsByAccountTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsByAccount,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.accountId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsByFromAccount)
                        await $_getPrefetchedData<Account, $AccountsTable, Txn>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._txnsByFromAccountTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsByFromAccount,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fromAccountId == item.accountId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsByToAccount)
                        await $_getPrefetchedData<Account, $AccountsTable, Txn>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._txnsByToAccountTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsByToAccount,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.toAccountId == item.accountId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsByFeeAccount)
                        await $_getPrefetchedData<Account, $AccountsTable, Txn>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._txnsByFeeAccountTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).txnsByFeeAccount,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.feeAccountId == item.accountId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({
        bool iconId,
        bool partiesRefs,
        bool txnsByAccount,
        bool txnsByFromAccount,
        bool txnsByToAccount,
        bool txnsByFeeAccount,
      })
    >;
typedef $$PartiesTableCreateCompanionBuilder =
    PartiesCompanion Function({
      required String partyId,
      required String name,
      required PartyType partyType,
      Value<String?> iconId,
      Value<String?> phone,
      Value<String?> note,
      Value<String?> defaultCategoryId,
      Value<String?> defaultAccountId,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$PartiesTableUpdateCompanionBuilder =
    PartiesCompanion Function({
      Value<String> partyId,
      Value<String> name,
      Value<PartyType> partyType,
      Value<String?> iconId,
      Value<String?> phone,
      Value<String?> note,
      Value<String?> defaultCategoryId,
      Value<String?> defaultAccountId,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$PartiesTableReferences
    extends BaseReferences<_$LedgerDb, $PartiesTable, Party> {
  $$PartiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IconResourcesTable _iconIdTable(_$LedgerDb db) =>
      db.iconResources.createAlias(
        $_aliasNameGenerator(db.parties.iconId, db.iconResources.iconId),
      );

  $$IconResourcesTableProcessedTableManager? get iconId {
    final $_column = $_itemColumn<String>('icon_id');
    if ($_column == null) return null;
    final manager = $$IconResourcesTableTableManager(
      $_db,
      $_db.iconResources,
    ).filter((f) => f.iconId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_iconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _defaultCategoryIdTable(_$LedgerDb db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(
          db.parties.defaultCategoryId,
          db.categories.categoryId,
        ),
      );

  $$CategoriesTableProcessedTableManager? get defaultCategoryId {
    final $_column = $_itemColumn<String>('default_category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.categoryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _defaultAccountIdTable(_$LedgerDb db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(
          db.parties.defaultAccountId,
          db.accounts.accountId,
        ),
      );

  $$AccountsTableProcessedTableManager? get defaultAccountId {
    final $_column = $_itemColumn<String>('default_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.accountId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: $_aliasNameGenerator(
      db.parties.partyId,
      db.items.defaultPartyId,
    ),
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager($_db, $_db.items).filter(
      (f) =>
          f.defaultPartyId.partyId.sqlEquals($_itemColumn<String>('party_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(db.parties.partyId, db.txns.partyId),
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.partyId.partyId.sqlEquals($_itemColumn<String>('party_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PartiesTableFilterComposer extends Composer<_$LedgerDb, $PartiesTable> {
  $$PartiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get partyId => $composableBuilder(
    column: $table.partyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PartyType, PartyType, String> get partyType =>
      $composableBuilder(
        column: $table.partyType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$IconResourcesTableFilterComposer get iconId {
    final $$IconResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableFilterComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get defaultCategoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get defaultAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.defaultPartyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartiesTableOrderingComposer
    extends Composer<_$LedgerDb, $PartiesTable> {
  $$PartiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get partyId => $composableBuilder(
    column: $table.partyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyType => $composableBuilder(
    column: $table.partyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$IconResourcesTableOrderingComposer get iconId {
    final $$IconResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get defaultCategoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get defaultAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PartiesTableAnnotationComposer
    extends Composer<_$LedgerDb, $PartiesTable> {
  $$PartiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get partyId =>
      $composableBuilder(column: $table.partyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PartyType, String> get partyType =>
      $composableBuilder(column: $table.partyType, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$IconResourcesTableAnnotationComposer get iconId {
    final $$IconResourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get defaultCategoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get defaultAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.defaultPartyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PartiesTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $PartiesTable,
          Party,
          $$PartiesTableFilterComposer,
          $$PartiesTableOrderingComposer,
          $$PartiesTableAnnotationComposer,
          $$PartiesTableCreateCompanionBuilder,
          $$PartiesTableUpdateCompanionBuilder,
          (Party, $$PartiesTableReferences),
          Party,
          PrefetchHooks Function({
            bool iconId,
            bool defaultCategoryId,
            bool defaultAccountId,
            bool itemsRefs,
            bool txnsRefs,
          })
        > {
  $$PartiesTableTableManager(_$LedgerDb db, $PartiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> partyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<PartyType> partyType = const Value.absent(),
                Value<String?> iconId = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultAccountId = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartiesCompanion(
                partyId: partyId,
                name: name,
                partyType: partyType,
                iconId: iconId,
                phone: phone,
                note: note,
                defaultCategoryId: defaultCategoryId,
                defaultAccountId: defaultAccountId,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String partyId,
                required String name,
                required PartyType partyType,
                Value<String?> iconId = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultAccountId = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PartiesCompanion.insert(
                partyId: partyId,
                name: name,
                partyType: partyType,
                iconId: iconId,
                phone: phone,
                note: note,
                defaultCategoryId: defaultCategoryId,
                defaultAccountId: defaultAccountId,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PartiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                iconId = false,
                defaultCategoryId = false,
                defaultAccountId = false,
                itemsRefs = false,
                txnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itemsRefs) db.items,
                    if (txnsRefs) db.txns,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (iconId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.iconId,
                                    referencedTable: $$PartiesTableReferences
                                        ._iconIdTable(db),
                                    referencedColumn: $$PartiesTableReferences
                                        ._iconIdTable(db)
                                        .iconId,
                                  )
                                  as T;
                        }
                        if (defaultCategoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultCategoryId,
                                    referencedTable: $$PartiesTableReferences
                                        ._defaultCategoryIdTable(db),
                                    referencedColumn: $$PartiesTableReferences
                                        ._defaultCategoryIdTable(db)
                                        .categoryId,
                                  )
                                  as T;
                        }
                        if (defaultAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultAccountId,
                                    referencedTable: $$PartiesTableReferences
                                        ._defaultAccountIdTable(db),
                                    referencedColumn: $$PartiesTableReferences
                                        ._defaultAccountIdTable(db)
                                        .accountId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itemsRefs)
                        await $_getPrefetchedData<Party, $PartiesTable, Item>(
                          currentTable: table,
                          referencedTable: $$PartiesTableReferences
                              ._itemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartiesTableReferences(db, table, p0).itemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultPartyId == item.partyId,
                              ),
                          typedResults: items,
                        ),
                      if (txnsRefs)
                        await $_getPrefetchedData<Party, $PartiesTable, Txn>(
                          currentTable: table,
                          referencedTable: $$PartiesTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PartiesTableReferences(db, table, p0).txnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.partyId == item.partyId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PartiesTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $PartiesTable,
      Party,
      $$PartiesTableFilterComposer,
      $$PartiesTableOrderingComposer,
      $$PartiesTableAnnotationComposer,
      $$PartiesTableCreateCompanionBuilder,
      $$PartiesTableUpdateCompanionBuilder,
      (Party, $$PartiesTableReferences),
      Party,
      PrefetchHooks Function({
        bool iconId,
        bool defaultCategoryId,
        bool defaultAccountId,
        bool itemsRefs,
        bool txnsRefs,
      })
    >;
typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      required String itemId,
      required String name,
      Value<String?> iconId,
      Value<String?> defaultCategoryId,
      Value<String?> defaultPartyId,
      Value<String?> note,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<String> itemId,
      Value<String> name,
      Value<String?> iconId,
      Value<String?> defaultCategoryId,
      Value<String?> defaultPartyId,
      Value<String?> note,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$LedgerDb, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IconResourcesTable _iconIdTable(_$LedgerDb db) =>
      db.iconResources.createAlias(
        $_aliasNameGenerator(db.items.iconId, db.iconResources.iconId),
      );

  $$IconResourcesTableProcessedTableManager? get iconId {
    final $_column = $_itemColumn<String>('icon_id');
    if ($_column == null) return null;
    final manager = $$IconResourcesTableTableManager(
      $_db,
      $_db.iconResources,
    ).filter((f) => f.iconId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_iconIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _defaultCategoryIdTable(_$LedgerDb db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(
          db.items.defaultCategoryId,
          db.categories.categoryId,
        ),
      );

  $$CategoriesTableProcessedTableManager? get defaultCategoryId {
    final $_column = $_itemColumn<String>('default_category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.categoryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultCategoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PartiesTable _defaultPartyIdTable(_$LedgerDb db) =>
      db.parties.createAlias(
        $_aliasNameGenerator(db.items.defaultPartyId, db.parties.partyId),
      );

  $$PartiesTableProcessedTableManager? get defaultPartyId {
    final $_column = $_itemColumn<String>('default_party_id');
    if ($_column == null) return null;
    final manager = $$PartiesTableTableManager(
      $_db,
      $_db.parties,
    ).filter((f) => f.partyId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_defaultPartyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TxnsTable, List<Txn>> _txnsRefsTable(
    _$LedgerDb db,
  ) => MultiTypedResultKey.fromTable(
    db.txns,
    aliasName: $_aliasNameGenerator(db.items.itemId, db.txns.itemId),
  );

  $$TxnsTableProcessedTableManager get txnsRefs {
    final manager = $$TxnsTableTableManager($_db, $_db.txns).filter(
      (f) => f.itemId.itemId.sqlEquals($_itemColumn<String>('item_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_txnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$LedgerDb, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$IconResourcesTableFilterComposer get iconId {
    final $$IconResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableFilterComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get defaultCategoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableFilterComposer get defaultPartyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPartyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableFilterComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> txnsRefs(
    Expression<bool> Function($$TxnsTableFilterComposer f) f,
  ) {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer extends Composer<_$LedgerDb, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$IconResourcesTableOrderingComposer get iconId {
    final $$IconResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get defaultCategoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableOrderingComposer get defaultPartyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPartyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableOrderingComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableAnnotationComposer extends Composer<_$LedgerDb, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$IconResourcesTableAnnotationComposer get iconId {
    final $$IconResourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.iconId,
      referencedTable: $db.iconResources,
      getReferencedColumn: (t) => t.iconId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IconResourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.iconResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get defaultCategoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultCategoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableAnnotationComposer get defaultPartyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPartyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> txnsRefs<T extends Object>(
    Expression<T> Function($$TxnsTableAnnotationComposer a) f,
  ) {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({
            bool iconId,
            bool defaultCategoryId,
            bool defaultPartyId,
            bool txnsRefs,
          })
        > {
  $$ItemsTableTableManager(_$LedgerDb db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconId = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultPartyId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion(
                itemId: itemId,
                name: name,
                iconId: iconId,
                defaultCategoryId: defaultCategoryId,
                defaultPartyId: defaultPartyId,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemId,
                required String name,
                Value<String?> iconId = const Value.absent(),
                Value<String?> defaultCategoryId = const Value.absent(),
                Value<String?> defaultPartyId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion.insert(
                itemId: itemId,
                name: name,
                iconId: iconId,
                defaultCategoryId: defaultCategoryId,
                defaultPartyId: defaultPartyId,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                iconId = false,
                defaultCategoryId = false,
                defaultPartyId = false,
                txnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (txnsRefs) db.txns],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (iconId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.iconId,
                                    referencedTable: $$ItemsTableReferences
                                        ._iconIdTable(db),
                                    referencedColumn: $$ItemsTableReferences
                                        ._iconIdTable(db)
                                        .iconId,
                                  )
                                  as T;
                        }
                        if (defaultCategoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultCategoryId,
                                    referencedTable: $$ItemsTableReferences
                                        ._defaultCategoryIdTable(db),
                                    referencedColumn: $$ItemsTableReferences
                                        ._defaultCategoryIdTable(db)
                                        .categoryId,
                                  )
                                  as T;
                        }
                        if (defaultPartyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.defaultPartyId,
                                    referencedTable: $$ItemsTableReferences
                                        ._defaultPartyIdTable(db),
                                    referencedColumn: $$ItemsTableReferences
                                        ._defaultPartyIdTable(db)
                                        .partyId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (txnsRefs)
                        await $_getPrefetchedData<Item, $ItemsTable, Txn>(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._txnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(db, table, p0).txnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.itemId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({
        bool iconId,
        bool defaultCategoryId,
        bool defaultPartyId,
        bool txnsRefs,
      })
    >;
typedef $$TxnsTableCreateCompanionBuilder =
    TxnsCompanion Function({
      required String txnId,
      required TxnType txnType,
      Value<TxnStatus> status,
      required int occurredAtMs,
      Value<String> currencyCode,
      required int amountMinor,
      Value<String?> accountId,
      Value<String?> categoryId,
      Value<String?> partyId,
      Value<String?> itemId,
      Value<String?> fromAccountId,
      Value<String?> toAccountId,
      Value<int> feeAmountMinor,
      Value<String?> feeAccountId,
      Value<String?> note,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$TxnsTableUpdateCompanionBuilder =
    TxnsCompanion Function({
      Value<String> txnId,
      Value<TxnType> txnType,
      Value<TxnStatus> status,
      Value<int> occurredAtMs,
      Value<String> currencyCode,
      Value<int> amountMinor,
      Value<String?> accountId,
      Value<String?> categoryId,
      Value<String?> partyId,
      Value<String?> itemId,
      Value<String?> fromAccountId,
      Value<String?> toAccountId,
      Value<int> feeAmountMinor,
      Value<String?> feeAccountId,
      Value<String?> note,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$TxnsTableReferences
    extends BaseReferences<_$LedgerDb, $TxnsTable, Txn> {
  $$TxnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$LedgerDb db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.txns.accountId, db.accounts.accountId),
      );

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<String>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.accountId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$LedgerDb db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.txns.categoryId, db.categories.categoryId),
      );

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.categoryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PartiesTable _partyIdTable(_$LedgerDb db) => db.parties.createAlias(
    $_aliasNameGenerator(db.txns.partyId, db.parties.partyId),
  );

  $$PartiesTableProcessedTableManager? get partyId {
    final $_column = $_itemColumn<String>('party_id');
    if ($_column == null) return null;
    final manager = $$PartiesTableTableManager(
      $_db,
      $_db.parties,
    ).filter((f) => f.partyId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$LedgerDb db) => db.items.createAlias(
    $_aliasNameGenerator(db.txns.itemId, db.items.itemId),
  );

  $$ItemsTableProcessedTableManager? get itemId {
    final $_column = $_itemColumn<String>('item_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.itemId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _fromAccountIdTable(_$LedgerDb db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.txns.fromAccountId, db.accounts.accountId),
      );

  $$AccountsTableProcessedTableManager? get fromAccountId {
    final $_column = $_itemColumn<String>('from_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.accountId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _toAccountIdTable(_$LedgerDb db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.txns.toAccountId, db.accounts.accountId),
      );

  $$AccountsTableProcessedTableManager? get toAccountId {
    final $_column = $_itemColumn<String>('to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.accountId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _feeAccountIdTable(_$LedgerDb db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.txns.feeAccountId, db.accounts.accountId),
      );

  $$AccountsTableProcessedTableManager? get feeAccountId {
    final $_column = $_itemColumn<String>('fee_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.accountId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_feeAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TxnAttachmentsTable, List<TxnAttachment>>
  _txnAttachmentsRefsTable(_$LedgerDb db) => MultiTypedResultKey.fromTable(
    db.txnAttachments,
    aliasName: $_aliasNameGenerator(db.txns.txnId, db.txnAttachments.txnId),
  );

  $$TxnAttachmentsTableProcessedTableManager get txnAttachmentsRefs {
    final manager = $$TxnAttachmentsTableTableManager(
      $_db,
      $_db.txnAttachments,
    ).filter((f) => f.txnId.txnId.sqlEquals($_itemColumn<String>('txn_id')!));

    final cache = $_typedResult.readTableOrNull(_txnAttachmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TxnsTableFilterComposer extends Composer<_$LedgerDb, $TxnsTable> {
  $$TxnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get txnId => $composableBuilder(
    column: $table.txnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TxnType, TxnType, String> get txnType =>
      $composableBuilder(
        column: $table.txnType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TxnStatus, TxnStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get occurredAtMs => $composableBuilder(
    column: $table.occurredAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get feeAmountMinor => $composableBuilder(
    column: $table.feeAmountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableFilterComposer get partyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableFilterComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get fromAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get toAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get feeAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> txnAttachmentsRefs(
    Expression<bool> Function($$TxnAttachmentsTableFilterComposer f) f,
  ) {
    final $$TxnAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txnAttachments,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.txnAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TxnsTableOrderingComposer extends Composer<_$LedgerDb, $TxnsTable> {
  $$TxnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get txnId => $composableBuilder(
    column: $table.txnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get txnType => $composableBuilder(
    column: $table.txnType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurredAtMs => $composableBuilder(
    column: $table.occurredAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get feeAmountMinor => $composableBuilder(
    column: $table.feeAmountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableOrderingComposer get partyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableOrderingComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get fromAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get toAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get feeAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TxnsTableAnnotationComposer extends Composer<_$LedgerDb, $TxnsTable> {
  $$TxnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get txnId =>
      $composableBuilder(column: $table.txnId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxnType, String> get txnType =>
      $composableBuilder(column: $table.txnType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxnStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get occurredAtMs => $composableBuilder(
    column: $table.occurredAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get feeAmountMinor => $composableBuilder(
    column: $table.feeAmountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PartiesTableAnnotationComposer get partyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.partyId,
      referencedTable: $db.parties,
      getReferencedColumn: (t) => t.partyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PartiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get fromAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get toAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get feeAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.feeAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> txnAttachmentsRefs<T extends Object>(
    Expression<T> Function($$TxnAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$TxnAttachmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txnAttachments,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnAttachmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.txnAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TxnsTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $TxnsTable,
          Txn,
          $$TxnsTableFilterComposer,
          $$TxnsTableOrderingComposer,
          $$TxnsTableAnnotationComposer,
          $$TxnsTableCreateCompanionBuilder,
          $$TxnsTableUpdateCompanionBuilder,
          (Txn, $$TxnsTableReferences),
          Txn,
          PrefetchHooks Function({
            bool accountId,
            bool categoryId,
            bool partyId,
            bool itemId,
            bool fromAccountId,
            bool toAccountId,
            bool feeAccountId,
            bool txnAttachmentsRefs,
          })
        > {
  $$TxnsTableTableManager(_$LedgerDb db, $TxnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TxnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TxnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TxnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> txnId = const Value.absent(),
                Value<TxnType> txnType = const Value.absent(),
                Value<TxnStatus> status = const Value.absent(),
                Value<int> occurredAtMs = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String?> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> partyId = const Value.absent(),
                Value<String?> itemId = const Value.absent(),
                Value<String?> fromAccountId = const Value.absent(),
                Value<String?> toAccountId = const Value.absent(),
                Value<int> feeAmountMinor = const Value.absent(),
                Value<String?> feeAccountId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion(
                txnId: txnId,
                txnType: txnType,
                status: status,
                occurredAtMs: occurredAtMs,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                accountId: accountId,
                categoryId: categoryId,
                partyId: partyId,
                itemId: itemId,
                fromAccountId: fromAccountId,
                toAccountId: toAccountId,
                feeAmountMinor: feeAmountMinor,
                feeAccountId: feeAccountId,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String txnId,
                required TxnType txnType,
                Value<TxnStatus> status = const Value.absent(),
                required int occurredAtMs,
                Value<String> currencyCode = const Value.absent(),
                required int amountMinor,
                Value<String?> accountId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> partyId = const Value.absent(),
                Value<String?> itemId = const Value.absent(),
                Value<String?> fromAccountId = const Value.absent(),
                Value<String?> toAccountId = const Value.absent(),
                Value<int> feeAmountMinor = const Value.absent(),
                Value<String?> feeAccountId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnsCompanion.insert(
                txnId: txnId,
                txnType: txnType,
                status: status,
                occurredAtMs: occurredAtMs,
                currencyCode: currencyCode,
                amountMinor: amountMinor,
                accountId: accountId,
                categoryId: categoryId,
                partyId: partyId,
                itemId: itemId,
                fromAccountId: fromAccountId,
                toAccountId: toAccountId,
                feeAmountMinor: feeAmountMinor,
                feeAccountId: feeAccountId,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TxnsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                accountId = false,
                categoryId = false,
                partyId = false,
                itemId = false,
                fromAccountId = false,
                toAccountId = false,
                feeAccountId = false,
                txnAttachmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (txnAttachmentsRefs) db.txnAttachments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable: $$TxnsTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._accountIdTable(db)
                                        .accountId,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$TxnsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._categoryIdTable(db)
                                        .categoryId,
                                  )
                                  as T;
                        }
                        if (partyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.partyId,
                                    referencedTable: $$TxnsTableReferences
                                        ._partyIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._partyIdTable(db)
                                        .partyId,
                                  )
                                  as T;
                        }
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable: $$TxnsTableReferences
                                        ._itemIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._itemIdTable(db)
                                        .itemId,
                                  )
                                  as T;
                        }
                        if (fromAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.fromAccountId,
                                    referencedTable: $$TxnsTableReferences
                                        ._fromAccountIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._fromAccountIdTable(db)
                                        .accountId,
                                  )
                                  as T;
                        }
                        if (toAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.toAccountId,
                                    referencedTable: $$TxnsTableReferences
                                        ._toAccountIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._toAccountIdTable(db)
                                        .accountId,
                                  )
                                  as T;
                        }
                        if (feeAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.feeAccountId,
                                    referencedTable: $$TxnsTableReferences
                                        ._feeAccountIdTable(db),
                                    referencedColumn: $$TxnsTableReferences
                                        ._feeAccountIdTable(db)
                                        .accountId,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (txnAttachmentsRefs)
                        await $_getPrefetchedData<
                          Txn,
                          $TxnsTable,
                          TxnAttachment
                        >(
                          currentTable: table,
                          referencedTable: $$TxnsTableReferences
                              ._txnAttachmentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TxnsTableReferences(
                            db,
                            table,
                            p0,
                          ).txnAttachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.txnId == item.txnId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TxnsTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $TxnsTable,
      Txn,
      $$TxnsTableFilterComposer,
      $$TxnsTableOrderingComposer,
      $$TxnsTableAnnotationComposer,
      $$TxnsTableCreateCompanionBuilder,
      $$TxnsTableUpdateCompanionBuilder,
      (Txn, $$TxnsTableReferences),
      Txn,
      PrefetchHooks Function({
        bool accountId,
        bool categoryId,
        bool partyId,
        bool itemId,
        bool fromAccountId,
        bool toAccountId,
        bool feeAccountId,
        bool txnAttachmentsRefs,
      })
    >;
typedef $$TxnAttachmentsTableCreateCompanionBuilder =
    TxnAttachmentsCompanion Function({
      required String attachmentId,
      required String txnId,
      required String mediaId,
      Value<AttachmentPurpose> purpose,
      Value<int> sortOrder,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$TxnAttachmentsTableUpdateCompanionBuilder =
    TxnAttachmentsCompanion Function({
      Value<String> attachmentId,
      Value<String> txnId,
      Value<String> mediaId,
      Value<AttachmentPurpose> purpose,
      Value<int> sortOrder,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$TxnAttachmentsTableReferences
    extends BaseReferences<_$LedgerDb, $TxnAttachmentsTable, TxnAttachment> {
  $$TxnAttachmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TxnsTable _txnIdTable(_$LedgerDb db) => db.txns.createAlias(
    $_aliasNameGenerator(db.txnAttachments.txnId, db.txns.txnId),
  );

  $$TxnsTableProcessedTableManager get txnId {
    final $_column = $_itemColumn<String>('txn_id')!;

    final manager = $$TxnsTableTableManager(
      $_db,
      $_db.txns,
    ).filter((f) => f.txnId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_txnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TxnAttachmentsTableFilterComposer
    extends Composer<_$LedgerDb, $TxnAttachmentsTable> {
  $$TxnAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get attachmentId => $composableBuilder(
    column: $table.attachmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AttachmentPurpose, AttachmentPurpose, String>
  get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$TxnsTableFilterComposer get txnId {
    final $$TxnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableFilterComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TxnAttachmentsTableOrderingComposer
    extends Composer<_$LedgerDb, $TxnAttachmentsTable> {
  $$TxnAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get attachmentId => $composableBuilder(
    column: $table.attachmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purpose => $composableBuilder(
    column: $table.purpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$TxnsTableOrderingComposer get txnId {
    final $$TxnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableOrderingComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TxnAttachmentsTableAnnotationComposer
    extends Composer<_$LedgerDb, $TxnAttachmentsTable> {
  $$TxnAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get attachmentId => $composableBuilder(
    column: $table.attachmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mediaId =>
      $composableBuilder(column: $table.mediaId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AttachmentPurpose, String> get purpose =>
      $composableBuilder(column: $table.purpose, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$TxnsTableAnnotationComposer get txnId {
    final $$TxnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.txnId,
      referencedTable: $db.txns,
      getReferencedColumn: (t) => t.txnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TxnsTableAnnotationComposer(
            $db: $db,
            $table: $db.txns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TxnAttachmentsTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $TxnAttachmentsTable,
          TxnAttachment,
          $$TxnAttachmentsTableFilterComposer,
          $$TxnAttachmentsTableOrderingComposer,
          $$TxnAttachmentsTableAnnotationComposer,
          $$TxnAttachmentsTableCreateCompanionBuilder,
          $$TxnAttachmentsTableUpdateCompanionBuilder,
          (TxnAttachment, $$TxnAttachmentsTableReferences),
          TxnAttachment,
          PrefetchHooks Function({bool txnId})
        > {
  $$TxnAttachmentsTableTableManager(_$LedgerDb db, $TxnAttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TxnAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TxnAttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TxnAttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> attachmentId = const Value.absent(),
                Value<String> txnId = const Value.absent(),
                Value<String> mediaId = const Value.absent(),
                Value<AttachmentPurpose> purpose = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnAttachmentsCompanion(
                attachmentId: attachmentId,
                txnId: txnId,
                mediaId: mediaId,
                purpose: purpose,
                sortOrder: sortOrder,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String attachmentId,
                required String txnId,
                required String mediaId,
                Value<AttachmentPurpose> purpose = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TxnAttachmentsCompanion.insert(
                attachmentId: attachmentId,
                txnId: txnId,
                mediaId: mediaId,
                purpose: purpose,
                sortOrder: sortOrder,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TxnAttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({txnId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (txnId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.txnId,
                                referencedTable: $$TxnAttachmentsTableReferences
                                    ._txnIdTable(db),
                                referencedColumn:
                                    $$TxnAttachmentsTableReferences
                                        ._txnIdTable(db)
                                        .txnId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TxnAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $TxnAttachmentsTable,
      TxnAttachment,
      $$TxnAttachmentsTableFilterComposer,
      $$TxnAttachmentsTableOrderingComposer,
      $$TxnAttachmentsTableAnnotationComposer,
      $$TxnAttachmentsTableCreateCompanionBuilder,
      $$TxnAttachmentsTableUpdateCompanionBuilder,
      (TxnAttachment, $$TxnAttachmentsTableReferences),
      TxnAttachment,
      PrefetchHooks Function({bool txnId})
    >;
typedef $$BudgetPlansTableCreateCompanionBuilder =
    BudgetPlansCompanion Function({
      required String budgetId,
      required String month,
      required BudgetScopeType scopeType,
      Value<String?> scopeId,
      required int amountMinor,
      Value<RolloverRule> rolloverRule,
      Value<String?> note,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$BudgetPlansTableUpdateCompanionBuilder =
    BudgetPlansCompanion Function({
      Value<String> budgetId,
      Value<String> month,
      Value<BudgetScopeType> scopeType,
      Value<String?> scopeId,
      Value<int> amountMinor,
      Value<RolloverRule> rolloverRule,
      Value<String?> note,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

class $$BudgetPlansTableFilterComposer
    extends Composer<_$LedgerDb, $BudgetPlansTable> {
  $$BudgetPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get budgetId => $composableBuilder(
    column: $table.budgetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BudgetScopeType, BudgetScopeType, String>
  get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RolloverRule, RolloverRule, String>
  get rolloverRule => $composableBuilder(
    column: $table.rolloverRule,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetPlansTableOrderingComposer
    extends Composer<_$LedgerDb, $BudgetPlansTable> {
  $$BudgetPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get budgetId => $composableBuilder(
    column: $table.budgetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeType => $composableBuilder(
    column: $table.scopeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scopeId => $composableBuilder(
    column: $table.scopeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rolloverRule => $composableBuilder(
    column: $table.rolloverRule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetPlansTableAnnotationComposer
    extends Composer<_$LedgerDb, $BudgetPlansTable> {
  $$BudgetPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get budgetId =>
      $composableBuilder(column: $table.budgetId, builder: (column) => column);

  GeneratedColumn<String> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BudgetScopeType, String> get scopeType =>
      $composableBuilder(column: $table.scopeType, builder: (column) => column);

  GeneratedColumn<String> get scopeId =>
      $composableBuilder(column: $table.scopeId, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RolloverRule, String> get rolloverRule =>
      $composableBuilder(
        column: $table.rolloverRule,
        builder: (column) => column,
      );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$BudgetPlansTableTableManager
    extends
        RootTableManager<
          _$LedgerDb,
          $BudgetPlansTable,
          BudgetPlan,
          $$BudgetPlansTableFilterComposer,
          $$BudgetPlansTableOrderingComposer,
          $$BudgetPlansTableAnnotationComposer,
          $$BudgetPlansTableCreateCompanionBuilder,
          $$BudgetPlansTableUpdateCompanionBuilder,
          (
            BudgetPlan,
            BaseReferences<_$LedgerDb, $BudgetPlansTable, BudgetPlan>,
          ),
          BudgetPlan,
          PrefetchHooks Function()
        > {
  $$BudgetPlansTableTableManager(_$LedgerDb db, $BudgetPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> budgetId = const Value.absent(),
                Value<String> month = const Value.absent(),
                Value<BudgetScopeType> scopeType = const Value.absent(),
                Value<String?> scopeId = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<RolloverRule> rolloverRule = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPlansCompanion(
                budgetId: budgetId,
                month: month,
                scopeType: scopeType,
                scopeId: scopeId,
                amountMinor: amountMinor,
                rolloverRule: rolloverRule,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String budgetId,
                required String month,
                required BudgetScopeType scopeType,
                Value<String?> scopeId = const Value.absent(),
                required int amountMinor,
                Value<RolloverRule> rolloverRule = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPlansCompanion.insert(
                budgetId: budgetId,
                month: month,
                scopeType: scopeType,
                scopeId: scopeId,
                amountMinor: amountMinor,
                rolloverRule: rolloverRule,
                note: note,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$LedgerDb,
      $BudgetPlansTable,
      BudgetPlan,
      $$BudgetPlansTableFilterComposer,
      $$BudgetPlansTableOrderingComposer,
      $$BudgetPlansTableAnnotationComposer,
      $$BudgetPlansTableCreateCompanionBuilder,
      $$BudgetPlansTableUpdateCompanionBuilder,
      (BudgetPlan, BaseReferences<_$LedgerDb, $BudgetPlansTable, BudgetPlan>),
      BudgetPlan,
      PrefetchHooks Function()
    >;

class $LedgerDbManager {
  final _$LedgerDb _db;
  $LedgerDbManager(this._db);
  $$LedgerInfoTableTableManager get ledgerInfo =>
      $$LedgerInfoTableTableManager(_db, _db.ledgerInfo);
  $$IconResourcesTableTableManager get iconResources =>
      $$IconResourcesTableTableManager(_db, _db.iconResources);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$PartiesTableTableManager get parties =>
      $$PartiesTableTableManager(_db, _db.parties);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$TxnsTableTableManager get txns => $$TxnsTableTableManager(_db, _db.txns);
  $$TxnAttachmentsTableTableManager get txnAttachments =>
      $$TxnAttachmentsTableTableManager(_db, _db.txnAttachments);
  $$BudgetPlansTableTableManager get budgetPlans =>
      $$BudgetPlansTableTableManager(_db, _db.budgetPlans);
}
