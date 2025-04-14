// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeListViewHeader extends HomeListViewHeader {
  @override
  final String displayDate;
  @override
  final String displayTotal;

  factory _$HomeListViewHeader(
          [void Function(HomeListViewHeaderBuilder)? updates]) =>
      (new HomeListViewHeaderBuilder()..update(updates))._build();

  _$HomeListViewHeader._(
      {required this.displayDate, required this.displayTotal})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        displayDate, r'HomeListViewHeader', 'displayDate');
    BuiltValueNullFieldError.checkNotNull(
        displayTotal, r'HomeListViewHeader', 'displayTotal');
  }

  @override
  HomeListViewHeader rebuild(
          void Function(HomeListViewHeaderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeListViewHeaderBuilder toBuilder() =>
      new HomeListViewHeaderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeListViewHeader &&
        displayDate == other.displayDate &&
        displayTotal == other.displayTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, displayDate.hashCode);
    _$hash = $jc(_$hash, displayTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeListViewHeader')
          ..add('displayDate', displayDate)
          ..add('displayTotal', displayTotal))
        .toString();
  }
}

class HomeListViewHeaderBuilder
    implements Builder<HomeListViewHeader, HomeListViewHeaderBuilder> {
  _$HomeListViewHeader? _$v;

  String? _displayDate;
  String? get displayDate => _$this._displayDate;
  set displayDate(String? displayDate) => _$this._displayDate = displayDate;

  String? _displayTotal;
  String? get displayTotal => _$this._displayTotal;
  set displayTotal(String? displayTotal) => _$this._displayTotal = displayTotal;

  HomeListViewHeaderBuilder();

  HomeListViewHeaderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _displayDate = $v.displayDate;
      _displayTotal = $v.displayTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeListViewHeader other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeListViewHeader;
  }

  @override
  void update(void Function(HomeListViewHeaderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeListViewHeader build() => _build();

  _$HomeListViewHeader _build() {
    final _$result = _$v ??
        new _$HomeListViewHeader._(
          displayDate: BuiltValueNullFieldError.checkNotNull(
              displayDate, r'HomeListViewHeader', 'displayDate'),
          displayTotal: BuiltValueNullFieldError.checkNotNull(
              displayTotal, r'HomeListViewHeader', 'displayTotal'),
        );
    replace(_$result);
    return _$result;
  }
}

class _$HomeListViewContent extends HomeListViewContent {
  @override
  final Accounting accounting;
  @override
  final String displayTime;
  @override
  final String displayLabel;
  @override
  final String displayRemark;
  @override
  final String displayExpense;

  factory _$HomeListViewContent(
          [void Function(HomeListViewContentBuilder)? updates]) =>
      (new HomeListViewContentBuilder()..update(updates))._build();

  _$HomeListViewContent._(
      {required this.accounting,
      required this.displayTime,
      required this.displayLabel,
      required this.displayRemark,
      required this.displayExpense})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        accounting, r'HomeListViewContent', 'accounting');
    BuiltValueNullFieldError.checkNotNull(
        displayTime, r'HomeListViewContent', 'displayTime');
    BuiltValueNullFieldError.checkNotNull(
        displayLabel, r'HomeListViewContent', 'displayLabel');
    BuiltValueNullFieldError.checkNotNull(
        displayRemark, r'HomeListViewContent', 'displayRemark');
    BuiltValueNullFieldError.checkNotNull(
        displayExpense, r'HomeListViewContent', 'displayExpense');
  }

  @override
  HomeListViewContent rebuild(
          void Function(HomeListViewContentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeListViewContentBuilder toBuilder() =>
      new HomeListViewContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeListViewContent &&
        accounting == other.accounting &&
        displayTime == other.displayTime &&
        displayLabel == other.displayLabel &&
        displayRemark == other.displayRemark &&
        displayExpense == other.displayExpense;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accounting.hashCode);
    _$hash = $jc(_$hash, displayTime.hashCode);
    _$hash = $jc(_$hash, displayLabel.hashCode);
    _$hash = $jc(_$hash, displayRemark.hashCode);
    _$hash = $jc(_$hash, displayExpense.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HomeListViewContent')
          ..add('accounting', accounting)
          ..add('displayTime', displayTime)
          ..add('displayLabel', displayLabel)
          ..add('displayRemark', displayRemark)
          ..add('displayExpense', displayExpense))
        .toString();
  }
}

class HomeListViewContentBuilder
    implements Builder<HomeListViewContent, HomeListViewContentBuilder> {
  _$HomeListViewContent? _$v;

  AccountingBuilder? _accounting;
  AccountingBuilder get accounting =>
      _$this._accounting ??= new AccountingBuilder();
  set accounting(AccountingBuilder? accounting) =>
      _$this._accounting = accounting;

  String? _displayTime;
  String? get displayTime => _$this._displayTime;
  set displayTime(String? displayTime) => _$this._displayTime = displayTime;

  String? _displayLabel;
  String? get displayLabel => _$this._displayLabel;
  set displayLabel(String? displayLabel) => _$this._displayLabel = displayLabel;

  String? _displayRemark;
  String? get displayRemark => _$this._displayRemark;
  set displayRemark(String? displayRemark) =>
      _$this._displayRemark = displayRemark;

  String? _displayExpense;
  String? get displayExpense => _$this._displayExpense;
  set displayExpense(String? displayExpense) =>
      _$this._displayExpense = displayExpense;

  HomeListViewContentBuilder();

  HomeListViewContentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accounting = $v.accounting.toBuilder();
      _displayTime = $v.displayTime;
      _displayLabel = $v.displayLabel;
      _displayRemark = $v.displayRemark;
      _displayExpense = $v.displayExpense;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeListViewContent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeListViewContent;
  }

  @override
  void update(void Function(HomeListViewContentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HomeListViewContent build() => _build();

  _$HomeListViewContent _build() {
    _$HomeListViewContent _$result;
    try {
      _$result = _$v ??
          new _$HomeListViewContent._(
            accounting: accounting.build(),
            displayTime: BuiltValueNullFieldError.checkNotNull(
                displayTime, r'HomeListViewContent', 'displayTime'),
            displayLabel: BuiltValueNullFieldError.checkNotNull(
                displayLabel, r'HomeListViewContent', 'displayLabel'),
            displayRemark: BuiltValueNullFieldError.checkNotNull(
                displayRemark, r'HomeListViewContent', 'displayRemark'),
            displayExpense: BuiltValueNullFieldError.checkNotNull(
                displayExpense, r'HomeListViewContent', 'displayExpense'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accounting';
        accounting.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'HomeListViewContent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
