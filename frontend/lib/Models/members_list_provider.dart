import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:flutter/material.dart';

enum SortingField { id, mail }

enum SortingOrder { asc, desc }

class Sorting {
  SortingField field = SortingField.id;
  SortingOrder order = SortingOrder.asc;
}

class MembersListProvider with ChangeNotifier {
  List<MemberInfo> membersList = [];
  int groupId;
  Color emailColor = Colors.black;
  Color idColor = Colors.pink;
  Sorting currentSorting = Sorting();

  MembersListProvider(this.groupId);

  void makeMemberList(GroupData groupData) {
    for (var e in groupData.members) {
      membersList.add(MemberInfo(e.id, e.email, e.userRoles, e.otherGroups));
    }
    sortByIDAsc();
    notifyListeners();
  }

  void delete(int id) {
    membersList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void sortByIDAsc() {
    membersList.sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  void sortByIDDesc() {
    membersList.sort((b, a) => a.id.compareTo(b.id));
    notifyListeners();
  }

  void sortByEmailAsc() {
    membersList.sort((a, b) => a.email.compareTo(b.email));
    notifyListeners();
  }

  void sortByEmailDesc() {
    membersList.sort((b, a) => a.email.compareTo(b.email));
    notifyListeners();
  }

  void changeEmailColor() {
    emailColor = emailColor == Colors.black ? Colors.pink : Colors.black;
  }

  void changeSorting(int index) {
    if (index == 0) {
      if (currentSorting.field == SortingField.id) {
        currentSorting.order = currentSorting.order == SortingOrder.asc
            ? SortingOrder.desc
            : SortingOrder.asc;
      } else {
        currentSorting.field = SortingField.id;
        currentSorting.order = SortingOrder.asc;
        idColor = Colors.pink;
        emailColor = Colors.black;
      }
      currentSorting.order == SortingOrder.asc ? sortByIDAsc() : sortByIDDesc();
    } else if (index == 1) {
      if (currentSorting.field == SortingField.mail) {
        currentSorting.order = currentSorting.order == SortingOrder.asc
            ? SortingOrder.desc
            : SortingOrder.asc;
      } else {
        currentSorting.field = SortingField.mail;
        currentSorting.order = SortingOrder.asc;
        emailColor = Colors.pink;
        idColor = Colors.black;
      }
      currentSorting.order == SortingOrder.asc
          ? sortByEmailAsc()
          : sortByEmailDesc();
    }
    notifyListeners();
  }
}
