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
