import 'package:adpv_frontend/Views/loginViewUtils.dart';
import 'package:dio/dio.dart';

import '../../Common/URLs.dart';

class AuthTokenResponse {
  String accessToken;
  String refreshToken;

  AuthTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });
}

class AuthResponse {
  bool success;
  AuthTokenResponse? tokens;
  String? errorMessage;

  AuthResponse({required this.success, this.tokens, this.errorMessage});
}

class AuthGetaway {
  final Dio _client = Dio();

  Future<AuthResponse> authenticateUser(AuthenticateForm form) async {
    final String URL =
        (form.formType == AuthFormType.signin) ? authLoginURL : authRegisterURL;
    try {
      final response = await _client.post(backendURL + URL,
          data: {'email': form.email, 'password': form.password});
      final tokens = AuthTokenResponse(
          accessToken: response.data['data']['accessToken'],
          refreshToken: response.data['data']['refreshToken']);
      //todo: save tokens in lib
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
