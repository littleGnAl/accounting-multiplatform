import 'dart:async';
import 'dart:convert';

import 'package:accountingmultiplatform/data/serializers/serializers.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'accounting.dart';

class AccountingDBProvider {
  static const _platform =
      const MethodChannel("com.littlegnal.accountingmultiplatform/sqldelight");

  static final AccountingDBProvider db = AccountingDBProvider._();

  final DateFormat _yearMonthFormat = DateFormat("yyyy-MM");

  AccountingDBProvider._();

  Future<BuiltList<Accounting>> queryPreviousAccounting(
      DateTime lastDate, int limit) async {
    var arguments = {
      "lastDateTimeMilliseconds": lastDate.millisecondsSinceEpoch,
      "limit": limit
    };
    var result =
        await _platform.invokeMethod("queryPreviousAccounting", arguments);

    return deserializeListOf<Accounting>(jsonDecode(result));
  }

  Future<Null> insertAccounting(Accounting accounting) async {
    var arguments = {
      "id": accounting.id,
      "amount": accounting.amount,
      "createTime": accounting.createTime.millisecondsSinceEpoch,
      "tagName": accounting.tagName,
      "remarks": accounting.remarks
    };

    await _platform.invokeMethod("insertAccounting", arguments);
  }

  Future<Null> deleteAccountingById(int id) async {
    var arguments = {"id": id};
    await _platform.invokeMethod("deleteAccountingById", arguments);
  }

  Future<Accounting> getAccountingById(int id) async {
    var arguments = {"id": id};
    var result = await _platform.invokeMethod("getAccountingById", arguments);

    return deserialize<Accounting>(jsonDecode(result));
  }

  Future<double> totalExpensesOfDay(int millisecondsSinceEpoch) async {
    var timeInMillis = millisecondsSinceEpoch ~/ 1000;
    var arguments = {"timeMilliseconds": timeInMillis};
    var result = await _platform.invokeMethod("totalExpensesOfDay", arguments);

    return result;
  }

  Future<BuiltList<TotalExpensesOfMonth>> getMonthTotalAmount(
      [DateTime latestMonth]) async {
    var dateTime = latestMonth ?? DateTime.now();
    var yearMonthList = List<String>();
    for (var i = 0; i <= 6; i++) {
      var d = DateTime(dateTime.year, dateTime.month - i, 1);
      yearMonthList.add(_yearMonthFormat.format(d));
    }

    var arguments = {"yearAndMonthList": yearMonthList};
    var result = await _platform.invokeMethod("getMonthTotalAmount", arguments);

    return deserializeListOf<TotalExpensesOfMonth>(jsonDecode(result));
  }

  Future<BuiltList<TotalExpensesOfGroupingTag>> getGroupingTagOfLatestMonth(
      DateTime latestMonth) async {
    return getGroupingMonthTotalAmount(latestMonth);
  }

  Future<BuiltList<TotalExpensesOfGroupingTag>> getGroupingMonthTotalAmount(
      DateTime dateTime) async {
    var arguments = {"yearAndMonth": _yearMonthFormat.format(dateTime)};
    var result =
        await _platform.invokeMethod("getGroupingMonthTotalAmount", arguments);

    return deserializeListOf<TotalExpensesOfGroupingTag>(jsonDecode(result));
  }
}
