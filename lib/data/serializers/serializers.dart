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

import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:accountingmultiplatform/data/serializers/date_time_to_timemillseconds_serializer.dart';
import 'package:accountingmultiplatform/data/total_expenses.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_grouping_tag.dart';
import 'package:accountingmultiplatform/data/total_expenses_of_month.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Accounting,
  TotalExpenses,
  TotalExpensesOfMonth,
  TotalExpensesOfGroupingTag
])
final Serializers serializers = _$serializers;

final Serializers standardSerializers = (serializers.toBuilder()
      ..add(DateTimeToTimeMillisecondsSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();

T deserialize<T>(dynamic value) => standardSerializers.deserializeWith<T>(
    standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) =>
    BuiltList.from(value.map((value) => deserialize<T>(value)).toList());

Object serialize<T>(dynamic value) => standardSerializers.serializeWith(
    standardSerializers.serializerForType(T), value);
