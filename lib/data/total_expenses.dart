import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'total_expenses.g.dart';

abstract class TotalExpenses
    implements Built<TotalExpenses, TotalExpensesBuilder> {
  double get total;

  TotalExpenses._();
  factory TotalExpenses([update(TotalExpensesBuilder b)]) = _$TotalExpenses;

  static Serializer<TotalExpenses> get serializer => _$totalExpensesSerializer;
}
