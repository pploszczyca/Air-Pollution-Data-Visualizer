import 'package:flutter/material.dart';

enum SortingOrder { asc, desc }

class Sorting {
  int sortingField = 0;
  SortingOrder order = SortingOrder.asc;
}

const arrowUp = Icons.keyboard_arrow_up_rounded;
const arrowDown = Icons.keyboard_arrow_down_rounded;

class SortingModel {
  List<Color> colors = [Colors.pink, Colors.black];
  List<IconData> icons = [arrowUp, arrowDown];
  String nameText;
  String idText;
  Sorting currentSorting = Sorting();
  List<bool> selections = [true, false];

  SortingModel(this.idText, this.nameText);

  void _sortByAsc(List list, dynamic getter) {
    list.sort((a, b) => getter(a).compareTo(getter(b)));
  }

  void _sortByDesc(List list, dynamic getter) {
    list.sort((b, a) => getter(a).compareTo(getter(b)));
  }

  SortingOrder _reverseSortingOrder() =>
      currentSorting.order == SortingOrder.asc
          ? SortingOrder.desc
          : SortingOrder.asc;

  void changeSorting(
    int sortBy,
    List<dynamic> list,
    List<dynamic> getters,
    VoidCallback notify,
  ) {
    _setSortingBy(sortBy, list, getters[sortBy]);
    notify();
  }

  void _setSortingBy(int sortBy, List list, dynamic getter) {
    if (currentSorting.sortingField == sortBy) {
      currentSorting.order = _reverseSortingOrder();
      icons[sortBy] = (icons[sortBy] == arrowUp) ? arrowDown : arrowUp;
    } else {
      currentSorting.sortingField = sortBy;
      currentSorting.order = SortingOrder.asc;
      for (int i = 0; i < colors.length; i++) {
        colors[i] = Colors.black;
      }
      colors[sortBy] = Colors.pink;
    }
    currentSorting.order == SortingOrder.asc
        ? _sortByAsc(list, getter)
        : _sortByDesc(list, getter);
  }
}
