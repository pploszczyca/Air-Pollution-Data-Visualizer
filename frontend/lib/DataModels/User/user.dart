import 'package:adpv_frontend/DataModels/User/auth_token_response.dart';
import 'package:jwt_decode/jwt_decode.dart';

enum UserRole {
  user,
  admin,
  empty,
}

extension UserRoleExtension on UserRole {
  UserRole fromString(String roleString) {
    switch (roleString) {
      case "USER":
        return UserRole.user;
      case "ADMIN":
        return UserRole.admin;
    }
    return UserRole.empty;
  }

  String toShortString() => toString().split('.').last;
}

class User {
  late AuthTokenResponse tokenResponse;
  late String email;
  List<UserRole> userRoles = [];

  User(this.tokenResponse) {
    final Map<String, dynamic> parsed = Jwt.parseJwt(tokenResponse.accessToken);
    email = parsed['sub'];
    for (var element in (parsed['roles'] as List)) {
      userRoles.add(UserRole.user.fromString(element));
    }
  }

  User.empty()
      : tokenResponse = AuthTokenResponse.empty(),
        email = '';

  @override
  String toString() => 'User{email: $email, userRole: ${userRoles.toString()}';
}
