import 'package:adpv_frontend/DataModels/field_data.dart';
import 'package:adpv_frontend/Repository/rest_client.dart';
import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/backend_response.dart';
import '../UserRepository/user_gateway.dart';

class FieldsRepository {
  final RestClient _client = RestClient();
  UserGateway userGateway = UserGateway();

  FieldsRepository();

  Future<List<FieldData>> getFieldList() async {
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
    return Future.value([]);
  }

  Future<bool> deleteField(int id) async {
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
    return Future.value(false);
  }
}
