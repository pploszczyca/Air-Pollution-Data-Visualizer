import 'package:adpv_frontend/Common/consts.dart';
import 'package:adpv_frontend/DataModels/group_endpoints.dart';
import 'package:flutter/material.dart';

import '../Repository/AdminRepository/admin_groups_repository.dart';

class GroupEndpointProvider with ChangeNotifier {
  GroupEndpointsData groupEndpointsData = GroupEndpointsData.empty();
  AdminGroupsRepository repository = AdminGroupsRepository();

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
    int endpointId,
  ) {
    if (value != null) {
      groupEndpointsData.endpoints[endpointId]!.isBelongingToGroup = value;
      for (var element
          in groupEndpointsData.endpoints[endpointId]!.fields.values) {
        element.isBelongingToGroup = value;
      }
    }
    notifyListeners();
  }

  void updateFieldState(
    bool? value,
    int endpointId,
    int fieldId,
  ) {
    if (value != null) {
      groupEndpointsData
          .endpoints[endpointId]!.fields[fieldId]!.isBelongingToGroup = value;
    }
    updateEndpointAfterFieldChange(endpointId, fieldId);
    notifyListeners();
  }

  Future<GroupEndpointsData> save() =>
      repository.updateGroupEndpoints(groupEndpointsData).then((value) async {
        groupEndpointsData = value;
        groupEndpointsData.sortFields();
        notifyListeners();
        return groupEndpointsData;
      });

  void updateEndpointAfterFieldChange(int endpointId, int fieldId) {
    final List<Field> enabled =
        groupEndpointsData.endpoints[endpointId]!.fields.values
            .where(
              (element) =>
                  element.isBelongingToGroup == true &&
                  ![ignoreField, ignoreLabel, ignoreId].contains(element.label),
            )
            .toList();
    groupEndpointsData.endpoints[endpointId]!.isBelongingToGroup =
        enabled.isEmpty ? false : true;
  }
}
