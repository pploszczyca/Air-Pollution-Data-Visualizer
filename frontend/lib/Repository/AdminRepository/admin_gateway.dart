
import 'dart:async';

import 'package:adpv_frontend/DataModels/group_data.dart';

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

  Future<GroupData> getGroupData(int groupId){
    final Future<GroupData> groupData = restRepository.getGroupData(groupId);
    return groupData;
  }

  Future<bool> deleteGroup(int id) => restRepository.deleteGroup(id);

  Future<GroupSummary> createGroup(String name) => restRepository.createGroup(name);

  Future<bool> deleteMember(int memberId, int groupId) => restRepository.deleteMember(memberId, groupId);
}
