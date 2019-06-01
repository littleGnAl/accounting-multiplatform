import 'dart:core' as prefix0;
import 'dart:core';

import 'package:accountingmultiplatform/data/accounting.dart';

abstract class HomeListViewItem {}

class HomeListViewHeader implements HomeListViewItem {
  final String displayDate;
  final String displayTotal;

  const HomeListViewHeader({this.displayDate, this.displayTotal});
}

class HomeListViewContent implements HomeListViewItem {
  final Accounting accounting;
  final String displayTime;
  final String displayLabel;
  final String displayRemark;
  final String displayExpense;

  const HomeListViewContent(
      {this.accounting,
      this.displayTime,
      this.displayLabel,
      this.displayRemark,
      this.displayExpense});
}
