import 'package:adpv_frontend/Common/urls.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:dio/dio.dart';

import '../../DataModels/backend_response.dart';
import '../UserRepository/auth_gateway.dart';

class EndpointAdminData {
  int id;
  int endpointNumber;
  String label;

  EndpointAdminData(this.id, this.endpointNumber, this.label);

  EndpointAdminData.fromJson(Map json)
      : id = json['id'],
        endpointNumber = json['endpointNumber'],
        label = json['label'];
}

class AdminEndpointsRepository {
  Dio _client = Dio();

  UserGateway userGateway = UserGateway();

  Future<List<EndpointAdminData>> getAllEndpoints() async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      final Response response =
          await _client.get(backendURL + "sensor/list/all");
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        return backendResponse.data
            //ignore: unnecessary_lambdas
            .map<EndpointAdminData>((endpoint) => EndpointAdminData.fromJson(endpoint))
            .toList();
      }
    }
    return Future.error("Cannot get all endpoints list");
  }
}
