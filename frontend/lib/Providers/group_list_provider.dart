import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:flutter/material.dart';

class GroupCard {
  String name;
  int id;

  GroupCard({
    required this.name,
    required this.id,
  });
}

class GroupListProvider with ChangeNotifier {
  List<GroupCard> groupsList = [];

  GroupListProvider();

  void makeGroupList(List<GroupSummary> groupSummary) {
    groupsList = groupSummary
        .map((group) => GroupCard(name: group.name, id: group.id))
        .toList();
    notifyListeners();
  }

  void addNewGroup(GroupSummary group) {
    groupsList.add(GroupCard(name: group.name, id: group.id));
    notifyListeners();
  }

  void delete(int id) {
    groupsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void notify(){
    notifyListeners();
  }
}
