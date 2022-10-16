import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/backend_response.dart';
import '../../DataModels/group_endpoints.dart';
import '../../DataModels/group_summary.dart';
import '../UserRepository/auth_gateway.dart';
import '../UserRepository/user_gateway.dart';

class FieldsRepository {
  final Dio _client = Dio();
  UserGateway userGateway = UserGateway();

  FieldsRepository();

  Future<List<GroupSummary>> getFieldsSummary() async {
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
            List<FieldData> groupSummaryList = [];
            groupSummaryList = backendResponse.data
                .map<GroupSummary>(
              // ignore: unnecessary_lambdas
                  (e) => GroupSummary.fromJson(e),
            ) // do not refactor! UFO MAGIC!
                .toList();
            return Future.value(groupSummaryList);
          }
        }
      } on DioError catch (error) {
        return Future.error(error);
      }
    }
    return Future.value([]);
  }


}
