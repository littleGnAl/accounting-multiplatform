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

//  factory Accounting.fromMap(Map<String, dynamic> json) => Accounting(
//      id: json["id"],
//      amount: json["amount"],
//      createTime: DateTime.fromMillisecondsSinceEpoch(json["createTime"]),
//      tagName: json["tag_name"],
//      remarks: json["remarks"]);
//
//  Map<String, dynamic> toJson() => {
//        "id": id,
//        "amount": amount,
//        "createTime": createTime.millisecondsSinceEpoch,
//        "tag_name": tagName,
//        "remarks": remarks
//      };
//
//  Map<String, dynamic> toInsertJson() => {
//        "amount": amount,
//        "createTime": createTime.millisecondsSinceEpoch,
//        "tag_name": tagName,
//        "remarks": remarks
//      };
//
//  List toInsertArgs() =>
//      [amount, createTime.millisecondsSinceEpoch, tagName, remarks];
//
//  @override
//  String toString() {
//    return 'Accounting{id: $id, amount: $amount, createTime: $createTime,'
//        ' tagName: $tagName, remarks: $remarks}';
//  }
}
