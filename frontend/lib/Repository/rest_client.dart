import 'package:adpv_frontend/Repository/UserRepository/auth_gateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:dio/dio.dart';

class RestClient {
  final Dio _client = Dio();
  final UserGateway _userGateway = UserGateway();

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) =>
      _performQuery(
            () => _client.get(
          path,
          queryParameters: queryParameters,
        ),
      );

  Future<Response<T>> delete<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) =>
      _performQuery(
            () => _client.delete(
          path,
          queryParameters: queryParameters,
        ),
      );

  Future<Response<T>> post<T>(
      String path,
      {
        Map<String, dynamic>? queryParameters,
        dynamic data,
      }) =>
      _performQuery(
            () => _client.post(
          path,
          queryParameters: queryParameters,
          data: data,
        ),
      );

  Future<Response<T>> put<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        dynamic data,
      }) =>
      _performQuery(
            () => _client.post(
          path,
          queryParameters: queryParameters,
          data: data,
        ),
      );

  Future<T> _performQuery<T>(Function requestMethod) async {
    final AuthResponse authResponse = await _userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["accept"] = "*/*";
      _client.options.headers["Authorization"] = "Bearer $token";
      try {
        return await requestMethod();
      } on DioError catch (error) {
        return Future.error(error);
      }
    }

    return Future.value(null);
  }
}
