import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'total_expenses_of_grouping_tag.g.dart';

abstract class TotalExpensesOfGroupingTag
    implements
        Built<TotalExpensesOfGroupingTag, TotalExpensesOfGroupingTagBuilder> {
  double get total;
  @BuiltValueField(wireName: "tag_name")
  String get tagName;

  TotalExpensesOfGroupingTag._();
  factory TotalExpensesOfGroupingTag(
          [update(TotalExpensesOfGroupingTagBuilder b)]) =
      _$TotalExpensesOfGroupingTag;

  static Serializer<TotalExpensesOfGroupingTag> get serializer =>
      _$totalExpensesOfGroupingTagSerializer;
}
