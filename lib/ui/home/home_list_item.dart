import 'dart:core' as prefix0;
import 'dart:core';

import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:built_value/built_value.dart';

part 'home_list_item.g.dart';

abstract class HomeListViewItem {}

abstract class HomeListViewHeader
    implements
        Built<HomeListViewHeader, HomeListViewHeaderBuilder>,
        HomeListViewItem {
  String get displayDate;
  String get displayTotal;

  HomeListViewHeader._();
  factory HomeListViewHeader([update(HomeListViewHeaderBuilder b)]) =
      _$HomeListViewHeader;
}

abstract class HomeListViewContent
    implements
        Built<HomeListViewContent, HomeListViewContentBuilder>,
        HomeListViewItem {
  Accounting get accounting;
  String get displayTime;
  String get displayLabel;
  String get displayRemark;
  String get displayExpense;

  HomeListViewContent._();
  factory HomeListViewContent([update(HomeListViewContentBuilder b)]) =
      _$HomeListViewContent;
}
