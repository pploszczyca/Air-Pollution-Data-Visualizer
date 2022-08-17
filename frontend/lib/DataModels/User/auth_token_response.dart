class AuthTokenResponse {
  String accessToken;
  String refreshToken;

  AuthTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  AuthTokenResponse.empty()
      : accessToken = '',
        refreshToken = '';
}
