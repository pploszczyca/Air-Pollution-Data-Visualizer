import 'package:adpv_frontend/Repository/AdminRepository/admin_endpoints_repository.dart';
import 'package:flutter/material.dart';

//ignore_for_file:  constant_identifier_names
const ID_SORTING_BUTTON_INDEX = 0;
const EMAIL_SORTING_BUTTON_INDEX = 1;

enum SortingField { id, email }

enum SortingOrder { asc, desc }

class Sorting {
  SortingField field = SortingField.id;
  SortingOrder order = SortingOrder.asc;
}

const ARROW_UP = Icons.keyboard_arrow_up_rounded;
const ARROW_DOWN = Icons.keyboard_arrow_down_rounded;

class AllEndpointsProvider with ChangeNotifier {
  List<EndpointAdminData> endpointsList = [];
  Color labelColor = Colors.black;
  Color numberColor = Colors.pink;
  IconData labelIcon = ARROW_DOWN;
  IconData numberIcon = ARROW_UP;

  AdminEndpointsRepository repository = AdminEndpointsRepository();

  AllEndpointsProvider(Future<List<EndpointAdminData>> future) {
    future.then(init);
  }

  Sorting currentSorting = Sorting();

  void init(List<EndpointAdminData> list) {
    endpointsList = list;
    notifyListeners();
  }

  SortingOrder _reverseSortingOrder() =>
      currentSorting.order == SortingOrder.asc
          ? SortingOrder.desc
          : SortingOrder.asc;

  void changeSorting(int index) {
    if (index == ID_SORTING_BUTTON_INDEX) {
      _setSortingById();
    } else if (index == EMAIL_SORTING_BUTTON_INDEX) {
      _setSortingByEmail();
    }
    notifyListeners();
  }

  void _setSortingById() {
    if (currentSorting.field == SortingField.id) {
      currentSorting.order = _reverseSortingOrder();
      numberIcon = (numberIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.id;
      currentSorting.order = SortingOrder.asc;
      numberColor = Colors.pink;
      labelColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc ? _sortByNumberAsc() : _sortByNumberDesc();
  }

  void _setSortingByEmail() {
    if (currentSorting.field == SortingField.email) {
      currentSorting.order = _reverseSortingOrder();
      labelIcon = (labelIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.email;
      currentSorting.order = SortingOrder.asc;
      labelColor = Colors.pink;
      numberColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc
        ? _sortByLabelAsc()
        : _sortByLabelDesc();
  }

  void _sortByNumberAsc() {
    endpointsList.sort((a, b) => a.endpointNumber.compareTo(b.endpointNumber));
  }

  void _sortByNumberDesc() {
    endpointsList.sort((b, a) => a.endpointNumber.compareTo(b.endpointNumber));
  }

  void _sortByLabelAsc() {
    endpointsList.sort((a, b) => a.label.compareTo(b.label));
  }

  void _sortByLabelDesc() {
    endpointsList.sort((b, a) => a.label.compareTo(b.label));
  }
}
