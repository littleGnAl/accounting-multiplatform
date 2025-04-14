// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_expenses_of_month.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TotalExpensesOfMonth> _$totalExpensesOfMonthSerializer =
    new _$TotalExpensesOfMonthSerializer();

class _$TotalExpensesOfMonthSerializer
    implements StructuredSerializer<TotalExpensesOfMonth> {
  @override
  final Iterable<Type> types = const [
    TotalExpensesOfMonth,
    _$TotalExpensesOfMonth
  ];
  @override
  final String wireName = 'TotalExpensesOfMonth';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TotalExpensesOfMonth object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'yearMonth',
      serializers.serialize(object.yearMonth,
          specifiedType: const FullType(String)),
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TotalExpensesOfMonth deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TotalExpensesOfMonthBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'yearMonth':
          result.yearMonth = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TotalExpensesOfMonth extends TotalExpensesOfMonth {
  @override
  final String yearMonth;
  @override
  final double total;

  factory _$TotalExpensesOfMonth(
          [void Function(TotalExpensesOfMonthBuilder)? updates]) =>
      (new TotalExpensesOfMonthBuilder()..update(updates))._build();

  _$TotalExpensesOfMonth._({required this.yearMonth, required this.total})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        yearMonth, r'TotalExpensesOfMonth', 'yearMonth');
    BuiltValueNullFieldError.checkNotNull(
        total, r'TotalExpensesOfMonth', 'total');
  }

  @override
  TotalExpensesOfMonth rebuild(
          void Function(TotalExpensesOfMonthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotalExpensesOfMonthBuilder toBuilder() =>
      new TotalExpensesOfMonthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TotalExpensesOfMonth &&
        yearMonth == other.yearMonth &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, yearMonth.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TotalExpensesOfMonth')
          ..add('yearMonth', yearMonth)
          ..add('total', total))
        .toString();
  }
}

class TotalExpensesOfMonthBuilder
    implements Builder<TotalExpensesOfMonth, TotalExpensesOfMonthBuilder> {
  _$TotalExpensesOfMonth? _$v;

  String? _yearMonth;
  String? get yearMonth => _$this._yearMonth;
  set yearMonth(String? yearMonth) => _$this._yearMonth = yearMonth;

  double? _total;
  double? get total => _$this._total;
  set total(double? total) => _$this._total = total;

  TotalExpensesOfMonthBuilder();

  TotalExpensesOfMonthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _yearMonth = $v.yearMonth;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TotalExpensesOfMonth other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TotalExpensesOfMonth;
  }

  @override
  void update(void Function(TotalExpensesOfMonthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TotalExpensesOfMonth build() => _build();

  _$TotalExpensesOfMonth _build() {
    final _$result = _$v ??
        new _$TotalExpensesOfMonth._(
          yearMonth: BuiltValueNullFieldError.checkNotNull(
              yearMonth, r'TotalExpensesOfMonth', 'yearMonth'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'TotalExpensesOfMonth', 'total'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
