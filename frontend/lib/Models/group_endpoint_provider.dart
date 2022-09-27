import 'package:adpv_frontend/DataModels/group_endpoints.dart';
import 'package:flutter/material.dart';

import '../Repository/AdminRepository/groups_repository.dart';

class GroupEndpointProvider with ChangeNotifier {
  GroupEndpointsData groupEndpointsData = GroupEndpointsData.empty();
  GroupsRepository repository = GroupsRepository();

  GroupEndpointProvider(Future<GroupEndpointsData> future) {
    init(future);
  }

  void init(Future<GroupEndpointsData> future) {
    future.then((value) {
      groupEndpointsData = value;
      groupEndpointsData.sortFields();
      notifyListeners();
    });
  }

  void updateEndpointState(
    bool? value,
    String endpointLabel,
  ) {
    if (value != null) {
      groupEndpointsData.endpoints[endpointLabel]!.isBelongingToGroup = value;
    }
    notifyListeners();
  }

  void updateFieldState(
    bool? value,
    String endpointLabel,
    String fieldLabel,
  ) {
    if (value != null) {
      groupEndpointsData.endpoints[endpointLabel]!.fields[fieldLabel]!
          .isBelongingToGroup = value;
    }
    notifyListeners();
  }

  Future<GroupEndpointsData> save() =>
      repository.updateGroupEndpoints(groupEndpointsData).then((value) async {
        if (value == true) {
          groupEndpointsData =
              await repository.getEndpointsForGroup(groupEndpointsData.groupId);
          groupEndpointsData.sortFields();
          notifyListeners();
        }
        return groupEndpointsData;
      });
}
