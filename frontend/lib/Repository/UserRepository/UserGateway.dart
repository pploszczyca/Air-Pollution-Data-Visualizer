import 'package:adpv_frontend/DataModels/User/user.dart';
import 'package:adpv_frontend/DataModels/User/user_role.dart';
import 'package:adpv_frontend/Repository/UserRepository/AuthGateway.dart';

import '../../Views/loginViewUtils.dart';

class UserGateway {
  AuthGetaway authGetaway = AuthGetaway();
  late User user;

  bool isAdmin() => user.userRole.contains(UserRole.admin);

  void refreshToken() {
    authGetaway
        .refreshToken()
        .then((value) => user.tokenResponse = value.tokens!);
  }

  Future<AuthResponse> authenticateUser(AuthenticateForm form) async {
    final AuthResponse response = await authGetaway.authenticateUser(form);
    if (response.success) {
      user = User(response.tokens!);
    } else {
      user = User.empty();
    }
    return response;
  }
}
