import 'package:flutter/material.dart';

import '../../DataModels/Utils/sorting_model.dart';

Container buildSortBar(
  SortingModel sortingModel,
  VoidCallback notify,
  List<dynamic> list,
  List<dynamic> getters,
) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          ToggleButtons(
            isSelected: sortingModel.selections,
            fillColor: Colors.transparent,
            renderBorder: false,
            children: [
              _buildToggleButton(
                sortingModel.idText,
                sortingModel.icons[0],
                sortingModel.colors[0],
              ),
              _buildToggleButton(
                sortingModel.nameText,
                sortingModel.icons[1],
                sortingModel.colors[1],
              ),
            ],
            onPressed: (int index) {
              sortingModel.changeSorting(index, list, getters, () => notify);
              notify();
            },
          )
        ],
      ),
    );

Container _buildToggleButton(String buttonName, IconData icon, Color color) =>
    Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: buttonName,
              style: TextStyle(
                fontFamily: 'SofiaSans',
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: color,
              ),
            ),
            WidgetSpan(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
