import 'dart:async';
import 'dart:core';

import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/data/accounting_db_provider.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class SummaryBloc {
  final _summaryChartDataSubject = BehaviorSubject.seeded(
      SummaryChartData(months: [], points: [], values: [], selectedIndex: -1));
  final _summaryListSubject =
      BehaviorSubject<List<Tuple2<String, String>>>.seeded([]);

  Stream<SummaryChartData> get summaryChartData =>
      _summaryChartDataSubject.stream;

  Stream<List<Tuple2<String, String>>> get summaryList =>
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
    List<Tuple2<String, double>> result = await db.getMonthTotalAmount();
    List<Tuple2<String, DateTime>> months = List();
    List<Tuple2<int, double>> points = List();
    List<String> values = List();

    var now = DateTime.now();
    var today = DateTime(now.year, now.month - 5, 1);
    var firstMonth =
        DateTime.fromMillisecondsSinceEpoch(today.millisecondsSinceEpoch);
    for (var i = 0; i < 6; i++) {
      var tempMonth =
          DateTime.fromMillisecondsSinceEpoch(today.millisecondsSinceEpoch);
      var monthString = _monthFormat.format(tempMonth);
      months.add(Tuple2(monthString, tempMonth));
      today = DateTime(today.year, today.month + 1, today.day);
    }

    var selectedIndex = -1;

    if (result.isNotEmpty) {
      var reverseList = result.reversed;
      var latestMonth = _yearMonthFormat.parse(reverseList.last.item1);
      selectedIndex = _monthBetween(latestMonth, firstMonth);

      reverseList.forEach((monthTotal) {
        var monthTotalDate = _yearMonthFormat.parse(monthTotal.item1);
        if (monthTotalDate.isAtSameMomentAs(firstMonth) ||
            monthTotalDate.isAfter(firstMonth)) {
          var index = _monthBetween(monthTotalDate, firstMonth);
          points.add(Tuple2(index, monthTotal.item2));
          values.add("¥${monthTotal.item2}");
        }
      });
    }

    _summaryChartDataSubject.sink.add(SummaryChartData(
        months: months,
        points: points,
        values: values,
        selectedIndex: selectedIndex));
  }

  int _monthBetween(DateTime date1, DateTime date2) {
    return ((date1.year * 12 + date1.month) - (date2.year * 12 + date2.month))
        .abs();
  }

  Future<Null> switchMonth(int index, DateTime date) async {
    print("Switch month to $date");
    final db = AccountingDBProvider.db;
    var result = await db.getGroupingMonthTotalAmount(
        date.year.toString(), date.month.toString().padLeft(2, "0"));

    var old = _summaryChartDataSubject.value;
    _summaryChartDataSubject.sink.add(SummaryChartData(
        months: old.months,
        points: old.points,
        values: old.values,
        selectedIndex: index));

    _summaryListSubject.sink.add(_createSummaryList(result));
  }

  List<Tuple2<String, String>> _createSummaryList(
      List<Tuple2<String, double>> list) {
    return list
        .map((l) => Tuple2<String, String>(l.item1, "¥${l.item2}"))
        .toList();
  }
}
