// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_expenses_of_grouping_tag.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TotalExpensesOfGroupingTag> _$totalExpensesOfGroupingTagSerializer =
    new _$TotalExpensesOfGroupingTagSerializer();

class _$TotalExpensesOfGroupingTagSerializer
    implements StructuredSerializer<TotalExpensesOfGroupingTag> {
  @override
  final Iterable<Type> types = const [
    TotalExpensesOfGroupingTag,
    _$TotalExpensesOfGroupingTag
  ];
  @override
  final String wireName = 'TotalExpensesOfGroupingTag';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TotalExpensesOfGroupingTag object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
      'tag_name',
      serializers.serialize(object.tagName,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TotalExpensesOfGroupingTag deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TotalExpensesOfGroupingTagBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'tag_name':
          result.tagName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TotalExpensesOfGroupingTag extends TotalExpensesOfGroupingTag {
  @override
  final double total;
  @override
  final String tagName;

  factory _$TotalExpensesOfGroupingTag(
          [void Function(TotalExpensesOfGroupingTagBuilder)? updates]) =>
      (new TotalExpensesOfGroupingTagBuilder()..update(updates))._build();

  _$TotalExpensesOfGroupingTag._({required this.total, required this.tagName})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        total, r'TotalExpensesOfGroupingTag', 'total');
    BuiltValueNullFieldError.checkNotNull(
        tagName, r'TotalExpensesOfGroupingTag', 'tagName');
  }

  @override
  TotalExpensesOfGroupingTag rebuild(
          void Function(TotalExpensesOfGroupingTagBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotalExpensesOfGroupingTagBuilder toBuilder() =>
      new TotalExpensesOfGroupingTagBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotalExpensesOfGroupingTag &&
        total == other.total &&
        tagName == other.tagName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, tagName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotalExpensesOfGroupingTag')
          ..add('total', total)
          ..add('tagName', tagName))
        .toString();
  }
}

class TotalExpensesOfGroupingTagBuilder
    implements
        Builder<TotalExpensesOfGroupingTag, TotalExpensesOfGroupingTagBuilder> {
  _$TotalExpensesOfGroupingTag? _$v;

  double? _total;
  double? get total => _$this._total;
  set total(double? total) => _$this._total = total;

  String? _tagName;
  String? get tagName => _$this._tagName;
  set tagName(String? tagName) => _$this._tagName = tagName;

  TotalExpensesOfGroupingTagBuilder();

  TotalExpensesOfGroupingTagBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _tagName = $v.tagName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotalExpensesOfGroupingTag other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TotalExpensesOfGroupingTag;
  }

  @override
  void update(void Function(TotalExpensesOfGroupingTagBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotalExpensesOfGroupingTag build() => _build();

  _$TotalExpensesOfGroupingTag _build() {
    final _$result = _$v ??
        new _$TotalExpensesOfGroupingTag._(
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'TotalExpensesOfGroupingTag', 'total'),
          tagName: BuiltValueNullFieldError.checkNotNull(
              tagName, r'TotalExpensesOfGroupingTag', 'tagName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
