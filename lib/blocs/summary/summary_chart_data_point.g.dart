// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_chart_data_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SummaryChartDataPoint extends SummaryChartDataPoint {
  @override
  final int monthIndex;
  @override
  final double totalExpenses;

  factory _$SummaryChartDataPoint(
          [void Function(SummaryChartDataPointBuilder)? updates]) =>
      (new SummaryChartDataPointBuilder()..update(updates))._build();

  _$SummaryChartDataPoint._(
      {required this.monthIndex, required this.totalExpenses})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        monthIndex, r'SummaryChartDataPoint', 'monthIndex');
    BuiltValueNullFieldError.checkNotNull(
        totalExpenses, r'SummaryChartDataPoint', 'totalExpenses');
  }

  @override
  SummaryChartDataPoint rebuild(
          void Function(SummaryChartDataPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SummaryChartDataPointBuilder toBuilder() =>
      new SummaryChartDataPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SummaryChartDataPoint &&
        monthIndex == other.monthIndex &&
        totalExpenses == other.totalExpenses;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, monthIndex.hashCode);
    _$hash = $jc(_$hash, totalExpenses.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SummaryChartDataPoint')
          ..add('monthIndex', monthIndex)
          ..add('totalExpenses', totalExpenses))
        .toString();
  }
}

class SummaryChartDataPointBuilder
    implements Builder<SummaryChartDataPoint, SummaryChartDataPointBuilder> {
  _$SummaryChartDataPoint? _$v;

  int? _monthIndex;
  int? get monthIndex => _$this._monthIndex;
  set monthIndex(int? monthIndex) => _$this._monthIndex = monthIndex;

  double? _totalExpenses;
  double? get totalExpenses => _$this._totalExpenses;
  set totalExpenses(double? totalExpenses) =>
      _$this._totalExpenses = totalExpenses;

  SummaryChartDataPointBuilder();

  SummaryChartDataPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _monthIndex = $v.monthIndex;
      _totalExpenses = $v.totalExpenses;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SummaryChartDataPoint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SummaryChartDataPoint;
  }

  @override
  void update(void Function(SummaryChartDataPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SummaryChartDataPoint build() => _build();

  _$SummaryChartDataPoint _build() {
    final _$result = _$v ??
        new _$SummaryChartDataPoint._(
          monthIndex: BuiltValueNullFieldError.checkNotNull(
              monthIndex, r'SummaryChartDataPoint', 'monthIndex'),
          totalExpenses: BuiltValueNullFieldError.checkNotNull(
              totalExpenses, r'SummaryChartDataPoint', 'totalExpenses'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
