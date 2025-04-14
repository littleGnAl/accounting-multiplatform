// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_list_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SummaryListItem extends SummaryListItem {
  @override
  final String tagName;
  @override
  final String displayTotal;

  factory _$SummaryListItem([void Function(SummaryListItemBuilder)? updates]) =>
      (new SummaryListItemBuilder()..update(updates))._build();

  _$SummaryListItem._({required this.tagName, required this.displayTotal})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        tagName, r'SummaryListItem', 'tagName');
    BuiltValueNullFieldError.checkNotNull(
        displayTotal, r'SummaryListItem', 'displayTotal');
  }

  @override
  SummaryListItem rebuild(void Function(SummaryListItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SummaryListItemBuilder toBuilder() =>
      new SummaryListItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SummaryListItem &&
        tagName == other.tagName &&
        displayTotal == other.displayTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tagName.hashCode);
    _$hash = $jc(_$hash, displayTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SummaryListItem')
          ..add('tagName', tagName)
          ..add('displayTotal', displayTotal))
        .toString();
  }
}

class SummaryListItemBuilder
    implements Builder<SummaryListItem, SummaryListItemBuilder> {
  _$SummaryListItem? _$v;

  String? _tagName;
  String? get tagName => _$this._tagName;
  set tagName(String? tagName) => _$this._tagName = tagName;

  String? _displayTotal;
  String? get displayTotal => _$this._displayTotal;
  set displayTotal(String? displayTotal) => _$this._displayTotal = displayTotal;

  SummaryListItemBuilder();

  SummaryListItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tagName = $v.tagName;
      _displayTotal = $v.displayTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SummaryListItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SummaryListItem;
  }

  @override
  void update(void Function(SummaryListItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SummaryListItem build() => _build();

  _$SummaryListItem _build() {
    final _$result = _$v ??
        new _$SummaryListItem._(
          tagName: BuiltValueNullFieldError.checkNotNull(
              tagName, r'SummaryListItem', 'tagName'),
          displayTotal: BuiltValueNullFieldError.checkNotNull(
              displayTotal, r'SummaryListItem', 'displayTotal'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
