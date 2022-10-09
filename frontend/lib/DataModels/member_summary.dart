import 'User/user.dart';

class MemberInfo {
  int id;
  String email;
  List<UserRole> userRoles = [];
  List<String> otherGroups = [];

  MemberInfo(this.id, this.email, this.userRoles, this.otherGroups);

  MemberInfo.fromJson(Map json)
      : id = json["id"],
        email = json["email"],
        userRoles = List<UserRole>.from(
          json["roles"].map((role) => UserRole.admin.fromString(role)),
        ),
        otherGroups = List<String>.from(json["otherGroupNames"]);
}
