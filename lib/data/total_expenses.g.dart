// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_expenses.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TotalExpenses> _$totalExpensesSerializer =
    new _$TotalExpensesSerializer();

class _$TotalExpensesSerializer implements StructuredSerializer<TotalExpenses> {
  @override
  final Iterable<Type> types = const [TotalExpenses, _$TotalExpenses];
  @override
  final String wireName = 'TotalExpenses';

  @override
  Iterable<Object?> serialize(Serializers serializers, TotalExpenses object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TotalExpenses deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TotalExpensesBuilder();

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
      }
    }

    return result.build();
  }
}

class _$TotalExpenses extends TotalExpenses {
  @override
  final double total;

  factory _$TotalExpenses([void Function(TotalExpensesBuilder)? updates]) =>
      (new TotalExpensesBuilder()..update(updates))._build();

  _$TotalExpenses._({required this.total}) : super._() {
    BuiltValueNullFieldError.checkNotNull(total, r'TotalExpenses', 'total');
  }

  @override
  TotalExpenses rebuild(void Function(TotalExpensesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotalExpensesBuilder toBuilder() => new TotalExpensesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotalExpenses && total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotalExpenses')..add('total', total))
        .toString();
  }
}

class TotalExpensesBuilder
    implements Builder<TotalExpenses, TotalExpensesBuilder> {
  _$TotalExpenses? _$v;

  double? _total;
  double? get total => _$this._total;
  set total(double? total) => _$this._total = total;

  TotalExpensesBuilder();

  TotalExpensesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotalExpenses other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TotalExpenses;
  }

  @override
  void update(void Function(TotalExpensesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotalExpenses build() => _build();

  _$TotalExpenses _build() {
    final _$result = _$v ??
        new _$TotalExpenses._(
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'TotalExpenses', 'total'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
