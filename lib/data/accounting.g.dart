// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Accounting> _$accountingSerializer = new _$AccountingSerializer();

class _$AccountingSerializer implements StructuredSerializer<Accounting> {
  @override
  final Iterable<Type> types = const [Accounting, _$Accounting];
  @override
  final String wireName = 'Accounting';

  @override
  Iterable<Object?> serialize(Serializers serializers, Accounting object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
      'createTime',
      serializers.serialize(object.createTime,
          specifiedType: const FullType(DateTime)),
      'tag_name',
      serializers.serialize(object.tagName,
          specifiedType: const FullType(String)),
      'remarks',
      serializers.serialize(object.remarks,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Accounting deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AccountingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'createTime':
          result.createTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'tag_name':
          result.tagName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'remarks':
          result.remarks = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Accounting extends Accounting {
  @override
  final int id;
  @override
  final double amount;
  @override
  final DateTime createTime;
  @override
  final String tagName;
  @override
  final String remarks;

  factory _$Accounting([void Function(AccountingBuilder)? updates]) =>
      (new AccountingBuilder()..update(updates))._build();

  _$Accounting._(
      {required this.id,
      required this.amount,
      required this.createTime,
      required this.tagName,
      required this.remarks})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Accounting', 'id');
    BuiltValueNullFieldError.checkNotNull(amount, r'Accounting', 'amount');
    BuiltValueNullFieldError.checkNotNull(
        createTime, r'Accounting', 'createTime');
    BuiltValueNullFieldError.checkNotNull(tagName, r'Accounting', 'tagName');
    BuiltValueNullFieldError.checkNotNull(remarks, r'Accounting', 'remarks');
  }

  @override
  Accounting rebuild(void Function(AccountingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountingBuilder toBuilder() => new AccountingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Accounting &&
        id == other.id &&
        amount == other.amount &&
        createTime == other.createTime &&
        tagName == other.tagName &&
        remarks == other.remarks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, tagName.hashCode);
    _$hash = $jc(_$hash, remarks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Accounting')
          ..add('id', id)
          ..add('amount', amount)
          ..add('createTime', createTime)
          ..add('tagName', tagName)
          ..add('remarks', remarks))
        .toString();
  }
}

class AccountingBuilder implements Builder<Accounting, AccountingBuilder> {
  _$Accounting? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  String? _tagName;
  String? get tagName => _$this._tagName;
  set tagName(String? tagName) => _$this._tagName = tagName;

  String? _remarks;
  String? get remarks => _$this._remarks;
  set remarks(String? remarks) => _$this._remarks = remarks;

  AccountingBuilder();

  AccountingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _amount = $v.amount;
      _createTime = $v.createTime;
      _tagName = $v.tagName;
      _remarks = $v.remarks;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Accounting other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Accounting;
  }

  @override
  void update(void Function(AccountingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Accounting build() => _build();

  _$Accounting _build() {
    final _$result = _$v ??
        new _$Accounting._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Accounting', 'id'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Accounting', 'amount'),
          createTime: BuiltValueNullFieldError.checkNotNull(
              createTime, r'Accounting', 'createTime'),
          tagName: BuiltValueNullFieldError.checkNotNull(
              tagName, r'Accounting', 'tagName'),
          remarks: BuiltValueNullFieldError.checkNotNull(
              remarks, r'Accounting', 'remarks'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
