import 'dart:async';

import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

// Refer https://github.com/shiang/flutter-form-with-validation-BLOC/blob/master/lib/src/blocs/bloc.dart
class AddEditBloc implements BaseBloc {
  AddEditBloc(this._db);

  final AccountingRepository _db;

  static final DateTime _initialDateTime = DateTime.now();

  final _expensesSubject = BehaviorSubject.seeded("0");
  final _labelSubject = BehaviorSubject.seeded("");
  final _timeSubject = BehaviorSubject.seeded(_initialDateTime);
  final _remarkSubject = BehaviorSubject.seeded("");

  int _editAccountingId = 0;

  bool _isGetAccounting = false;

  final dateFormat = DateFormat("yyyy MMM dd");

  Stream<String> get expenses => _expensesSubject.stream;
  Stream<String> get label => _labelSubject.stream;
  Stream<String> get time => _timeSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (dateTime, sink) {
        if (dateTime != _initialDateTime) {
          sink.add(dateFormat.format(dateTime));
        } else {
          sink.add("");
        }
      }));
  Stream<String> get remark => _remarkSubject.stream;

  Stream<bool> get isSubmitValid =>
      Observable.combineLatest3(expenses, label, time,
          (String e, String l, String t) {
        return e.isNotEmpty && l.isNotEmpty && t.isNotEmpty;
      });

  Function(String) get changeExpenses => _expensesSubject.sink.add;
  Function(String) get changeLabel => _labelSubject.sink.add;
  Function(DateTime) get changeTime => _timeSubject.sink.add;
  Function(String) get changeRemark => _remarkSubject.sink.add;

  getAccountingById(int id) async {
    if (_isGetAccounting || id == 0) return;

    var a = await _db.getAccountingById(id);

    if (a != null) {
      _editAccountingId = id;
      _expensesSubject.sink.add(a.amount.toString());
      _labelSubject.sink.add(a.tagName);
      _timeSubject.sink.add(a.createTime);
      _remarkSubject.sink.add(a.remarks);

      _isGetAccounting = true;
    }
  }

  void saveAccounting() async {
    Accounting a = Accounting((b) => b
      ..id = _editAccountingId
      ..amount = double.parse(_expensesSubject.value)
      ..createTime = _timeSubject.value
      ..tagName = _labelSubject.value
      ..remarks = _remarkSubject.value);

    await _db.insertAccounting(a);
  }

  @override
  void dispose() {
    _expensesSubject.close();
    _labelSubject.close();
    _timeSubject.close();
    _remarkSubject.close();
  }
}
