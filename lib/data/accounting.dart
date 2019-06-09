import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accounting.g.dart';

abstract class Accounting implements Built<Accounting, AccountingBuilder> {
  int get id;
  double get amount;
  // https://github.com/google/built_value.dart/issues/454
  DateTime get createTime;
  @BuiltValueField(wireName: "tag_name")
  String get tagName;
  String get remarks;

  Accounting._();
  factory Accounting([update(AccountingBuilder b)]) = _$Accounting;

  static Serializer<Accounting> get serializer => _$accountingSerializer;
}
