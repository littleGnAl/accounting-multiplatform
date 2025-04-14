// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_chart_data_month.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SummaryChartDataMonth extends SummaryChartDataMonth {
  @override
  final String displayMonth;
  @override
  final DateTime monthDateTime;

  factory _$SummaryChartDataMonth(
          [void Function(SummaryChartDataMonthBuilder)? updates]) =>
      (new SummaryChartDataMonthBuilder()..update(updates))._build();

  _$SummaryChartDataMonth._(
      {required this.displayMonth, required this.monthDateTime})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        displayMonth, r'SummaryChartDataMonth', 'displayMonth');
    BuiltValueNullFieldError.checkNotNull(
        monthDateTime, r'SummaryChartDataMonth', 'monthDateTime');
  }

  @override
  SummaryChartDataMonth rebuild(
          void Function(SummaryChartDataMonthBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SummaryChartDataMonthBuilder toBuilder() =>
      new SummaryChartDataMonthBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SummaryChartDataMonth &&
        displayMonth == other.displayMonth &&
        monthDateTime == other.monthDateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, displayMonth.hashCode);
    _$hash = $jc(_$hash, monthDateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SummaryChartDataMonth')
          ..add('displayMonth', displayMonth)
          ..add('monthDateTime', monthDateTime))
        .toString();
  }
}

class SummaryChartDataMonthBuilder
    implements Builder<SummaryChartDataMonth, SummaryChartDataMonthBuilder> {
  _$SummaryChartDataMonth? _$v;

  String? _displayMonth;
  String? get displayMonth => _$this._displayMonth;
  set displayMonth(String? displayMonth) => _$this._displayMonth = displayMonth;

  DateTime? _monthDateTime;
  DateTime? get monthDateTime => _$this._monthDateTime;
  set monthDateTime(DateTime? monthDateTime) =>
      _$this._monthDateTime = monthDateTime;

  SummaryChartDataMonthBuilder();

  SummaryChartDataMonthBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _displayMonth = $v.displayMonth;
      _monthDateTime = $v.monthDateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SummaryChartDataMonth other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SummaryChartDataMonth;
  }

  @override
  void update(void Function(SummaryChartDataMonthBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SummaryChartDataMonth build() => _build();

  _$SummaryChartDataMonth _build() {
    final _$result = _$v ??
        new _$SummaryChartDataMonth._(
          displayMonth: BuiltValueNullFieldError.checkNotNull(
              displayMonth, r'SummaryChartDataMonth', 'displayMonth'),
          monthDateTime: BuiltValueNullFieldError.checkNotNull(
              monthDateTime, r'SummaryChartDataMonth', 'monthDateTime'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
