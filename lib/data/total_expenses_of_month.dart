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

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'total_expenses_of_month.g.dart';

abstract class TotalExpensesOfMonth
    implements Built<TotalExpensesOfMonth, TotalExpensesOfMonthBuilder> {
  String get yearMonth;

  double get total;

  TotalExpensesOfMonth._();
  factory TotalExpensesOfMonth([update(TotalExpensesOfMonthBuilder b)]) =
      _$TotalExpensesOfMonth;

  static Serializer<TotalExpensesOfMonth> get serializer =>
      _$totalExpensesOfMonthSerializer;
}
