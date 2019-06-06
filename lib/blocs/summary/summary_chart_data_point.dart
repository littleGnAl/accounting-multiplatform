import 'package:built_value/built_value.dart';

part 'summary_chart_data_point.g.dart';

abstract class SummaryChartDataPoint
    implements Built<SummaryChartDataPoint, SummaryChartDataPointBuilder> {
  int get monthIndex;
  double get totalExpenses;

  SummaryChartDataPoint._();
  factory SummaryChartDataPoint([update(SummaryChartDataPointBuilder b)]) =
      _$SummaryChartDataPoint;
}
