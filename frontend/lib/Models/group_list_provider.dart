import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:flutter/material.dart';

import '../Repository/AdminRepository/admin_gateway.dart';

class GroupCard {
  String name;
  int id;
  Color titleColor;
  FontWeight titleFontWeight;
  Color membersButtonColor;
  Color endpointsButtonColor;

  GroupCard({
    required this.name,
    required this.id,
    this.titleColor = Colors.black,
    this.titleFontWeight = FontWeight.normal,
    this.membersButtonColor = Colors.black,
    this.endpointsButtonColor = Colors.black,
  });
}

class GroupListProvider with ChangeNotifier {
  List<GroupCard> groupsList = [];
  AdminGateway adminGateway;

  GroupListProvider(this.adminGateway);

  void addGroup(GroupSummary group) {
    groupsList.add(GroupCard(name: group.name, id: group.id));
  }

  void makeGroupList(List<GroupSummary> groupSummary) {
    groupsList = groupSummary
        .map((group) => GroupCard(name: group.name, id: group.id))
        .toList();
    notifyListeners();
  }

  void addNewGroup(GroupSummary group) {
    addGroup(group);
    notifyListeners();
  }

  void delete(int id) {
    groupsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clear() {
    groupsList = [];
    adminGateway.getGroupsSummary().then(makeGroupList);
  }
}
