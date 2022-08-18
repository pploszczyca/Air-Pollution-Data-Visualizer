import 'dart:ui';

import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:flutter/material.dart';

import '../Repository/AdminRepository/AdminGateway.dart';

class GroupCard {
  String name;
  int id;
  FontWeight titleFontweight;
  Color membersButtonColor;
  Color endpointsButtonColor;

  GroupCard(
      {required this.name,
      required this.id,
      this.titleFontweight = FontWeight.normal,
      this.membersButtonColor = Colors.black,
      this.endpointsButtonColor = Colors.black});
}

class GroupListProvider with ChangeNotifier {
  List<GroupCard> groupsList = [];
  AdminGateway adminGateway;

  GroupListProvider(List<GroupSummary> list, this.adminGateway) {
    makeGroupList(list);
  }

  void setGroup(GroupSummary group) {
    groupsList.add(GroupCard(name: group.name, id: group.id));
  }

  void makeGroupList(List<GroupSummary> groupSummary) {
    for (var element in groupSummary) {
      setGroup(element);
    }
  }
}
