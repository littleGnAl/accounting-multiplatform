import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Labels extends StatefulWidget {
  const Labels(
      {Key key, @required this.onCheckedChanged, Stream<String> selectedLabel})
      : this._selectedLabel = selectedLabel,
        super(key: key);

  final ValueChanged<String> onCheckedChanged;

  final Stream<String> _selectedLabel;

  @override
  State<StatefulWidget> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  final List<String> _labelStrings = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Nightingale",
    "Travelling",
    "Afternoon Tea",
    "Recharge",
    "Buy Women's Clothes"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 6.0,
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: _getLabelWidgets(),
      ),
    );
  }

  List<Widget> _getLabelWidgets() {
    return _labelStrings.map((String s) {
      return GestureDetector(
        child: StreamBuilder(
          stream: widget._selectedLabel,
          builder: (context, snapshot) {
            bool isSelected = s == snapshot.data;
            return Chip(
              label: Text(
                s,
                style: TextStyle(
                    fontSize: 16.0,
                    color: isSelected ? Color(0xffffffff) : Color(0xff323232)),
              ),
              labelPadding: EdgeInsets.only(left: 8.0, right: 8.0),
              backgroundColor:
                  isSelected ? Color(0xffff4081) : Color(0xffebebeb),
            );
          },
        ),
        onTap: () {
          widget.onCheckedChanged(s);
        },
      );
    }).toList();
  }
}
