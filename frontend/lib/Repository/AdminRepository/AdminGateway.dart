import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:adpv_frontend/Repository/AdminRepository/GroupsRepository.dart';

class AdminGateway {
  final GroupsRepository restRepository = GroupsRepository();

  AdminGateway();

  Future<List<GroupSummary>> getGroupsSummary() {
    final Future<List<GroupSummary>> summary =
        restRepository.getGroupsSummary();
    return summary;
  }



  void deleteGroup(int id) {
    final Future<bool> response = restRepository.deleteGroup(id);
  }

  void createGroup(String name) {
    final Future<bool> response = restRepository.createGroup(name);
  }
}
