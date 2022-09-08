
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

  Future<bool> deleteGroup(int id) => restRepository.deleteGroup(id);

  Future<GroupSummary> createGroup(String name) => restRepository.createGroup(name);
}
