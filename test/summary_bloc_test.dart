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

import 'package:accountingmultiplatform/blocs/summary/summary_bloc.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_month.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_point.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_list_item.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockAccountingDBProvider extends Mock implements AccountingRepository {}

void main() {
  var now = DateTime.fromMillisecondsSinceEpoch(1561202892000);

  AccountingRepository db;
  SummaryBloc summaryBloc;

  setUp(() {
    db = MockAccountingDBProvider();
    summaryBloc = SummaryBloc(db);
  });

  tearDown(() {
    db = null;
    summaryBloc.dispose();
  });

  Future<Null> testGetMonthTotalAmount() async {
    var months = [
      SummaryChartDataMonth((b) => b
        ..displayMonth = "Jan"
        ..monthDateTime = DateTime(2019, 1, 1)),
      SummaryChartDataMonth((b) => b
        ..displayMonth = "Feb"
        ..monthDateTime = DateTime(2019, 2, 1)),
      SummaryChartDataMonth((b) => b
        ..displayMonth = "Mar"
        ..monthDateTime = DateTime(2019, 3, 1)),
      SummaryChartDataMonth((b) => b
        ..displayMonth = "Apr"
        ..monthDateTime = DateTime(2019, 4, 1)),
      SummaryChartDataMonth((b) => b
        ..displayMonth = "May"
        ..monthDateTime = DateTime(2019, 5, 1)),
      SummaryChartDataMonth((b) => b
        ..displayMonth = "Jun"
        ..monthDateTime = DateTime(2019, 6, 1))
    ];

    var totalExpensesList = [
      TotalExpensesOfMonth((b) => b
        ..total = 220.0
        ..yearMonth = "2019-06"),
      TotalExpensesOfMonth((b) => b
        ..total = 60.0
        ..yearMonth = "2019-05")
    ];

    var points = [
      SummaryChartDataPoint((b) => b
        ..monthIndex = 4
        ..totalExpenses = 60.0),
      SummaryChartDataPoint((b) => b
        ..monthIndex = 5
        ..totalExpenses = 220.0),
    ];
    var values = ["¥60.0", "¥220.0"];

    var expected = SummaryChartData((b) => b
      ..months = ListBuilder(months)
      ..points = ListBuilder(points)
      ..values = ListBuilder(values)
      ..selectedIndex = 5);
    when(db.getMonthTotalAmount(now))
        .thenAnswer((_) => Future.value(BuiltList.of(totalExpensesList)));

    await summaryBloc.getMonthTotalAmount(dateTime: now);

    expect((summaryBloc.summaryChartData as BehaviorSubject).value, expected);
  }

  test("getMonthTotalAmount with milliseconds 1561202892000", () async {
    await testGetMonthTotalAmount();
  });

  Future<Null> testGetGroupingTagOfLatestMonth() async {
    var totalExpensesGroupTagList = [
      TotalExpensesOfGroupingTag((b) => b
        ..total = 90.0
        ..tagName = "Breakfast"),
      TotalExpensesOfGroupingTag((b) => b
        ..total = 50.0
        ..tagName = "Lunch")
    ];
    var summaryList = [
      SummaryListItem((b) => b
        ..tagName = "Breakfast"
        ..displayTotal = "¥90.0"),
      SummaryListItem((b) => b
        ..tagName = "Lunch"
        ..displayTotal = "¥50.0")
    ];

    when(db.getGroupingTagOfLatestMonth(now)).thenAnswer(
        (_) => Future.value(BuiltList.of(totalExpensesGroupTagList)));

    await summaryBloc.getGroupingTagOfLatestMonth(dateTime: now);

    expect((summaryBloc.summaryList as BehaviorSubject).value,
        BuiltList.of(summaryList));
  }

  test("getGroupingTagOfLatestMonth with milliseconds 1561202892000", () async {
    await testGetGroupingTagOfLatestMonth();
  });

  test("switchMonth to index = 4 date = 2019-05-01", () async {
    await testGetMonthTotalAmount();
    await testGetGroupingTagOfLatestMonth();

    reset(db);

    var switchDate = DateTime(2019, 5, 1);

    when(db.getGroupingMonthTotalAmount(switchDate))
        .thenAnswer((_) => Future.value(BuiltList.of([
              TotalExpensesOfGroupingTag((b) => b
                ..total = 10.0
                ..tagName = "Dinner")
            ])));

    await summaryBloc.switchMonth(4, switchDate);

    var switchSummaryList = [
      SummaryListItem((b) => b
        ..tagName = "Dinner"
        ..displayTotal = "¥10.0")
    ];

    expect((summaryBloc.summaryList as BehaviorSubject).value,
        BuiltList.of(switchSummaryList));

    var index = ((summaryBloc.summaryChartData as BehaviorSubject).value
            as SummaryChartData)
        .selectedIndex;

    expect(index, 4);
  });
}
