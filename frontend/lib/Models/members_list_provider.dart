import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:flutter/material.dart';

import '../DataModels/User/user.dart';

class MembersListProvider with ChangeNotifier {
  List<MemberInfo> membersList = [];
  int groupId;

  MembersListProvider(this.groupId);

  void makeMemberList(GroupData groupData) {
    for (var e in groupData.members) {
      membersList.add(MemberInfo(e.id, e.email, e.userRoles, e.otherGroups));
    }
    sortByID();
    notifyListeners();
  }

  void delete(int id) {
    membersList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void sortByID() {
    membersList
        .sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  void sortByEmail() {
    membersList
        .sort((a, b) => a.email.compareTo(b.email));
    notifyListeners();
  }
}
