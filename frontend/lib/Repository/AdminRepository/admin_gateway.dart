
import '../../DataModels/group_data.dart';
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

  Future<bool> deleteGroup(int id) {
    final Future<bool> response = restRepository.deleteGroup(id);
    return response;
  }

  Future<GroupData> createGroup(String name) {
    final Future<GroupData> response = restRepository.createGroup(name);
    return response;
  }
}
