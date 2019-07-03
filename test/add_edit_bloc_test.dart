import 'package:accountingmultiplatform/blocs/add_edit_bloc.dart';
import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockAccountingDBProvider extends Mock implements AccountingRepository {}

void main() {
  AccountingRepository db;
  AddEditBloc addEditBloc;
  setUp(() {
    db = MockAccountingDBProvider();
    addEditBloc = AddEditBloc(db);
  });

  tearDown(() {
    db = null;
    addEditBloc.dispose();
  });

  test("getAccountingById with id 1", () async {
    var accounting = Accounting((b) => b
      ..id = 1
      ..amount = 10.0
      ..createTime = DateTime.fromMillisecondsSinceEpoch(1561202892000)
      ..tagName = "Dinner"
      ..remarks = "jjjjj");
    when(db.getAccountingById(1)).thenAnswer((_) => Future.value(accounting));

    await addEditBloc.getAccountingById(1);

    addEditBloc.time.listen((v) {
      expect(v, "2019 Jun 22");
    });

    expect((addEditBloc.expenses as BehaviorSubject).value, "10.0");
    expect((addEditBloc.label as BehaviorSubject).value, "Dinner");
    expect((addEditBloc.remark as BehaviorSubject).value, "jjjjj");
  });

  test("saveAccounting", () async {
    var accounting = Accounting((b) => b
      ..id = 0
      ..amount = 10.0
      ..createTime = DateTime.fromMillisecondsSinceEpoch(1561202892000)
      ..tagName = "Dinner"
      ..remarks = "jjjjj");

    addEditBloc.changeExpenses("10.0");
    addEditBloc.changeLabel("Dinner");
    addEditBloc.changeTime(DateTime.fromMillisecondsSinceEpoch(1561202892000));
    addEditBloc.changeRemark("jjjjj");

    addEditBloc.saveAccounting();

    verify(db.insertAccounting(accounting)).called(1);
  });
}
