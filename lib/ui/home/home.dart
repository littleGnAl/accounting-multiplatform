import 'package:accountingmultiplatform/blocs/accounting_bloc.dart';
import 'package:accountingmultiplatform/blocs/bloc_provider.dart';
import 'package:accountingmultiplatform/data/accounting.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../colors.dart';
import 'home_list_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AccountingBloc _accountingBloc;

  ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    _accountingBloc = BlocProvider.of<AccountingBloc>(context);
    _accountingBloc.refreshAccountingList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _accountingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accounting"),
        actions: <Widget>[_getSummaryIconBtn()],
      ),
      body: StreamBuilder<BuiltList<HomeListViewItem>>(
          stream: _accountingBloc.accountings,
          builder: (BuildContext context,
              AsyncSnapshot<BuiltList<HomeListViewItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final s = snapshot.data[index];
                      if (s is HomeListViewHeader) {
                        return _createListHeaderItem(s);
                      } else if (s is HomeListViewContent) {
                        final Accounting a = s.accounting;
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              child: _createListContentItem(s),
                              onTap: () {
                                _navigateToAddEditPage(id: a.id);
                              },
                            ),
                            Divider(
                              height: 1.0,
                            )
                          ],
                        );
                      }
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Center(
                child: Text("No Data"),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddEditPage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createListHeaderItem(HomeListViewHeader h) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      child: Row(
        children: <Widget>[
          Text(h.displayDate),
          Expanded(
            child: Align(
              child: Text(h.displayTotal),
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
    );
  }

  Widget _createListContentItem(HomeListViewContent c) {
    return Dismissible(
      key: ObjectKey(c),
      direction: DismissDirection.endToStart,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(c.displayTime),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(c.displayLabel),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(c.displayRemark),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                child: Text(c.displayExpense),
                alignment: Alignment.topRight,
              ),
            )
          ],
        ),
      ),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(right: 16),
        child: Align(
          child: Text(
            "DELETE",
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.centerRight,
        ),
      ),
      onDismissed: (direction) {
        _accountingBloc.delete(c.accounting.id);
      },
    );
  }

  _navigateToAddEditPage({int id = 0}) {
    Navigator.pushNamed(context, "add_edit", arguments: id);
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_scrollController.position.extentAfter == 0) {
        _accountingBloc.loadNextPage();
      }
    }
    return false;
  }

  Widget _getSummaryIconBtn() {
    return StreamBuilder(
      stream: _accountingBloc.accountings,
      builder: (BuildContext context,
          AsyncSnapshot<BuiltList<HomeListViewItem>> snapshot) {
        var isBtnEnable = snapshot.hasData && snapshot.data.isNotEmpty;

        return IconButton(
          disabledColor: unableColor,
          icon: Icon(Icons.show_chart),
          onPressed: isBtnEnable
              ? () {
                  Navigator.pushNamed(context, "summary");
                }
              : null,
        );
      },
    );
  }
}
