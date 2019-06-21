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
