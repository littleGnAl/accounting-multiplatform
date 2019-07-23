/*
 * Copyright (C) 2019 littlegnal
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:core';

import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_month.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_point.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_list_item.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class SummaryBloc implements BaseBloc {
  SummaryBloc(this._db);

  final AccountingRepository _db;

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

  @override
  void dispose() {
    _summaryChartDataSubject.close();
    _summaryListSubject.close();
  }

  void initialize() {
    getGroupingTagOfLatestMonth();
    getMonthTotalAmount();
  }

  Future<Null> getGroupingTagOfLatestMonth({DateTime dateTime}) async {
    var list =
        await _db.getGroupingTagOfLatestMonth(dateTime ?? DateTime.now());
    _summaryListSubject.sink.add(_createSummaryList(list));
  }

  Future<Null> getMonthTotalAmount({DateTime dateTime}) async {
    var now = dateTime ?? DateTime.now();

    List<SummaryChartDataMonth> months = List();
    List<SummaryChartDataPoint> points = List();
    List<String> values = List();

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
    var result = await _db.getMonthTotalAmount(dateTime);

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
    var result = await _db.getGroupingMonthTotalAmount(date);

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
