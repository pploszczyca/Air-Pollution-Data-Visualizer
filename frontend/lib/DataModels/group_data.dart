import 'member_info.dart';

class GroupData {
  int id;
  String name;
  List<MemberInfo> members;

  GroupData(this.id, this.name, this.members);

  GroupData.fromJson(Map json)
      : id = json['groupId'],
        name = json['groupName'],
        members = List<MemberInfo>.from(
          //ignore: unnecessary_lambdas
          json['members'].map((member) => MemberInfo.fromJson(member)),
        );
//nie tykać bo i tak to cud że działą
}
