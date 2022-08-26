import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/User/auth_token_response.dart';
import '../../Views/Logging/utils.dart';

class AuthResponse {
  bool success;
  AuthTokenResponse? tokens;
  String? errorMessage;

  AuthResponse({required this.success, this.tokens, this.errorMessage});
}

class AuthGetaway {
  final Dio _client = Dio();

  Future<AuthResponse> authenticateUser(AuthenticateForm form) async {
    final String url =
        (form.formType == AuthFormType.signin) ? authLoginURL : authRegisterURL;
    try {
      final response = await _client.post(backendURL + url,
          data: {'email': form.email, 'password': form.password});
      final tokens = AuthTokenResponse(
          accessToken: response.data['data']['accessToken'],
          refreshToken: response.data['data']['refreshToken']);

      return AuthResponse(success: true, tokens: tokens);
    } on DioError catch (error) {
      return AuthResponse(
          success: false, errorMessage: error.response?.data['error']);
    }
  }

  //for future use
  Future<AuthResponse> refreshToken() async {
    try {
      final response = await _client.post(backendURL + refreshTokenURL);
      return AuthResponse(
          success: true,
          tokens: AuthTokenResponse(
              accessToken: response.data['accessToken'],
              refreshToken: response.data['refreshToken']));
    } on DioError catch (error) {
      return AuthResponse(
          success: false, errorMessage: error.response?.data['error']);
    }
  }
}
