import 'package:adpv_frontend/DataModels/Endpoint.dart';
import 'package:adpv_frontend/DataModels/user_summary.dart';

class GroupData{
  final int id;
  final String name;
  List<UserSummary>? users;
  List<Endpoint>? groupEndpoints;

  GroupData(this.id, this.name, [this.users = const[], this.groupEndpoints = const[] ]);

  GroupData.fromJson(Map json)
      : id = json["id"],
        name = json["name"];
}