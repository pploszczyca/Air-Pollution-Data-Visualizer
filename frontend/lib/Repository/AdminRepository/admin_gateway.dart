import 'dart:async';

import 'package:adpv_frontend/DataModels/group_data.dart';

import '../../DataModels/group_endpoints.dart';
import '../../DataModels/group_summary.dart';
import '../../DataModels/user_summary.dart';
import 'admin_groups_repository.dart';

class AdminGateway {
  final AdminGroupsRepository restRepository = AdminGroupsRepository();

  AdminGateway();

  Future<List<GroupSummary>> getGroupsSummary() {
    final Future<List<GroupSummary>> summary =
        restRepository.getGroupsSummary();
    return summary;
  }

  Future<GroupData> getGroupData(int groupId) =>
      restRepository.getGroupData(groupId);

  Future<bool> deleteGroup(int id) => restRepository.deleteGroup(id);

  Future<GroupSummary> createGroup(String name) =>
      restRepository.createGroup(name);

  Future<GroupEndpointsData> getEndpointsForGroup(int groupId) =>
      restRepository.getEndpointsForGroup(groupId);

  Future<bool> deleteMember(int memberId, int groupId) =>
      restRepository.deleteMember(memberId, groupId);

  Future<List<UserSummary>> getMembersNotInGroup(int groupId) =>
      restRepository.getMembersNotInGroup(groupId);

  Future<bool> addMember(int userId, int groupId) =>
      restRepository.addMember(userId, groupId);
}
