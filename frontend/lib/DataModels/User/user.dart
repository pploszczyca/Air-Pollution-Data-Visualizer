import 'package:adpv_frontend/DataModels/User/auth_token_response.dart';
import 'package:adpv_frontend/DataModels/User/user_role.dart';
import 'package:jwt_decode/jwt_decode.dart';

class User {
  late AuthTokenResponse tokenResponse;
  late String email;
  List<UserRole> userRole = [];

  User(this.tokenResponse) {
    final Map<String, dynamic> parsed = Jwt.parseJwt(tokenResponse.accessToken);
    email = parsed['sub'];
    for (var element in (parsed['roles'] as List)) {
      userRole.add(UserRoleExtension.userRole(element));
    }
  }

  User.empty()
      : tokenResponse = AuthTokenResponse.empty(),
        email = '';

  @override
  String toString() => 'User{email: $email, userRole: ${userRole.toString()}';
}
