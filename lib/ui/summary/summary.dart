import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_bloc.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_chart_data.dart';
import 'package:accountingmultiplatform/blocs/summary/summary_list_item.dart';
import 'package:accountingmultiplatform/data/accounting_repository.dart';
import 'package:accountingmultiplatform/ui/summary/summary_chart.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class SummaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  SummaryBloc _summaryBloc;

  @override
  void didChangeDependencies() {
    _summaryBloc = SummaryBloc(AccountingRepository.db);
    _summaryBloc.initialize();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _summaryBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      body: BlocProvider<SummaryBloc>(
        bloc: _summaryBloc,
        child: Column(
          children: <Widget>[
            Divider(
              height: 1.0,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 10),
              child: StreamBuilder(
                stream: _summaryBloc.summaryChartData,
                builder: (BuildContext context,
                    AsyncSnapshot<SummaryChartData> snapshot) {
                  if (snapshot.hasData) {
                    return SummaryChart(summaryChartData: snapshot.data);
                  } else {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _summaryBloc.summaryList,
                builder: (BuildContext context,
                    AsyncSnapshot<BuiltList<SummaryListItem>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Container();
                  }

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = snapshot.data[index];

                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  Text(item.tagName),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        item.displayTotal,
                                        style: TextStyle(color: accentColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 1.0,
                            )
                          ],
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
