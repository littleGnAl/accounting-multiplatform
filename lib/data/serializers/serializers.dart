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
