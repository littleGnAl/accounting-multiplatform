import 'dart:async';
import 'dart:core';

import 'package:accountingmultiplatform/blocs/accounting_bloc.dart';
import 'package:accountingmultiplatform/blocs/add_edit_bloc.dart';
import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors.dart';
import 'labels.dart';

class AddEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _addEditBloc = AddEditBloc(AccountingRepository.db);

  final _expensesTextController = TextEditingController();
  final _remarkTextController = TextEditingController();

  Widget _buildTitle(String title, {double marginTop = 20.0}) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: TextStyle(
              color: Color(0xff323232),
              fontSize: 20.0,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTimeText() {
    return StreamBuilder(
      stream: _addEditBloc.time,
      builder: (context, snapshot) {
        var text;
        var textColor;
        if (snapshot.data != null && (snapshot.data as String).isNotEmpty) {
          text = snapshot.data;
          textColor = accentColor;
        } else {
          text = "Please select time";
          textColor = Color(0xff888888);
        }

        return Text(
          text,
          style: TextStyle(color: textColor, fontSize: 18.0),
        );
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1);
    var lastDate = DateTime(now.year + 1);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    if (picked != null) {
      _addEditBloc.changeTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int accountingId = ModalRoute.of(context).settings.arguments;
    String title;
    if (accountingId != null && accountingId != 0) {
      title = "Edit";

      _addEditBloc.getAccountingById(accountingId);
    } else {
      title = "Add";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            _buildTitle("Expenses"),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: StreamBuilder<String>(
                stream: _addEditBloc.expenses,
                builder: (context, snapshot) {
                  _expensesTextController.value = _expensesTextController.value
                      .copyWith(text: snapshot.data);

                  return TextField(
                    onChanged: _addEditBloc.changeExpenses,
                    controller: _expensesTextController,
                    decoration: InputDecoration(
                      hintText: "Enter your expenses",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          borderSide: BorderSide(color: Color(0x19000000)),
                          gapPadding: 8.0),
                    ),
                    autofocus: true,
                    style: TextStyle(fontSize: 16.0),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  );
                },
              ),
            ),
            _buildTitle("Labels"),
            Labels(
                selectedLabel: _addEditBloc.label,
                onCheckedChanged: _addEditBloc.changeLabel),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  _buildTitle("Time", marginTop: 0.0),
                  Expanded(
                    child: Align(
                      child: GestureDetector(
                        child: _buildTimeText(),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              ),
            ),
            _buildTitle("Remark"),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                height: 200,
                child: SizedBox.expand(
                  child: StreamBuilder<String>(
                    stream: _addEditBloc.remark,
                    builder: (context, snapshot) {
                      _remarkTextController.value = _remarkTextController.value
                          .copyWith(text: snapshot.data);
                      return TextField(
                        onChanged: _addEditBloc.changeRemark,
                        controller: _remarkTextController,
                        maxLines: 8,
                        decoration: InputDecoration(
                          hintText: "Enter your remark",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0)),
                              borderSide: BorderSide(color: Color(0x19000000)),
                              gapPadding: 8.0),
                        ),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        keyboardType: TextInputType.text,
                      );
                    },
                  ),
                )),
            Container(
                height: 50,
                child: SizedBox.expand(
                  child: StreamBuilder<bool>(
                    stream: _addEditBloc.isSubmitValid,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      final c = snapshot.hasData && snapshot.data
                          ? accentColor
                          : unableColor;
                      return RaisedButton(
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Color(0xffffffff)),
                        ),
                        color: c,
                        onPressed: () {
                          _saveAccounting();
                        },
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _saveAccounting() async {
    _addEditBloc.saveAccounting();
    var accountingBloc = BlocProvider.of<AccountingBloc>(context);
    accountingBloc.refreshAccountingList();
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _addEditBloc.dispose();
    super.dispose();
  }
}
