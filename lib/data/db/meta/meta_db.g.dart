// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_db.dart';

// ignore_for_file: type=lint
class $MetaKvTable extends MetaKv with TableInfo<$MetaKvTable, MetaKvData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaKvTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kMeta = const VerificationMeta('k');
  @override
  late final GeneratedColumn<String> k = GeneratedColumn<String>(
    'k',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vMeta = const VerificationMeta('v');
  @override
  late final GeneratedColumn<String> v = GeneratedColumn<String>(
    'v',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  @override
  List<GeneratedColumn> get $columns => [k, v, updatedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta_kv';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaKvData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('k')) {
      context.handle(_kMeta, k.isAcceptableOrUnknown(data['k']!, _kMeta));
    } else if (isInserting) {
      context.missing(_kMeta);
    }
    if (data.containsKey('v')) {
      context.handle(_vMeta, v.isAcceptableOrUnknown(data['v']!, _vMeta));
    } else if (isInserting) {
      context.missing(_vMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {k};
  @override
  MetaKvData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaKvData(
      k: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}k'],
      )!,
      v: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}v'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $MetaKvTable createAlias(String alias) {
    return $MetaKvTable(attachedDatabase, alias);
  }
}

class MetaKvData extends DataClass implements Insertable<MetaKvData> {
  final String k;
  final String v;
  final int updatedAtMs;
  const MetaKvData({
    required this.k,
    required this.v,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['k'] = Variable<String>(k);
    map['v'] = Variable<String>(v);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  MetaKvCompanion toCompanion(bool nullToAbsent) {
    return MetaKvCompanion(
      k: Value(k),
      v: Value(v),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory MetaKvData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaKvData(
      k: serializer.fromJson<String>(json['k']),
      v: serializer.fromJson<String>(json['v']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'k': serializer.toJson<String>(k),
      'v': serializer.toJson<String>(v),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  MetaKvData copyWith({String? k, String? v, int? updatedAtMs}) => MetaKvData(
    k: k ?? this.k,
    v: v ?? this.v,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  MetaKvData copyWithCompanion(MetaKvCompanion data) {
    return MetaKvData(
      k: data.k.present ? data.k.value : this.k,
      v: data.v.present ? data.v.value : this.v,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaKvData(')
          ..write('k: $k, ')
          ..write('v: $v, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(k, v, updatedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaKvData &&
          other.k == this.k &&
          other.v == this.v &&
          other.updatedAtMs == this.updatedAtMs);
}

class MetaKvCompanion extends UpdateCompanion<MetaKvData> {
  final Value<String> k;
  final Value<String> v;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const MetaKvCompanion({
    this.k = const Value.absent(),
    this.v = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaKvCompanion.insert({
    required String k,
    required String v,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : k = Value(k),
       v = Value(v),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<MetaKvData> custom({
    Expression<String>? k,
    Expression<String>? v,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (k != null) 'k': k,
      if (v != null) 'v': v,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaKvCompanion copyWith({
    Value<String>? k,
    Value<String>? v,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return MetaKvCompanion(
      k: k ?? this.k,
      v: v ?? this.v,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (k.present) {
      map['k'] = Variable<String>(k.value);
    }
    if (v.present) {
      map['v'] = Variable<String>(v.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaKvCompanion(')
          ..write('k: $k, ')
          ..write('v: $v, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WbLedgersTable extends WbLedgers
    with TableInfo<$WbLedgersTable, WbLedger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WbLedgersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _templateCodeMeta = const VerificationMeta(
    'templateCode',
  );
  @override
  late final GeneratedColumn<String> templateCode = GeneratedColumn<String>(
    'template_code',
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
  static const VerificationMeta _dbFilenameMeta = const VerificationMeta(
    'dbFilename',
  );
  @override
  late final GeneratedColumn<String> dbFilename = GeneratedColumn<String>(
    'db_filename',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataDirMeta = const VerificationMeta(
    'dataDir',
  );
  @override
  late final GeneratedColumn<String> dataDir = GeneratedColumn<String>(
    'data_dir',
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
    ledgerId,
    name,
    templateCode,
    currencyCode,
    timezone,
    dbFilename,
    dataDir,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wb_ledgers';
  @override
  VerificationContext validateIntegrity(
    Insertable<WbLedger> instance, {
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
    if (data.containsKey('template_code')) {
      context.handle(
        _templateCodeMeta,
        templateCode.isAcceptableOrUnknown(
          data['template_code']!,
          _templateCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateCodeMeta);
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
    if (data.containsKey('db_filename')) {
      context.handle(
        _dbFilenameMeta,
        dbFilename.isAcceptableOrUnknown(data['db_filename']!, _dbFilenameMeta),
      );
    } else if (isInserting) {
      context.missing(_dbFilenameMeta);
    }
    if (data.containsKey('data_dir')) {
      context.handle(
        _dataDirMeta,
        dataDir.isAcceptableOrUnknown(data['data_dir']!, _dataDirMeta),
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
  WbLedger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WbLedger(
      ledgerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      templateCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_code'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      dbFilename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}db_filename'],
      )!,
      dataDir: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_dir'],
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
  $WbLedgersTable createAlias(String alias) {
    return $WbLedgersTable(attachedDatabase, alias);
  }
}

class WbLedger extends DataClass implements Insertable<WbLedger> {
  final String ledgerId;
  final String name;
  final String templateCode;
  final String currencyCode;
  final String timezone;

  /// 例如：ledger_<ledgerId>.sqlite（建议存文件名或相对路径）
  final String dbFilename;

  /// 可选：该账本的媒体目录相对路径
  final String? dataDir;
  final int createdAtMs;
  final int updatedAtMs;
  final bool isDeleted;
  const WbLedger({
    required this.ledgerId,
    required this.name,
    required this.templateCode,
    required this.currencyCode,
    required this.timezone,
    required this.dbFilename,
    this.dataDir,
    required this.createdAtMs,
    required this.updatedAtMs,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ledger_id'] = Variable<String>(ledgerId);
    map['name'] = Variable<String>(name);
    map['template_code'] = Variable<String>(templateCode);
    map['currency_code'] = Variable<String>(currencyCode);
    map['timezone'] = Variable<String>(timezone);
    map['db_filename'] = Variable<String>(dbFilename);
    if (!nullToAbsent || dataDir != null) {
      map['data_dir'] = Variable<String>(dataDir);
    }
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  WbLedgersCompanion toCompanion(bool nullToAbsent) {
    return WbLedgersCompanion(
      ledgerId: Value(ledgerId),
      name: Value(name),
      templateCode: Value(templateCode),
      currencyCode: Value(currencyCode),
      timezone: Value(timezone),
      dbFilename: Value(dbFilename),
      dataDir: dataDir == null && nullToAbsent
          ? const Value.absent()
          : Value(dataDir),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      isDeleted: Value(isDeleted),
    );
  }

  factory WbLedger.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WbLedger(
      ledgerId: serializer.fromJson<String>(json['ledgerId']),
      name: serializer.fromJson<String>(json['name']),
      templateCode: serializer.fromJson<String>(json['templateCode']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      timezone: serializer.fromJson<String>(json['timezone']),
      dbFilename: serializer.fromJson<String>(json['dbFilename']),
      dataDir: serializer.fromJson<String?>(json['dataDir']),
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
      'templateCode': serializer.toJson<String>(templateCode),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'timezone': serializer.toJson<String>(timezone),
      'dbFilename': serializer.toJson<String>(dbFilename),
      'dataDir': serializer.toJson<String?>(dataDir),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  WbLedger copyWith({
    String? ledgerId,
    String? name,
    String? templateCode,
    String? currencyCode,
    String? timezone,
    String? dbFilename,
    Value<String?> dataDir = const Value.absent(),
    int? createdAtMs,
    int? updatedAtMs,
    bool? isDeleted,
  }) => WbLedger(
    ledgerId: ledgerId ?? this.ledgerId,
    name: name ?? this.name,
    templateCode: templateCode ?? this.templateCode,
    currencyCode: currencyCode ?? this.currencyCode,
    timezone: timezone ?? this.timezone,
    dbFilename: dbFilename ?? this.dbFilename,
    dataDir: dataDir.present ? dataDir.value : this.dataDir,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  WbLedger copyWithCompanion(WbLedgersCompanion data) {
    return WbLedger(
      ledgerId: data.ledgerId.present ? data.ledgerId.value : this.ledgerId,
      name: data.name.present ? data.name.value : this.name,
      templateCode: data.templateCode.present
          ? data.templateCode.value
          : this.templateCode,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      dbFilename: data.dbFilename.present
          ? data.dbFilename.value
          : this.dbFilename,
      dataDir: data.dataDir.present ? data.dataDir.value : this.dataDir,
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
    return (StringBuffer('WbLedger(')
          ..write('ledgerId: $ledgerId, ')
          ..write('name: $name, ')
          ..write('templateCode: $templateCode, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('timezone: $timezone, ')
          ..write('dbFilename: $dbFilename, ')
          ..write('dataDir: $dataDir, ')
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
    templateCode,
    currencyCode,
    timezone,
    dbFilename,
    dataDir,
    createdAtMs,
    updatedAtMs,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WbLedger &&
          other.ledgerId == this.ledgerId &&
          other.name == this.name &&
          other.templateCode == this.templateCode &&
          other.currencyCode == this.currencyCode &&
          other.timezone == this.timezone &&
          other.dbFilename == this.dbFilename &&
          other.dataDir == this.dataDir &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.isDeleted == this.isDeleted);
}

class WbLedgersCompanion extends UpdateCompanion<WbLedger> {
  final Value<String> ledgerId;
  final Value<String> name;
  final Value<String> templateCode;
  final Value<String> currencyCode;
  final Value<String> timezone;
  final Value<String> dbFilename;
  final Value<String?> dataDir;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const WbLedgersCompanion({
    this.ledgerId = const Value.absent(),
    this.name = const Value.absent(),
    this.templateCode = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.timezone = const Value.absent(),
    this.dbFilename = const Value.absent(),
    this.dataDir = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WbLedgersCompanion.insert({
    required String ledgerId,
    required String name,
    required String templateCode,
    this.currencyCode = const Value.absent(),
    this.timezone = const Value.absent(),
    required String dbFilename,
    this.dataDir = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ledgerId = Value(ledgerId),
       name = Value(name),
       templateCode = Value(templateCode),
       dbFilename = Value(dbFilename),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<WbLedger> custom({
    Expression<String>? ledgerId,
    Expression<String>? name,
    Expression<String>? templateCode,
    Expression<String>? currencyCode,
    Expression<String>? timezone,
    Expression<String>? dbFilename,
    Expression<String>? dataDir,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ledgerId != null) 'ledger_id': ledgerId,
      if (name != null) 'name': name,
      if (templateCode != null) 'template_code': templateCode,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (timezone != null) 'timezone': timezone,
      if (dbFilename != null) 'db_filename': dbFilename,
      if (dataDir != null) 'data_dir': dataDir,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WbLedgersCompanion copyWith({
    Value<String>? ledgerId,
    Value<String>? name,
    Value<String>? templateCode,
    Value<String>? currencyCode,
    Value<String>? timezone,
    Value<String>? dbFilename,
    Value<String?>? dataDir,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return WbLedgersCompanion(
      ledgerId: ledgerId ?? this.ledgerId,
      name: name ?? this.name,
      templateCode: templateCode ?? this.templateCode,
      currencyCode: currencyCode ?? this.currencyCode,
      timezone: timezone ?? this.timezone,
      dbFilename: dbFilename ?? this.dbFilename,
      dataDir: dataDir ?? this.dataDir,
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
    if (templateCode.present) {
      map['template_code'] = Variable<String>(templateCode.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (dbFilename.present) {
      map['db_filename'] = Variable<String>(dbFilename.value);
    }
    if (dataDir.present) {
      map['data_dir'] = Variable<String>(dataDir.value);
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
    return (StringBuffer('WbLedgersCompanion(')
          ..write('ledgerId: $ledgerId, ')
          ..write('name: $name, ')
          ..write('templateCode: $templateCode, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('timezone: $timezone, ')
          ..write('dbFilename: $dbFilename, ')
          ..write('dataDir: $dataDir, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WbTemplatesTable extends WbTemplates
    with TableInfo<$WbTemplatesTable, WbTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WbTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _templateCodeMeta = const VerificationMeta(
    'templateCode',
  );
  @override
  late final GeneratedColumn<String> templateCode = GeneratedColumn<String>(
    'template_code',
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
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _builtInMeta = const VerificationMeta(
    'builtIn',
  );
  @override
  late final GeneratedColumn<bool> builtIn = GeneratedColumn<bool>(
    'built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defJsonMeta = const VerificationMeta(
    'defJson',
  );
  @override
  late final GeneratedColumn<String> defJson = GeneratedColumn<String>(
    'def_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    templateCode,
    name,
    version,
    builtIn,
    defJson,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wb_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<WbTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('template_code')) {
      context.handle(
        _templateCodeMeta,
        templateCode.isAcceptableOrUnknown(
          data['template_code']!,
          _templateCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('built_in')) {
      context.handle(
        _builtInMeta,
        builtIn.isAcceptableOrUnknown(data['built_in']!, _builtInMeta),
      );
    }
    if (data.containsKey('def_json')) {
      context.handle(
        _defJsonMeta,
        defJson.isAcceptableOrUnknown(data['def_json']!, _defJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_defJsonMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {templateCode};
  @override
  WbTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WbTemplate(
      templateCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      builtIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}built_in'],
      )!,
      defJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}def_json'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $WbTemplatesTable createAlias(String alias) {
    return $WbTemplatesTable(attachedDatabase, alias);
  }
}

class WbTemplate extends DataClass implements Insertable<WbTemplate> {
  final String templateCode;
  final String name;
  final int version;
  final bool builtIn;
  final String defJson;
  final int createdAtMs;
  final int updatedAtMs;
  const WbTemplate({
    required this.templateCode,
    required this.name,
    required this.version,
    required this.builtIn,
    required this.defJson,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['template_code'] = Variable<String>(templateCode);
    map['name'] = Variable<String>(name);
    map['version'] = Variable<int>(version);
    map['built_in'] = Variable<bool>(builtIn);
    map['def_json'] = Variable<String>(defJson);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  WbTemplatesCompanion toCompanion(bool nullToAbsent) {
    return WbTemplatesCompanion(
      templateCode: Value(templateCode),
      name: Value(name),
      version: Value(version),
      builtIn: Value(builtIn),
      defJson: Value(defJson),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory WbTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WbTemplate(
      templateCode: serializer.fromJson<String>(json['templateCode']),
      name: serializer.fromJson<String>(json['name']),
      version: serializer.fromJson<int>(json['version']),
      builtIn: serializer.fromJson<bool>(json['builtIn']),
      defJson: serializer.fromJson<String>(json['defJson']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'templateCode': serializer.toJson<String>(templateCode),
      'name': serializer.toJson<String>(name),
      'version': serializer.toJson<int>(version),
      'builtIn': serializer.toJson<bool>(builtIn),
      'defJson': serializer.toJson<String>(defJson),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  WbTemplate copyWith({
    String? templateCode,
    String? name,
    int? version,
    bool? builtIn,
    String? defJson,
    int? createdAtMs,
    int? updatedAtMs,
  }) => WbTemplate(
    templateCode: templateCode ?? this.templateCode,
    name: name ?? this.name,
    version: version ?? this.version,
    builtIn: builtIn ?? this.builtIn,
    defJson: defJson ?? this.defJson,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  WbTemplate copyWithCompanion(WbTemplatesCompanion data) {
    return WbTemplate(
      templateCode: data.templateCode.present
          ? data.templateCode.value
          : this.templateCode,
      name: data.name.present ? data.name.value : this.name,
      version: data.version.present ? data.version.value : this.version,
      builtIn: data.builtIn.present ? data.builtIn.value : this.builtIn,
      defJson: data.defJson.present ? data.defJson.value : this.defJson,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WbTemplate(')
          ..write('templateCode: $templateCode, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('builtIn: $builtIn, ')
          ..write('defJson: $defJson, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    templateCode,
    name,
    version,
    builtIn,
    defJson,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WbTemplate &&
          other.templateCode == this.templateCode &&
          other.name == this.name &&
          other.version == this.version &&
          other.builtIn == this.builtIn &&
          other.defJson == this.defJson &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class WbTemplatesCompanion extends UpdateCompanion<WbTemplate> {
  final Value<String> templateCode;
  final Value<String> name;
  final Value<int> version;
  final Value<bool> builtIn;
  final Value<String> defJson;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const WbTemplatesCompanion({
    this.templateCode = const Value.absent(),
    this.name = const Value.absent(),
    this.version = const Value.absent(),
    this.builtIn = const Value.absent(),
    this.defJson = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WbTemplatesCompanion.insert({
    required String templateCode,
    required String name,
    this.version = const Value.absent(),
    this.builtIn = const Value.absent(),
    required String defJson,
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : templateCode = Value(templateCode),
       name = Value(name),
       defJson = Value(defJson),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<WbTemplate> custom({
    Expression<String>? templateCode,
    Expression<String>? name,
    Expression<int>? version,
    Expression<bool>? builtIn,
    Expression<String>? defJson,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (templateCode != null) 'template_code': templateCode,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (builtIn != null) 'built_in': builtIn,
      if (defJson != null) 'def_json': defJson,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WbTemplatesCompanion copyWith({
    Value<String>? templateCode,
    Value<String>? name,
    Value<int>? version,
    Value<bool>? builtIn,
    Value<String>? defJson,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return WbTemplatesCompanion(
      templateCode: templateCode ?? this.templateCode,
      name: name ?? this.name,
      version: version ?? this.version,
      builtIn: builtIn ?? this.builtIn,
      defJson: defJson ?? this.defJson,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (templateCode.present) {
      map['template_code'] = Variable<String>(templateCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (builtIn.present) {
      map['built_in'] = Variable<bool>(builtIn.value);
    }
    if (defJson.present) {
      map['def_json'] = Variable<String>(defJson.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WbTemplatesCompanion(')
          ..write('templateCode: $templateCode, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('builtIn: $builtIn, ')
          ..write('defJson: $defJson, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WbLedgerRecentsTable extends WbLedgerRecents
    with TableInfo<$WbLedgerRecentsTable, WbLedgerRecent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WbLedgerRecentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
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
  static const VerificationMeta _openedAtMsMeta = const VerificationMeta(
    'openedAtMs',
  );
  @override
  late final GeneratedColumn<int> openedAtMs = GeneratedColumn<int>(
    'opened_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ledgerId, openedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wb_ledger_recents';
  @override
  VerificationContext validateIntegrity(
    Insertable<WbLedgerRecent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ledger_id')) {
      context.handle(
        _ledgerIdMeta,
        ledgerId.isAcceptableOrUnknown(data['ledger_id']!, _ledgerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ledgerIdMeta);
    }
    if (data.containsKey('opened_at_ms')) {
      context.handle(
        _openedAtMsMeta,
        openedAtMs.isAcceptableOrUnknown(
          data['opened_at_ms']!,
          _openedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WbLedgerRecent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WbLedgerRecent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ledgerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_id'],
      )!,
      openedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opened_at_ms'],
      )!,
    );
  }

  @override
  $WbLedgerRecentsTable createAlias(String alias) {
    return $WbLedgerRecentsTable(attachedDatabase, alias);
  }
}

class WbLedgerRecent extends DataClass implements Insertable<WbLedgerRecent> {
  final int id;
  final String ledgerId;
  final int openedAtMs;
  const WbLedgerRecent({
    required this.id,
    required this.ledgerId,
    required this.openedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ledger_id'] = Variable<String>(ledgerId);
    map['opened_at_ms'] = Variable<int>(openedAtMs);
    return map;
  }

  WbLedgerRecentsCompanion toCompanion(bool nullToAbsent) {
    return WbLedgerRecentsCompanion(
      id: Value(id),
      ledgerId: Value(ledgerId),
      openedAtMs: Value(openedAtMs),
    );
  }

  factory WbLedgerRecent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WbLedgerRecent(
      id: serializer.fromJson<int>(json['id']),
      ledgerId: serializer.fromJson<String>(json['ledgerId']),
      openedAtMs: serializer.fromJson<int>(json['openedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ledgerId': serializer.toJson<String>(ledgerId),
      'openedAtMs': serializer.toJson<int>(openedAtMs),
    };
  }

  WbLedgerRecent copyWith({int? id, String? ledgerId, int? openedAtMs}) =>
      WbLedgerRecent(
        id: id ?? this.id,
        ledgerId: ledgerId ?? this.ledgerId,
        openedAtMs: openedAtMs ?? this.openedAtMs,
      );
  WbLedgerRecent copyWithCompanion(WbLedgerRecentsCompanion data) {
    return WbLedgerRecent(
      id: data.id.present ? data.id.value : this.id,
      ledgerId: data.ledgerId.present ? data.ledgerId.value : this.ledgerId,
      openedAtMs: data.openedAtMs.present
          ? data.openedAtMs.value
          : this.openedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WbLedgerRecent(')
          ..write('id: $id, ')
          ..write('ledgerId: $ledgerId, ')
          ..write('openedAtMs: $openedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ledgerId, openedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WbLedgerRecent &&
          other.id == this.id &&
          other.ledgerId == this.ledgerId &&
          other.openedAtMs == this.openedAtMs);
}

class WbLedgerRecentsCompanion extends UpdateCompanion<WbLedgerRecent> {
  final Value<int> id;
  final Value<String> ledgerId;
  final Value<int> openedAtMs;
  const WbLedgerRecentsCompanion({
    this.id = const Value.absent(),
    this.ledgerId = const Value.absent(),
    this.openedAtMs = const Value.absent(),
  });
  WbLedgerRecentsCompanion.insert({
    this.id = const Value.absent(),
    required String ledgerId,
    required int openedAtMs,
  }) : ledgerId = Value(ledgerId),
       openedAtMs = Value(openedAtMs);
  static Insertable<WbLedgerRecent> custom({
    Expression<int>? id,
    Expression<String>? ledgerId,
    Expression<int>? openedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ledgerId != null) 'ledger_id': ledgerId,
      if (openedAtMs != null) 'opened_at_ms': openedAtMs,
    });
  }

  WbLedgerRecentsCompanion copyWith({
    Value<int>? id,
    Value<String>? ledgerId,
    Value<int>? openedAtMs,
  }) {
    return WbLedgerRecentsCompanion(
      id: id ?? this.id,
      ledgerId: ledgerId ?? this.ledgerId,
      openedAtMs: openedAtMs ?? this.openedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ledgerId.present) {
      map['ledger_id'] = Variable<String>(ledgerId.value);
    }
    if (openedAtMs.present) {
      map['opened_at_ms'] = Variable<int>(openedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WbLedgerRecentsCompanion(')
          ..write('id: $id, ')
          ..write('ledgerId: $ledgerId, ')
          ..write('openedAtMs: $openedAtMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$MetaDb extends GeneratedDatabase {
  _$MetaDb(QueryExecutor e) : super(e);
  $MetaDbManager get managers => $MetaDbManager(this);
  late final $MetaKvTable metaKv = $MetaKvTable(this);
  late final $WbLedgersTable wbLedgers = $WbLedgersTable(this);
  late final $WbTemplatesTable wbTemplates = $WbTemplatesTable(this);
  late final $WbLedgerRecentsTable wbLedgerRecents = $WbLedgerRecentsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    metaKv,
    wbLedgers,
    wbTemplates,
    wbLedgerRecents,
  ];
}

typedef $$MetaKvTableCreateCompanionBuilder =
    MetaKvCompanion Function({
      required String k,
      required String v,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$MetaKvTableUpdateCompanionBuilder =
    MetaKvCompanion Function({
      Value<String> k,
      Value<String> v,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

class $$MetaKvTableFilterComposer extends Composer<_$MetaDb, $MetaKvTable> {
  $$MetaKvTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get k => $composableBuilder(
    column: $table.k,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get v => $composableBuilder(
    column: $table.v,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaKvTableOrderingComposer extends Composer<_$MetaDb, $MetaKvTable> {
  $$MetaKvTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get k => $composableBuilder(
    column: $table.k,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get v => $composableBuilder(
    column: $table.v,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaKvTableAnnotationComposer extends Composer<_$MetaDb, $MetaKvTable> {
  $$MetaKvTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get k =>
      $composableBuilder(column: $table.k, builder: (column) => column);

  GeneratedColumn<String> get v =>
      $composableBuilder(column: $table.v, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$MetaKvTableTableManager
    extends
        RootTableManager<
          _$MetaDb,
          $MetaKvTable,
          MetaKvData,
          $$MetaKvTableFilterComposer,
          $$MetaKvTableOrderingComposer,
          $$MetaKvTableAnnotationComposer,
          $$MetaKvTableCreateCompanionBuilder,
          $$MetaKvTableUpdateCompanionBuilder,
          (MetaKvData, BaseReferences<_$MetaDb, $MetaKvTable, MetaKvData>),
          MetaKvData,
          PrefetchHooks Function()
        > {
  $$MetaKvTableTableManager(_$MetaDb db, $MetaKvTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaKvTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaKvTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaKvTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> k = const Value.absent(),
                Value<String> v = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaKvCompanion(
                k: k,
                v: v,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String k,
                required String v,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => MetaKvCompanion.insert(
                k: k,
                v: v,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaKvTableProcessedTableManager =
    ProcessedTableManager<
      _$MetaDb,
      $MetaKvTable,
      MetaKvData,
      $$MetaKvTableFilterComposer,
      $$MetaKvTableOrderingComposer,
      $$MetaKvTableAnnotationComposer,
      $$MetaKvTableCreateCompanionBuilder,
      $$MetaKvTableUpdateCompanionBuilder,
      (MetaKvData, BaseReferences<_$MetaDb, $MetaKvTable, MetaKvData>),
      MetaKvData,
      PrefetchHooks Function()
    >;
typedef $$WbLedgersTableCreateCompanionBuilder =
    WbLedgersCompanion Function({
      required String ledgerId,
      required String name,
      required String templateCode,
      Value<String> currencyCode,
      Value<String> timezone,
      required String dbFilename,
      Value<String?> dataDir,
      required int createdAtMs,
      required int updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });
typedef $$WbLedgersTableUpdateCompanionBuilder =
    WbLedgersCompanion Function({
      Value<String> ledgerId,
      Value<String> name,
      Value<String> templateCode,
      Value<String> currencyCode,
      Value<String> timezone,
      Value<String> dbFilename,
      Value<String?> dataDir,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

class $$WbLedgersTableFilterComposer
    extends Composer<_$MetaDb, $WbLedgersTable> {
  $$WbLedgersTableFilterComposer({
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

  ColumnFilters<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
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

  ColumnFilters<String> get dbFilename => $composableBuilder(
    column: $table.dbFilename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataDir => $composableBuilder(
    column: $table.dataDir,
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

class $$WbLedgersTableOrderingComposer
    extends Composer<_$MetaDb, $WbLedgersTable> {
  $$WbLedgersTableOrderingComposer({
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

  ColumnOrderings<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
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

  ColumnOrderings<String> get dbFilename => $composableBuilder(
    column: $table.dbFilename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataDir => $composableBuilder(
    column: $table.dataDir,
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

class $$WbLedgersTableAnnotationComposer
    extends Composer<_$MetaDb, $WbLedgersTable> {
  $$WbLedgersTableAnnotationComposer({
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

  GeneratedColumn<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get dbFilename => $composableBuilder(
    column: $table.dbFilename,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dataDir =>
      $composableBuilder(column: $table.dataDir, builder: (column) => column);

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

class $$WbLedgersTableTableManager
    extends
        RootTableManager<
          _$MetaDb,
          $WbLedgersTable,
          WbLedger,
          $$WbLedgersTableFilterComposer,
          $$WbLedgersTableOrderingComposer,
          $$WbLedgersTableAnnotationComposer,
          $$WbLedgersTableCreateCompanionBuilder,
          $$WbLedgersTableUpdateCompanionBuilder,
          (WbLedger, BaseReferences<_$MetaDb, $WbLedgersTable, WbLedger>),
          WbLedger,
          PrefetchHooks Function()
        > {
  $$WbLedgersTableTableManager(_$MetaDb db, $WbLedgersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WbLedgersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WbLedgersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WbLedgersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ledgerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> templateCode = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> dbFilename = const Value.absent(),
                Value<String?> dataDir = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WbLedgersCompanion(
                ledgerId: ledgerId,
                name: name,
                templateCode: templateCode,
                currencyCode: currencyCode,
                timezone: timezone,
                dbFilename: dbFilename,
                dataDir: dataDir,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ledgerId,
                required String name,
                required String templateCode,
                Value<String> currencyCode = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                required String dbFilename,
                Value<String?> dataDir = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WbLedgersCompanion.insert(
                ledgerId: ledgerId,
                name: name,
                templateCode: templateCode,
                currencyCode: currencyCode,
                timezone: timezone,
                dbFilename: dbFilename,
                dataDir: dataDir,
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

typedef $$WbLedgersTableProcessedTableManager =
    ProcessedTableManager<
      _$MetaDb,
      $WbLedgersTable,
      WbLedger,
      $$WbLedgersTableFilterComposer,
      $$WbLedgersTableOrderingComposer,
      $$WbLedgersTableAnnotationComposer,
      $$WbLedgersTableCreateCompanionBuilder,
      $$WbLedgersTableUpdateCompanionBuilder,
      (WbLedger, BaseReferences<_$MetaDb, $WbLedgersTable, WbLedger>),
      WbLedger,
      PrefetchHooks Function()
    >;
typedef $$WbTemplatesTableCreateCompanionBuilder =
    WbTemplatesCompanion Function({
      required String templateCode,
      required String name,
      Value<int> version,
      Value<bool> builtIn,
      required String defJson,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$WbTemplatesTableUpdateCompanionBuilder =
    WbTemplatesCompanion Function({
      Value<String> templateCode,
      Value<String> name,
      Value<int> version,
      Value<bool> builtIn,
      Value<String> defJson,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

class $$WbTemplatesTableFilterComposer
    extends Composer<_$MetaDb, $WbTemplatesTable> {
  $$WbTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get builtIn => $composableBuilder(
    column: $table.builtIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defJson => $composableBuilder(
    column: $table.defJson,
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
}

class $$WbTemplatesTableOrderingComposer
    extends Composer<_$MetaDb, $WbTemplatesTable> {
  $$WbTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get builtIn => $composableBuilder(
    column: $table.builtIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defJson => $composableBuilder(
    column: $table.defJson,
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
}

class $$WbTemplatesTableAnnotationComposer
    extends Composer<_$MetaDb, $WbTemplatesTable> {
  $$WbTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get templateCode => $composableBuilder(
    column: $table.templateCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get builtIn =>
      $composableBuilder(column: $table.builtIn, builder: (column) => column);

  GeneratedColumn<String> get defJson =>
      $composableBuilder(column: $table.defJson, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$WbTemplatesTableTableManager
    extends
        RootTableManager<
          _$MetaDb,
          $WbTemplatesTable,
          WbTemplate,
          $$WbTemplatesTableFilterComposer,
          $$WbTemplatesTableOrderingComposer,
          $$WbTemplatesTableAnnotationComposer,
          $$WbTemplatesTableCreateCompanionBuilder,
          $$WbTemplatesTableUpdateCompanionBuilder,
          (WbTemplate, BaseReferences<_$MetaDb, $WbTemplatesTable, WbTemplate>),
          WbTemplate,
          PrefetchHooks Function()
        > {
  $$WbTemplatesTableTableManager(_$MetaDb db, $WbTemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WbTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WbTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WbTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> templateCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> builtIn = const Value.absent(),
                Value<String> defJson = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WbTemplatesCompanion(
                templateCode: templateCode,
                name: name,
                version: version,
                builtIn: builtIn,
                defJson: defJson,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String templateCode,
                required String name,
                Value<int> version = const Value.absent(),
                Value<bool> builtIn = const Value.absent(),
                required String defJson,
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => WbTemplatesCompanion.insert(
                templateCode: templateCode,
                name: name,
                version: version,
                builtIn: builtIn,
                defJson: defJson,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WbTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$MetaDb,
      $WbTemplatesTable,
      WbTemplate,
      $$WbTemplatesTableFilterComposer,
      $$WbTemplatesTableOrderingComposer,
      $$WbTemplatesTableAnnotationComposer,
      $$WbTemplatesTableCreateCompanionBuilder,
      $$WbTemplatesTableUpdateCompanionBuilder,
      (WbTemplate, BaseReferences<_$MetaDb, $WbTemplatesTable, WbTemplate>),
      WbTemplate,
      PrefetchHooks Function()
    >;
typedef $$WbLedgerRecentsTableCreateCompanionBuilder =
    WbLedgerRecentsCompanion Function({
      Value<int> id,
      required String ledgerId,
      required int openedAtMs,
    });
typedef $$WbLedgerRecentsTableUpdateCompanionBuilder =
    WbLedgerRecentsCompanion Function({
      Value<int> id,
      Value<String> ledgerId,
      Value<int> openedAtMs,
    });

class $$WbLedgerRecentsTableFilterComposer
    extends Composer<_$MetaDb, $WbLedgerRecentsTable> {
  $$WbLedgerRecentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ledgerId => $composableBuilder(
    column: $table.ledgerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WbLedgerRecentsTableOrderingComposer
    extends Composer<_$MetaDb, $WbLedgerRecentsTable> {
  $$WbLedgerRecentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ledgerId => $composableBuilder(
    column: $table.ledgerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WbLedgerRecentsTableAnnotationComposer
    extends Composer<_$MetaDb, $WbLedgerRecentsTable> {
  $$WbLedgerRecentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ledgerId =>
      $composableBuilder(column: $table.ledgerId, builder: (column) => column);

  GeneratedColumn<int> get openedAtMs => $composableBuilder(
    column: $table.openedAtMs,
    builder: (column) => column,
  );
}

class $$WbLedgerRecentsTableTableManager
    extends
        RootTableManager<
          _$MetaDb,
          $WbLedgerRecentsTable,
          WbLedgerRecent,
          $$WbLedgerRecentsTableFilterComposer,
          $$WbLedgerRecentsTableOrderingComposer,
          $$WbLedgerRecentsTableAnnotationComposer,
          $$WbLedgerRecentsTableCreateCompanionBuilder,
          $$WbLedgerRecentsTableUpdateCompanionBuilder,
          (
            WbLedgerRecent,
            BaseReferences<_$MetaDb, $WbLedgerRecentsTable, WbLedgerRecent>,
          ),
          WbLedgerRecent,
          PrefetchHooks Function()
        > {
  $$WbLedgerRecentsTableTableManager(_$MetaDb db, $WbLedgerRecentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WbLedgerRecentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WbLedgerRecentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WbLedgerRecentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ledgerId = const Value.absent(),
                Value<int> openedAtMs = const Value.absent(),
              }) => WbLedgerRecentsCompanion(
                id: id,
                ledgerId: ledgerId,
                openedAtMs: openedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ledgerId,
                required int openedAtMs,
              }) => WbLedgerRecentsCompanion.insert(
                id: id,
                ledgerId: ledgerId,
                openedAtMs: openedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WbLedgerRecentsTableProcessedTableManager =
    ProcessedTableManager<
      _$MetaDb,
      $WbLedgerRecentsTable,
      WbLedgerRecent,
      $$WbLedgerRecentsTableFilterComposer,
      $$WbLedgerRecentsTableOrderingComposer,
      $$WbLedgerRecentsTableAnnotationComposer,
      $$WbLedgerRecentsTableCreateCompanionBuilder,
      $$WbLedgerRecentsTableUpdateCompanionBuilder,
      (
        WbLedgerRecent,
        BaseReferences<_$MetaDb, $WbLedgerRecentsTable, WbLedgerRecent>,
      ),
      WbLedgerRecent,
      PrefetchHooks Function()
    >;

class $MetaDbManager {
  final _$MetaDb _db;
  $MetaDbManager(this._db);
  $$MetaKvTableTableManager get metaKv =>
      $$MetaKvTableTableManager(_db, _db.metaKv);
  $$WbLedgersTableTableManager get wbLedgers =>
      $$WbLedgersTableTableManager(_db, _db.wbLedgers);
  $$WbTemplatesTableTableManager get wbTemplates =>
      $$WbTemplatesTableTableManager(_db, _db.wbTemplates);
  $$WbLedgerRecentsTableTableManager get wbLedgerRecents =>
      $$WbLedgerRecentsTableTableManager(_db, _db.wbLedgerRecents);
}
