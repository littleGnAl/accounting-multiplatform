import 'package:accountingmultiplatform/blocs/accounting_bloc.dart';
import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/accounting_db_provider.dart';
import 'package:accountingmultiplatform/ui/home/home_list_item.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockAccountingDBProvider extends Mock implements AccountingDBProvider {}

void main() {
  var now = DateTime(2019, 6, 22);

  AccountingDBProvider db;
  AccountingBloc accountingBloc;
  setUp(() {
    db = MockAccountingDBProvider();
    accountingBloc = AccountingBloc(db);
  });

  tearDown(() {
    db = null;
    accountingBloc.dispose();
  });

  var dateTime0621 = DateTime(2019, 6, 21);
  var dateTime0620 = DateTime(2019, 6, 20);
  var dateTime0619 = DateTime(2019, 6, 19);
  var firstPageAccountingList = [
    Accounting((b) => b
      ..id = 1
      ..amount = 10.0
      // 2019/6/21
      ..createTime = dateTime0621
      ..tagName = "Dinner"
      ..remarks = "bbbb"),
    Accounting((b) => b
      ..id = 2
      ..amount = 20.0
      // 2019/6/20
      ..createTime = dateTime0620
      ..tagName = "Lunch"
      ..remarks = "jjjjj"),
    Accounting((b) => b
      ..id = 3
      ..amount = 30.0
      // 2019/6/19
      ..createTime = dateTime0619
      ..tagName = "Dinner"
      ..remarks = "cccc"),
  ];

  var adapterList = [
    HomeListViewHeader((b) => b
      ..displayDate = "2019-06-21"
      ..displayTotal = "Total (¥10.0)"),
    HomeListViewContent((b) => b
      ..accounting = firstPageAccountingList[0].toBuilder()
      ..displayTime = "00:00"
      ..displayLabel = "Dinner"
      ..displayRemark = "bbbb"
      ..displayExpense = "¥10.0"),
    HomeListViewHeader((b) => b
      ..displayDate = "2019-06-20"
      ..displayTotal = "Total (¥20.0)"),
    HomeListViewContent((b) => b
      ..accounting = firstPageAccountingList[1].toBuilder()
      ..displayTime = "00:00"
      ..displayLabel = "Lunch"
      ..displayRemark = "jjjjj"
      ..displayExpense = "¥20.0"),
    HomeListViewHeader((b) => b
      ..displayDate = "2019-06-19"
      ..displayTotal = "Total (¥30.0)"),
    HomeListViewContent((b) => b
      ..accounting = firstPageAccountingList[2].toBuilder()
      ..displayTime = "00:00"
      ..displayLabel = "Dinner"
      ..displayRemark = "cccc"
      ..displayExpense = "¥30.0")
  ];

  test("refreshAccountingList with 3 accountings in db", () async {
    when(db.totalExpensesOfDay(dateTime0621.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(10.0));
    when(db.totalExpensesOfDay(dateTime0620.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(20.0));
    when(db.totalExpensesOfDay(dateTime0619.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(30.0));
    when(db.queryPreviousAccounting(now, 3))
        .thenAnswer((_) => Future.value(BuiltList.of(firstPageAccountingList)));

    await accountingBloc.refreshAccountingList(latestDate: now, limit: 3);

    expect((accountingBloc.accountings as BehaviorSubject).value,
        BuiltList.of(adapterList));
  });

  test("loadNextPage with same id", () async {
    when(db.totalExpensesOfDay(dateTime0621.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(10.0));
    when(db.totalExpensesOfDay(dateTime0620.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(20.0));
    when(db.totalExpensesOfDay(dateTime0619.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(30.0));
    when(db.queryPreviousAccounting(now, 3))
        .thenAnswer((_) => Future.value(BuiltList.of(firstPageAccountingList)));

    await accountingBloc.refreshAccountingList(latestDate: now, limit: 3);

    reset(db);

    var accountingWithId3 = Accounting((b) => b
      ..id = 3
      ..amount = 30.0
      // 2019/6/19
      ..createTime = dateTime0619
      ..tagName = "Dinner"
      ..remarks = "cccc");

    when(db.totalExpensesOfDay(dateTime0621.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(10.0));
    when(db.totalExpensesOfDay(dateTime0620.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(20.0));
    when(db.totalExpensesOfDay(dateTime0619.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(30.0));
    when(db.queryPreviousAccounting(dateTime0619, 3))
        .thenAnswer((_) => Future.value(BuiltList.of([accountingWithId3])));

    await accountingBloc.loadNextPage(limit: 3);

    expect((accountingBloc.accountings as BehaviorSubject).value, adapterList);
  });

  test("loadNextPage with different id", () async {
    when(db.totalExpensesOfDay(dateTime0621.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(10.0));
    when(db.totalExpensesOfDay(dateTime0620.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(20.0));
    when(db.totalExpensesOfDay(dateTime0619.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(30.0));
    when(db.queryPreviousAccounting(now, 3))
        .thenAnswer((_) => Future.value(BuiltList.of(firstPageAccountingList)));

    await accountingBloc.refreshAccountingList(latestDate: now, limit: 3);

    reset(db);

    var accountingWithId4 = Accounting((b) => b
      ..id = 4
      ..amount = 40.0
      ..createTime = dateTime0619
      ..tagName = "Breakfast"
      ..remarks = "ggggg");

    when(db.totalExpensesOfDay(dateTime0621.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(10.0));
    when(db.totalExpensesOfDay(dateTime0620.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(20.0));
    when(db.totalExpensesOfDay(dateTime0619.millisecondsSinceEpoch))
        .thenAnswer((_) => Future.value(70.0));
    when(db.queryPreviousAccounting(dateTime0619, 3))
        .thenAnswer((_) => Future.value(BuiltList([accountingWithId4])));

    var newAdapterList = adapterList.toList();
    var newItem = newAdapterList[4] as HomeListViewHeader;
    newItem = newItem.rebuild((b) => b..displayTotal = "Total (¥70.0)");
    newAdapterList[4] = newItem;

    await accountingBloc.loadNextPage(limit: 3);

    newAdapterList.add(HomeListViewContent((b) => b
      ..accounting = accountingWithId4.toBuilder()
      ..displayTime = "00:00"
      ..displayLabel = "Breakfast"
      ..displayRemark = "ggggg"
      ..displayExpense = "¥40.0"));

    expect((accountingBloc.accountings as BehaviorSubject).value,
        BuiltList.of(newAdapterList));
  });

  test("delete with id 1", () async {
    await accountingBloc.delete(1);
    verify(db.deleteAccountingById(1)).called(1);
  });
}
