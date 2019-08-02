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

import 'package:accountingmultiplatform/accounting_localizations.dart';
import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:accountingmultiplatform/ui/home/home_list_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

class AccountingBloc implements BaseBloc {
  AccountingBloc(this._db);

  static const int _sizePerPage = 20;

  final AccountingRepository _db;

  final _accountingListSubject =
      BehaviorSubject<BuiltList<HomeListViewItem>>.seeded(BuiltList());

  Stream<BuiltList<HomeListViewItem>> get accountings =>
      _accountingListSubject.stream;

  int _currentPage = 1;

  DateFormat _dayNumFormat;
  DateFormat _dateFormat;
  DateFormat _timeFormat;

  @override
  void dispose() {
    _currentPage = 0;
    _accountingListSubject.close();
  }

  Future<BuiltList<HomeListViewItem>> _getAccountingByPage(
      BuildContext context,
      {DateTime latestDate, int limit = _sizePerPage}) async {
    _dayNumFormat = DateFormat("yyyyMMdd");
    _timeFormat = DateFormat("HH:mm");

    var preDayNum = _dayNumFormat.format(latestDate);

    var list = await _db.queryPreviousAccounting(latestDate, limit);

    if (list == null || list.isEmpty) {
      return BuiltList();
    }

    var newList = List<HomeListViewItem>();

    for (Accounting item in list) {
      var dateNum = _dayNumFormat.format(item.createTime);
      if (dateNum != preDayNum) {
        newList.add(await _createHeader(item.createTime));

        preDayNum = dateNum;
      }

      newList.add(HomeListViewContent((b) => b
        ..accounting = item.toBuilder()
        ..displayTime = _timeFormat.format(item.createTime)
        ..displayLabel = item.tagName
        ..displayRemark = item.remarks
        ..displayExpense = "${AccountingLocalizations.of(context).currencySymbol}${item.amount}"));
    }

    return BuiltList.of(newList);
  }

  Future<HomeListViewHeader> _createHeader(DateTime date) async {
    _dateFormat = DateFormat("yyyy-MM-dd");
    var dateTitle = _dateFormat.format(date);
    var tempDateTime = DateTime(date.year, date.month, date.day);

    var sumOfDay =
        await _db.totalExpensesOfDay(tempDateTime.millisecondsSinceEpoch);
    var sumString = "Total (¥$sumOfDay)";
    return HomeListViewHeader((b) => b
      ..displayDate = dateTitle
      ..displayTotal = sumString);
  }

  Future<Null> loadNextPage(BuildContext context, {int limit}) async {
    var l = limit == 0 ? _sizePerPage : limit;
    var preList = _accountingListSubject.value;
    var lastItem = preList.last;
    if (lastItem is HomeListViewContent) {
      var last = lastItem.accounting;
      ++_currentPage;

      var nextPageList =
          await _getAccountingByPage(context, latestDate: last.createTime, limit: l);

      var newList = preList.toList();

      // Force update the last HomeListViewHeader because the total value maybe
      // changed
      var lastHeaderIndex =
          newList.lastIndexWhere((e) => e is HomeListViewHeader);
      var newHeader = await _createHeader(last.createTime);
      newList[lastHeaderIndex] = newHeader;

      newList.addAll(nextPageList);
      // Distinct all items
      newList = newList.toSet().toList();

      _accountingListSubject.sink.add(BuiltList.of(newList));
    }
  }

  Future<BuiltList<HomeListViewItem>> _refresh(
      BuildContext context,
      {DateTime latestDate, int limit = _sizePerPage}) async {
    var refreshList =
        await _getAccountingByPage(context, latestDate: latestDate, limit: limit);
    print("Refreshing list with: $refreshList");

    if (refreshList == null || refreshList.isEmpty) return BuiltList();

    var newList = refreshList.toList();

    var firstItem = refreshList[0];
    if (firstItem is HomeListViewContent) {
      newList.insert(0, await _createHeader(firstItem.accounting.createTime));
    }

    return BuiltList.of(newList);
  }

  Future<Null> refreshAccountingList(BuildContext context, {DateTime latestDate, int limit}) async {
    _accountingListSubject.sink.add(await _refresh(
        context,
        latestDate: latestDate ?? DateTime.now(),
        limit: limit ?? _currentPage * _sizePerPage));
  }

  Future<Null> delete(BuildContext context, int id) async {
    print("Deleting item with id: $id");
    await _db.deleteAccountingById(id);
    refreshAccountingList(context);
  }
}
