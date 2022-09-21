import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:flutter/material.dart';

import '../DataModels/User/user.dart';

class MemberInfo {
  MemberSummary memberSummary;
  List<UserRole> userRoles = [];
  List<String> otherGroups = [];

  MemberInfo(this.memberSummary);
}

class MembersListProvider with ChangeNotifier {
  List<MemberInfo> membersList = [];
  int groupId;

  MembersListProvider(this.groupId);

  void makeMemberList(GroupData groupData) {
    membersList = groupData.members.map(MemberInfo.new).toList();
    sortByID();
    notifyListeners();
  }

  void delete(int id) {
    membersList.removeWhere((element) => element.memberSummary.id == id);
    notifyListeners();
  }

  void sortByID() {
    membersList
        .sort((a, b) => a.memberSummary.id.compareTo(b.memberSummary.id));
    notifyListeners();
  }

  void sortByEmail() {
    membersList
        .sort((a, b) => a.memberSummary.email.compareTo(b.memberSummary.email));
    notifyListeners();
  }
}
