import 'dart:async';
import 'dart:core';

import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/accounting_db_provider.dart';
import 'package:accountingmultiplatform/ui/home/home_list_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

class AccountingBloc {
  static const int _sizePerPage = 20;

  final _db = AccountingDBProvider.db;

  final _accountingListSubject =
      BehaviorSubject<BuiltList<HomeListViewItem>>.seeded(BuiltList());

  Stream<BuiltList<HomeListViewItem>> get accountings =>
      _accountingListSubject.stream;

  int _currentPage = 1;

  final DateFormat _dayNumFormat = DateFormat("yyyyMMdd");
  final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  final DateFormat _timeFormat = DateFormat("HH:mm");

  dispose() {
    _currentPage = 0;
    _accountingListSubject.close();
  }

  Future<BuiltList<HomeListViewItem>> _getAccountingByPage(
      {DateTime latestDate, int limit = _sizePerPage}) async {
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

      newList.add(HomeListViewContent(
          accounting: item,
          displayTime: _timeFormat.format(item.createTime),
          displayLabel: item.tagName,
          displayRemark: item.remarks,
          displayExpense: "¥${item.amount}"));
    }

    return BuiltList.of(newList);
  }

  Future<HomeListViewHeader> _createHeader(DateTime date) async {
    var dateTitle = _dateFormat.format(date);
    var tempDateTime = DateTime(date.year, date.month, date.day);

    var sumOfDay =
        await _db.totalExpensesOfDay(tempDateTime.millisecondsSinceEpoch);
    var sumString = "Total (¥$sumOfDay)";
    return HomeListViewHeader(displayDate: dateTitle, displayTotal: sumString);
  }

  Future<Null> loadNextPage() async {
    var preList = _accountingListSubject.value;
    var lastItem = preList.last;
    if (lastItem is HomeListViewContent) {
      var last = lastItem.accounting;
      ++_currentPage;

      var nextPageList = await _getAccountingByPage(
          latestDate: last.createTime, limit: _sizePerPage);

      var newList = preList.toList()
        ..addAll(nextPageList)
        ..toSet()
        ..toList();

      _accountingListSubject.sink.add(BuiltList.of(newList));
    }
  }

  Future<BuiltList<HomeListViewItem>> _refresh() async {
    var refreshList = await _getAccountingByPage(
        latestDate: DateTime.now(), limit: _currentPage * _sizePerPage);
    print("Refreshing list with: $refreshList");

    if (refreshList == null || refreshList.isEmpty) return BuiltList();

    var newList = refreshList.toList();

    var firstItem = refreshList[0];
    if (firstItem is HomeListViewContent) {
      newList.insert(0, await _createHeader(firstItem.accounting.createTime));
    }

    return BuiltList.of(newList);
  }

  Future<Null> refreshAccountingList() async {
    _accountingListSubject.sink.add(await _refresh());
  }

  Future<Null> delete(int id) async {
    print("Deleting item with id: $id");
    await _db.deleteAccountingById(id);
    refreshAccountingList();
  }
}
