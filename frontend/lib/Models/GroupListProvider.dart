import 'dart:ui';

import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:flutter/material.dart';

import '../Repository/AdminRepository/AdminGateway.dart';

class GroupCard {
  String name;
  int id;
  Color titleColor;
  Color membersButtonColor;
  Color endpointsButtonColor;

  GroupCard({required this.name,
    required this.id,
    this.titleColor = Colors.black,
    this.membersButtonColor = Colors.black,
    this.endpointsButtonColor = Colors.black});
}

class GroupListProvider with ChangeNotifier {
  List<GroupCard> groupsList = [];
  AdminGateway adminGateway;

  GroupListProvider(List<GroupSummary> list, this.adminGateway) {
    makeGroupList(list);
  }

  void makeGroupList(List<GroupSummary> groupSummary) {
    groupsList = groupSummary
        .map((group) => GroupCard(name: group.name, id: group.id))
        .toList();
  }
}