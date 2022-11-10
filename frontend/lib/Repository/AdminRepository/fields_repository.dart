import 'package:adpv_frontend/DataModels/field_data.dart';
import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/backend_response.dart';
import '../UserRepository/auth_gateway.dart';
import '../UserRepository/user_gateway.dart';

class FieldsRepository {
  final Dio _client = Dio();
  UserGateway userGateway = UserGateway();

  FieldsRepository();

  Future<List<FieldData>> getFieldList() async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response = await _client.get(
          backendURL + fieldURL,
        );
        if (response.statusCode == 200) {
          final BackendResponse backendResponse =
              BackendResponse.fromJson(response.data);
          if (backendResponse.error == "") {
            final List<FieldData> fieldsList = backendResponse.data
                .map<FieldData>(
                  // ignore: unnecessary_lambdas
                  (e) => FieldData.fromJson(e),
                ) // do not refactor! UFO MAGIC!
                .toList();
            return Future.value(fieldsList);
          }
        }
      } on DioError catch (error) {
        return Future.error(error);
      }
    }
    return Future.value([]);
  }

  Future<bool> deleteField(int id) async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response = await _client.delete(
          backendURL + fieldURL,
          queryParameters: {'fieldId': id.toString()},
        );
        if (response.statusCode == 200) {
          return Future.value(true);
        }
      } catch (error) {
        return Future.error(error);
      }
    }
    return Future.value(false);
  }
}
