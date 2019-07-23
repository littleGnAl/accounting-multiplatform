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

import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_bloc.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/ui/summary/summary_chart_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SummaryChart extends StatelessWidget {
  final SummaryChartData _summaryChartData;

  const SummaryChart({Key key, @required SummaryChartData summaryChartData})
      : this._summaryChartData = summaryChartData,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final summaryBloc = BlocProvider.of<SummaryBloc>(context);

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

        summaryBloc.switchMonth(t.item1, t.item2);
      },
    );
  }
}
