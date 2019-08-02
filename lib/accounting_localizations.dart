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

import 'dart:ui';

import 'package:accountingmultiplatform/l10n/messages_all.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const List<Locale> supportedLocales = [
  const Locale('en', ''),
  const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hans',
      countryCode: 'CN'),
  const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
      countryCode: 'HK')
];

class AccountingLocalizations {

  static Future<AccountingLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    debugPrint("name: $name");
    final String localeName = Intl.canonicalizedLocale(name);
    debugPrint("localeName: $localeName");
    return initializeMessages(localeName).then((_) async {
      Intl.defaultLocale = localeName;
      print("initializeMessages default locale: ${Intl.defaultLocale}");
//      initializeDateFormatting(localeName, null);
//      return initializeDateFormatting(localeName).then((_) {
//        return AccountingLocalizations();
//      });

      await initializeDateFormatting(localeName);

      return AccountingLocalizations();




    });
  }

  static AccountingLocalizations of(BuildContext context) {
    return Localizations.of(context, AccountingLocalizations);
  }

  String get currencySymbol => Intl.message("\$", name: "currencySymbol");
}

class AccountingLocalizationsDelegate extends LocalizationsDelegate<AccountingLocalizations> {

  const AccountingLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AccountingLocalizations> load(Locale locale) async {

    return AccountingLocalizations.load(locale);
  }


  @override
  bool shouldReload(LocalizationsDelegate<AccountingLocalizations> old) {
    return false;
  }
}

