import 'package:accountingmultiplatform/data/accounting_db_provider.dart';
import 'package:flutter/widgets.dart';

import 'accounting_bloc.dart';

class AccountingBlocProvider extends InheritedWidget {
  final accountingBloc = AccountingBloc(AccountingDBProvider.db);

  AccountingBlocProvider({
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static AccountingBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AccountingBlocProvider)
            as AccountingBlocProvider)
        .accountingBloc;
  }
}
