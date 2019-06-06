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
