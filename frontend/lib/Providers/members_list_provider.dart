import 'package:adpv_frontend/DataModels/Utils/sorting_model.dart';
import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_info.dart';
import 'package:flutter/material.dart';

class MembersListProvider with ChangeNotifier {
  List<MemberInfo> membersList = [];
  int groupId;
  SortingModel sortingModel = SortingModel("ID", "EMAIL");
  List getters = [(e) => e.id, (e) => e.email];

  Sorting currentSorting = Sorting();

  MembersListProvider(this.groupId);

  void makeMemberList(GroupData groupData) {
    membersList = [];
    for (var e in groupData.members) {
      membersList.add(MemberInfo(e.id, e.email, e.userRoles, e.otherGroups));
    }
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  void delete(int id) {
    membersList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
