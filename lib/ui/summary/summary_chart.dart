import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/ui/summary/summary_chart_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SummaryChart extends StatelessWidget {
  final SummaryChartData _summaryChartData;

  final Function(int, DateTime) _onSelectedIndexChanged;

  const SummaryChart(
      {Key key,
      @required SummaryChartData summaryChartData,
      Function(int, DateTime) onSelectedIndexChanged})
      : this._summaryChartData = summaryChartData,
        this._onSelectedIndexChanged = onSelectedIndexChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final summaryChartPainter = SummaryChartPainter(_summaryChartData);

    return GestureDetector(
      child: CustomPaint(
        painter: summaryChartPainter,
        size: Size.fromHeight(200.0),
      ),
      onTapUp: (detail) {
        RenderBox box = context.findRenderObject();
        final offset = box.globalToLocal(detail.globalPosition);

        var itemSpacing = summaryChartPainter.getItemSpacing(box.size.width);
        var x = offset.dx;
        var y = offset.dy;
        int index = x ~/ itemSpacing;

        var t = summaryChartPainter.selectMonth(
            box.size.height, itemSpacing, index, x, y);
        _onSelectedIndexChanged?.call(t.item1, t.item2);
      },
    );
  }
}
