import 'dart:math';

import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_month.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data_point.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';

import '../../colors.dart';

class SummaryChartPainter extends CustomPainter {
  SummaryChartPainter(SummaryChartData summaryChartData)
      : this._values = summaryChartData.values,
        this._selectedIndex = summaryChartData.selectedIndex {
    points = summaryChartData.points;
    months = summaryChartData.months;
  }

  static const double SELECTED_DOT_RADIUS = 6.0;
  static const double DOT_RADIUS = 3.0;
  static const double TOUCH_RADIUS = 20.0;

  final _linePaint = Paint()
    ..isAntiAlias = true
    ..color = accentColor
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  final _valueTipsPaint = Paint()
    ..isAntiAlias = true
    ..color = Color(0xfff3f3f3)
    ..style = PaintingStyle.fill;

  final _dotPaint = Paint()
    ..isAntiAlias = true
    ..color = accentColor
    ..style = PaintingStyle.fill;

  final _curvePath = Path();
  final _trianglePath = Path();

  double _max;
  double _min;
  BuiltList<SummaryChartDataPoint> _points;

  BuiltList<SummaryChartDataMonth> _months;

  BuiltList<String> _values;

  int _selectedIndex = -1;

  set months(BuiltList<SummaryChartDataMonth> m) {
    _months = m;
  }

  set points(BuiltList<SummaryChartDataPoint> p) {
    _points = p;
    if (p.isEmpty) {
      _max = _min = -1.0;
    } else {
      var tempMax = double.minPositive;
      var tempMin = double.maxFinite;
      _max = p.fold(tempMax, (pre, e) {
        return max(pre, e.totalExpenses);
      });
      _min = p.fold(tempMin, (pre, e) {
        return min(pre, e.totalExpenses);
      });
    }
  }

  double getItemSpacing(double width) => width / _months.length;

  double _getXByIndex(double width, int index) {
    var itemSpacing = getItemSpacing(width);
    return itemSpacing * index + itemSpacing / 2.0;
  }

  double _getYByValue(double height, value) {
    if (_max == -1.0 || _min == -1.0) {
      return 0.0;
    } else if (_max == _min) {
      return (height - 40.0) / 2.0;
    } else {
      var drawingHeight = height - 40.0;
      var availableDrawingHeight = drawingHeight * 0.4;
      return drawingHeight -
          (drawingHeight * 0.3) -
          (availableDrawingHeight / (_max - _min)) * (value - _min);
    }
  }

  void _drawCurveLine(Canvas canvas, Size size) {
    if (_points.isEmpty) return;

    _curvePath.reset();
    double preX;
    double preY;
    double curX;
    double curY;
    var firstPoint = _points[0];
    curX = _getXByIndex(size.width, firstPoint.monthIndex);
    curY = _getYByValue(size.height, firstPoint.totalExpenses);
    _curvePath.moveTo(curX, curY);
    for (var p in _points) {
      preX = curX;
      preY = curY;
      curX = _getXByIndex(size.width, p.monthIndex);
      curY = _getYByValue(size.height, p.totalExpenses);
      double cpx = preX + (curX - preX) / 2.0;
      _curvePath.cubicTo(cpx, preY, cpx, curY, curX, curY);
    }

    canvas.drawPath(_curvePath, _linePaint);
  }

  void _drawDotsAndTips(Canvas canvas, Size size) {
    if (_points.isEmpty) return;

    var triangleHeight = 5.0;
    var triangleWidth = 10.0;
    var triangleDotMargin = 6.0;
    var rectRadius = 5.0;

    for (var i = 0; i < _points.length; i++) {
      var item = _points[i];
      var valueIndex = item.monthIndex;
      var x = _getXByIndex(size.width, valueIndex);
      var y = _getYByValue(size.height, item.totalExpenses);

      if (valueIndex == _selectedIndex) {
        canvas.drawCircle(Offset(x, y), SELECTED_DOT_RADIUS, _dotPaint);
      } else {
        canvas.drawCircle(Offset(x, y), DOT_RADIUS, _dotPaint);
      }

      if (_values == null) continue;
      var v = _values[i];

      if (valueIndex == _selectedIndex) {
        TextPainter tp = _createTextPainter(v, accentColor);
        tp.layout();
        var valueWidth = tp.width;
        var valueHeight = tp.height;

        _trianglePath.reset();
        _trianglePath.moveTo(
            x, y - triangleDotMargin - SELECTED_DOT_RADIUS / 2.0);
        _trianglePath.lineTo(x - triangleWidth / 2.0,
            y - triangleDotMargin - triangleHeight - SELECTED_DOT_RADIUS / 2.0);
        _trianglePath.lineTo(x + triangleWidth / 2.0,
            y - triangleDotMargin - triangleHeight - SELECTED_DOT_RADIUS / 2.0);

        var rectWidth = valueWidth + 6 * 2.0;
        var rectHeight = valueHeight + 6 * 2.0;

        var l = x - rectWidth / 2.0;
        var r = l + rectWidth;
        var b =
            y - triangleDotMargin - triangleHeight - SELECTED_DOT_RADIUS / 2.0;
        var t = b - rectHeight;
        var rr = RRect.fromLTRBR(l, t, r, b, Radius.circular(rectRadius));
        _trianglePath.addRRect(rr);
        canvas.drawPath(_trianglePath, _valueTipsPaint);

        tp.paint(
            canvas,
            Offset(rr.center.dx - valueWidth / 2.0,
                rr.center.dy - valueHeight / 2.0));
      } else {
        TextPainter tp = _createTextPainter(v, Color(0xff323232));
        tp.layout();
        var valueWidth = tp.width;

        tp.paint(
            canvas,
            Offset(x - valueWidth / 2.0,
                y - triangleDotMargin - DOT_RADIUS / 2.0 - tp.height));
      }
    }
  }

  void _drawMonths(Canvas canvas, Size size) {
    if (_months == null || _months.isEmpty) return;

    for (var i = 0; i < _months.length; i++) {
      var item = _months[i];
      var month = item.displayMonth;
      var tp = _createTextPainter(month, Color(0xff323232));
      tp.layout();
      var x = _getXByIndex(size.width, i) - tp.width / 2.0;
      var y = size.height - tp.height;
      tp.paint(canvas, Offset(x, y));
    }
  }

  TextPainter _createTextPainter(String text, Color textColor) {
    var ts = TextSpan(
        style: TextStyle(fontSize: 14.0, color: textColor), text: text);
    return TextPainter(text: ts, textDirection: TextDirection.ltr);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawCurveLine(canvas, size);
    _drawDotsAndTips(canvas, size);
    _drawMonths(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Tuple2<int, DateTime> selectMonth(
      double height, double itemSpacing, int index, double x, double y) {
    var item = _points.firstWhere((e) {
      return e.monthIndex == index;
    });

    var valueX = index * itemSpacing + itemSpacing / 2.0;
    if ((x - valueX).abs() <= TOUCH_RADIUS / 2.0 &&
        (y - _getYByValue(height, item.totalExpenses).abs() <=
            TOUCH_RADIUS / 2.0)) {
      var month = _months[index];
      return Tuple2(index, month.monthDateTime);
    }

    return null;
  }
}
