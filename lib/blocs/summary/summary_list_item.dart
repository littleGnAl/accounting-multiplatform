import 'package:built_value/built_value.dart';

part 'summary_list_item.g.dart';

abstract class SummaryListItem
    implements Built<SummaryListItem, SummaryListItemBuilder> {
  String get tagName;
  String get displayTotal;

  SummaryListItem._();
  factory SummaryListItem([update(SummaryListItemBuilder b)]) =
      _$SummaryListItem;
}
