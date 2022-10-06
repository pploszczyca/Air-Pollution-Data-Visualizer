
import 'dart:async';

import 'package:adpv_frontend/DataModels/group_data.dart';

import '../../DataModels/group_endpoints.dart';
import '../../DataModels/group_summary.dart';
import 'groups_repository.dart';

class AdminGateway {
  final GroupsRepository restRepository = GroupsRepository();

  AdminGateway();

  Future<List<GroupSummary>> getGroupsSummary() {
    final Future<List<GroupSummary>> summary =
        restRepository.getGroupsSummary();
    return summary;
  }

  Future<GroupData> getGroupData(int groupId) => restRepository.getGroupData(groupId);

  Future<bool> deleteGroup(int id) => restRepository.deleteGroup(id);

  Future<GroupSummary> createGroup(String name) =>
      restRepository.createGroup(name);

  Future<GroupEndpointsData> getEndpointsForGroup(int groupId) =>
      restRepository.getEndpointsForGroup(groupId);

  Future<bool> deleteMember(int memberId, int groupId) => restRepository.deleteMember(memberId, groupId);
}
