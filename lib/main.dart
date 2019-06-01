import 'dart:core';
import 'dart:ui';

import 'package:accountingmultiplatform/themes.dart';
import 'package:accountingmultiplatform/ui/addedit/add_edit.dart';
import 'package:accountingmultiplatform/ui/home/home.dart';
import 'package:accountingmultiplatform/ui/summary/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'blocs/accounting_bloc_provider.dart';
import 'colors.dart';

void main() => runApp(_AccountingApp(route: window.defaultRouteName == null ? "home" : window.defaultRouteName));

class _AccountingApp extends StatelessWidget {
  final String _route;

  const _AccountingApp({Key key, @required String route})
      : this._route = route,
        super(key: key);

  Widget _widgetForRoute(String route) {
    switch (route) {
      case "home":
        return HomePage();
      case "add_edit":
        return AddEditPage();
      case "summary":
        return SummaryPage();
      default:
        return Center(
          child: Text(
            "Not Supported Page",
            textDirection: TextDirection.ltr,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: primaryColorDark));
    return MaterialApp(
      theme: appTheme,
      routes: {
        "add_edit": (context) => AddEditPage(),
        "summary": (context) => SummaryPage()
      },
      home: AccountingBlocProvider(
        child: _widgetForRoute(_route),
      ),
    );
  }
}
