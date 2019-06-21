import 'dart:async';
import 'dart:core';

import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_month.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_point.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_list_item.dart';
import 'package:accountingmultiplatform/data/accounting_db_provider.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class SummaryBloc {
  final _summaryChartDataSubject =
      BehaviorSubject<SummaryChartData>.seeded(SummaryChartData((b) => b
        ..months = ListBuilder(BuiltList<SummaryChartDataMonth>())
        ..points = ListBuilder(BuiltList<SummaryChartDataPoint>())
        ..values = ListBuilder<String>()
        ..selectedIndex = -1));
  final _summaryListSubject =
      BehaviorSubject<BuiltList<SummaryListItem>>.seeded(BuiltList());

  Stream<SummaryChartData> get summaryChartData =>
      _summaryChartDataSubject.stream;

  Stream<BuiltList<SummaryListItem>> get summaryList =>
      _summaryListSubject.stream;

  final DateFormat _monthFormat = DateFormat("MMM");
  final DateFormat _yearMonthFormat = DateFormat("yyyy-MM");

  dispose() {
    _summaryChartDataSubject.close();
    _summaryListSubject.close();
  }

  void initialize() {
    getGroupingTagOfLatestMonth();
    getMonthTotalAmount();
  }

  Future<Null> getGroupingTagOfLatestMonth() async {
    final db = AccountingDBProvider.db;
    var list = await db.getGroupingTagOfLatestMonth();
    _summaryListSubject.sink.add(_createSummaryList(list));
  }

  Future<Null> getMonthTotalAmount() async {
    final db = AccountingDBProvider.db;
    var result = await db.getMonthTotalAmount();
    List<SummaryChartDataMonth> months = List();
    List<SummaryChartDataPoint> points = List();
    List<String> values = List();

    var now = DateTime.now();
//    var yearMonthList = List<String>();
//    for (var i = 5; i >= 0; i--) {
//      var d = DateTime(now.year, now.month - 5, 1);
//      yearMonthList.add("${d.year}-${d.month}");
//    }




    var today = DateTime(now.year, now.month - 5, 1);
    var firstMonth =
        DateTime.fromMillisecondsSinceEpoch(today.millisecondsSinceEpoch);
    for (var i = 0; i < 6; i++) {
      var tempMonth =
          DateTime.fromMillisecondsSinceEpoch(today.millisecondsSinceEpoch);
      var monthString = _monthFormat.format(tempMonth);
      months.add(SummaryChartDataMonth((b) => b
        ..displayMonth = monthString
        ..monthDateTime = tempMonth));
      today = DateTime(today.year, today.month + 1, today.day);
    }

    var selectedIndex = -1;

    if (result.isNotEmpty) {
      var reverseList = result.reversed;
      var latestMonth = _yearMonthFormat.parse(reverseList.last.yearMonth);
      selectedIndex = _monthBetween(latestMonth, firstMonth);

      reverseList.forEach((monthTotal) {
        var monthTotalDate = _yearMonthFormat.parse(monthTotal.yearMonth);
        if (monthTotalDate.isAtSameMomentAs(firstMonth) ||
            monthTotalDate.isAfter(firstMonth)) {
          var index = _monthBetween(monthTotalDate, firstMonth);
          points.add(SummaryChartDataPoint((b) => b
            ..monthIndex = index
            ..totalExpenses = monthTotal.total));
          values.add("¥${monthTotal.total}");
        }
      });
    }

    _summaryChartDataSubject.sink.add(SummaryChartData((b) => b
      ..months = ListBuilder<SummaryChartDataMonth>(months)
      ..points = ListBuilder<SummaryChartDataPoint>(points)
      ..values = ListBuilder<String>(values)
      ..selectedIndex = selectedIndex));
  }

  int _monthBetween(DateTime date1, DateTime date2) {
    return ((date1.year * 12 + date1.month) - (date2.year * 12 + date2.month))
        .abs();
  }

  Future<Null> switchMonth(int index, DateTime date) async {
    print("Switch month to $date");
    final db = AccountingDBProvider.db;
    var result = await db.getGroupingMonthTotalAmount(date);

    var old = _summaryChartDataSubject.value;
    _summaryChartDataSubject.sink
        .add(old.rebuild((b) => b.selectedIndex = index));

    _summaryListSubject.sink.add(_createSummaryList(result));
  }

  BuiltList<SummaryListItem> _createSummaryList(
      BuiltList<TotalExpensesOfGroupingTag> list) {
    return BuiltList.of(list.map((l) => SummaryListItem((b) => b
      ..tagName = l.tagName
      ..displayTotal = "¥${l.total}")));
  }
}
