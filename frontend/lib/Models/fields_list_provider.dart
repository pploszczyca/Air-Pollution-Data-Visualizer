import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:flutter/material.dart';

import 'all_users_list_provider.dart';

//ignore_for_file:  constant_identifier_names

const ARROW_UP = Icons.keyboard_arrow_up_rounded;
const ARROW_DOWN =Icons.keyboard_arrow_down_rounded;

class FieldsListProvider with ChangeNotifier {
  List<MemberInfo> membersList = [];
  Color nameColor = Colors.black;
  Color idColor = Colors.pink;
  IconData nameIcon = ARROW_DOWN;
  IconData idIcon = ARROW_UP;

  Sorting currentSorting = Sorting();

  FieldsListProvider();

  void makeFields(GroupData groupData) {
    for (var e in groupData.members) {
      membersList.add(MemberInfo(e.id, e.email, e.userRoles, e.otherGroups));
    }
    _sortByIDAsc();
    notifyListeners();
  }

  void delete(int id) {
    membersList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void _sortByIDAsc() {
    membersList.sort((a, b) => a.id.compareTo(b.id));
  }

  void _sortByIDDesc() {
    membersList.sort((b, a) => a.id.compareTo(b.id));
  }

  void _sortByEmailAsc() {
    membersList.sort((a, b) => a.email.compareTo(b.email));
  }

  void _sortByEmailDesc() {
    membersList.sort((b, a) => a.email.compareTo(b.email));
  }

  SortingOrder _reverseSortingOrder() =>
      currentSorting.order == SortingOrder.asc
          ? SortingOrder.desc
          : SortingOrder.asc;

  void _setSortingById(){
    if (currentSorting.field == SortingField.id) {
      currentSorting.order = _reverseSortingOrder();
      idIcon = (idIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.id;
      currentSorting.order = SortingOrder.asc;
      idColor = Colors.pink;
      nameColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc
        ? _sortByIDAsc()
        : _sortByIDDesc();
  }

  void _setSortingByEmail(){
    if (currentSorting.field == SortingField.email) {
      currentSorting.order = _reverseSortingOrder();
      nameIcon = (nameIcon == ARROW_UP) ? ARROW_DOWN : ARROW_UP;
    } else {
      currentSorting.field = SortingField.email;
      currentSorting.order = SortingOrder.asc;
      nameColor = Colors.pink;
      idColor = Colors.black;
    }
    currentSorting.order == SortingOrder.asc
        ? _sortByEmailAsc()
        : _sortByEmailDesc();
  }

  void changeSorting(int index) {
    if (index == ID_SORTING_BUTTON_INDEX) {
      _setSortingById();
    } else if (index == EMAIL_SORTING_BUTTON_INDEX) {
      _setSortingByEmail();
    }
    notifyListeners();
  }
}
