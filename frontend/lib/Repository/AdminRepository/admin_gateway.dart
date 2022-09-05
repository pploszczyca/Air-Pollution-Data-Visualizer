import 'package:adpv_frontend/DataModels/group_summary.dart';
import 'package:adpv_frontend/Repository/AdminRepository/groups_repository.dart';

class AdminGateway {
  final GroupsRepository restRepository = GroupsRepository();

  AdminGateway();

  Future<List<GroupSummary>> getGroupsSummary() {
    final Future<List<GroupSummary>> summary =
        restRepository.getGroupsSummary();
    return summary;
  }
}
