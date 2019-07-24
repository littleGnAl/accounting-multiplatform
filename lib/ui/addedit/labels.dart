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
