// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_chart_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SummaryChartData extends SummaryChartData {
  @override
  final BuiltList<SummaryChartDataMonth> months;
  @override
  final BuiltList<SummaryChartDataPoint> points;
  @override
  final BuiltList<String> values;
  @override
  final int selectedIndex;

  factory _$SummaryChartData(
          [void Function(SummaryChartDataBuilder)? updates]) =>
      (new SummaryChartDataBuilder()..update(updates))._build();

  _$SummaryChartData._(
      {required this.months,
      required this.points,
      required this.values,
      required this.selectedIndex})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        months, r'SummaryChartData', 'months');
    BuiltValueNullFieldError.checkNotNull(
        points, r'SummaryChartData', 'points');
    BuiltValueNullFieldError.checkNotNull(
        values, r'SummaryChartData', 'values');
    BuiltValueNullFieldError.checkNotNull(
        selectedIndex, r'SummaryChartData', 'selectedIndex');
  }

  @override
  SummaryChartData rebuild(void Function(SummaryChartDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SummaryChartDataBuilder toBuilder() =>
      new SummaryChartDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SummaryChartData &&
        months == other.months &&
        points == other.points &&
        values == other.values &&
        selectedIndex == other.selectedIndex;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, months.hashCode);
    _$hash = $jc(_$hash, points.hashCode);
    _$hash = $jc(_$hash, values.hashCode);
    _$hash = $jc(_$hash, selectedIndex.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SummaryChartData')
          ..add('months', months)
          ..add('points', points)
          ..add('values', values)
          ..add('selectedIndex', selectedIndex))
        .toString();
  }
}

class SummaryChartDataBuilder
    implements Builder<SummaryChartData, SummaryChartDataBuilder> {
  _$SummaryChartData? _$v;

  ListBuilder<SummaryChartDataMonth>? _months;
  ListBuilder<SummaryChartDataMonth> get months =>
      _$this._months ??= new ListBuilder<SummaryChartDataMonth>();
  set months(ListBuilder<SummaryChartDataMonth>? months) =>
      _$this._months = months;

  ListBuilder<SummaryChartDataPoint>? _points;
  ListBuilder<SummaryChartDataPoint> get points =>
      _$this._points ??= new ListBuilder<SummaryChartDataPoint>();
  set points(ListBuilder<SummaryChartDataPoint>? points) =>
      _$this._points = points;

  ListBuilder<String>? _values;
  ListBuilder<String> get values =>
      _$this._values ??= new ListBuilder<String>();
  set values(ListBuilder<String>? values) => _$this._values = values;

  int? _selectedIndex;
  int? get selectedIndex => _$this._selectedIndex;
  set selectedIndex(int? selectedIndex) =>
      _$this._selectedIndex = selectedIndex;

  SummaryChartDataBuilder();

  SummaryChartDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _months = $v.months.toBuilder();
      _points = $v.points.toBuilder();
      _values = $v.values.toBuilder();
      _selectedIndex = $v.selectedIndex;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SummaryChartData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SummaryChartData;
  }

  @override
  void update(void Function(SummaryChartDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SummaryChartData build() => _build();

  _$SummaryChartData _build() {
    _$SummaryChartData _$result;
    try {
      _$result = _$v ??
          new _$SummaryChartData._(
            months: months.build(),
            points: points.build(),
            values: values.build(),
            selectedIndex: BuiltValueNullFieldError.checkNotNull(
                selectedIndex, r'SummaryChartData', 'selectedIndex'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'months';
        months.build();
        _$failedField = 'points';
        points.build();
        _$failedField = 'values';
        values.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SummaryChartData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
