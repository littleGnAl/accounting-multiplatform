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

import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_month.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_point.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'summary_chart_data.g.dart';

abstract class SummaryChartData
    implements Built<SummaryChartData, SummaryChartDataBuilder> {
  BuiltList<SummaryChartDataMonth> get months;
  BuiltList<SummaryChartDataPoint> get points;
  BuiltList<String> get values;
  int get selectedIndex;

  SummaryChartData._();
  factory SummaryChartData([update(SummaryChartDataBuilder b)]) =
      _$SummaryChartData;
}
