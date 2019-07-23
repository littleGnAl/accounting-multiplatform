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
