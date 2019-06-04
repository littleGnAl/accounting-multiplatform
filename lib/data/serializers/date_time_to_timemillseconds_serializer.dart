import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

class DateTimeToTimeMillisecondsSerializer
    implements PrimitiveSerializer<DateTime> {
  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is int && specifiedType.root == DateTime) {
      return DateTime.fromMillisecondsSinceEpoch(serialized);
    }
    return serialized;
  }

  @override
  Object serialize(Serializers serializers, DateTime object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.millisecondsSinceEpoch;
  }

  @override
  Iterable<Type> get types => BuiltList([DateTime]);

  @override
  String get wireName => "createTime";
}
