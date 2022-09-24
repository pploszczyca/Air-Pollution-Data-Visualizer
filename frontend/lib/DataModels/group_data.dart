import 'package:adpv_frontend/DataModels/group_summary.dart';

import 'member_summary.dart';

class GroupData{
  GroupSummary basicInfo;
  List<MemberInfo> members;

  GroupData(this.basicInfo, this.members);

  GroupData.fromJson(Map json)
      : basicInfo = GroupSummary(json["id"], json["name"]),
  members = [];


}