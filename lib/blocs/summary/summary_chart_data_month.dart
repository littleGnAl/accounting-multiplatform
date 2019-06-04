import 'package:built_value/built_value.dart';

part 'summary_chart_data_month.g.dart';

abstract class SummaryChartDataMonth
    implements Built<SummaryChartDataMonth, SummaryChartDataMonthBuilder> {
  String get displayMonth;
  DateTime get monthDateTime;

  SummaryChartDataMonth._();
  factory SummaryChartDataMonth([update(SummaryChartDataMonthBuilder b)]) =
      _$SummaryChartDataMonth;
}
