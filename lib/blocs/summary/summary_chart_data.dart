import 'package:tuple/tuple.dart';

class SummaryChartData {
  final List<Tuple2<String, DateTime>> months;
  final List<Tuple2<int, double>> points;
  final List<String> values;
  final int selectedIndex;

  const SummaryChartData(
      {this.months, this.points, this.values, this.selectedIndex});
}
