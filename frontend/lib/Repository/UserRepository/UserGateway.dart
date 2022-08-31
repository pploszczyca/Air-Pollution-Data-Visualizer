import 'package:adpv_frontend/DataModels/User/auth_token_response.dart';
import 'package:adpv_frontend/DataModels/User/user.dart';
import 'package:adpv_frontend/Repository/UserRepository/AuthGateway.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../Views/Logging/utils.dart';

const accessKey = 'access';
const refreshKey = 'refresh';

class UserGateway {
  AuthGetaway authGetaway = AuthGetaway();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late User user;

  bool isAdmin() => user.userRoles.contains(UserRole.admin);

  void refreshToken() async {
    await authGetaway
        .refreshToken()
        .then((value) => user = User(value.tokens!));
  }

  Future<AuthResponse> getFromMemory() async {
    final String? access = await secureStorage.read(key: accessKey);
    final String? refresh = await secureStorage.read(key: refreshKey);

    if (access != null && refresh != null) {
      final AuthTokenResponse tokenResponse =
          AuthTokenResponse(accessToken: access, refreshToken: refresh);
      user = User(tokenResponse);
      return AuthResponse(success: true, tokens: tokenResponse);
    }
    return AuthResponse(
        success: false, errorMessage: "Cannot find tokens in secure storage");
  }

  Future<AuthResponse> authenticateUser(AuthenticateForm form) async {
    final AuthResponse response = await authGetaway.authenticateUser(form);
    user = response.success ? User(response.tokens!) : User.empty();
    await secureStorage.write(
        key: accessKey, value: response.tokens!.accessToken);
    await secureStorage.write(
        key: refreshKey, value: response.tokens!.refreshToken);
    return response;
  }
}
