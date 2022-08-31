import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:adpv_frontend/Repository/UserRepository/AuthGateway.dart';
import 'package:adpv_frontend/Repository/UserRepository/UserGateway.dart';
import 'package:dio/dio.dart';

import '../../Common/URLs.dart';
import '../../DataModels/BackendResponse.dart';

class GroupsRepository {
  final Dio _client = Dio();
  UserGateway userGateway = UserGateway();

  Future<List<GroupSummary>> getGroupsSummary() async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response = await _client.get(
          backendURL + getGroupSummaryURL,
        );
        if (response.statusCode == 200) {
          final BackendResponse backendResponse =
              BackendResponse.fromJson(response.data);
          if (backendResponse.error == "") {
            List<GroupSummary> groupSummaryList = [];
            groupSummaryList = backendResponse.data
                .map<GroupSummary>((e) =>
                    GroupSummary.fromJson(e)) // do not refactor! UFO MAGIC!
                .toList();
            return Future.value(groupSummaryList);
          }
        }
      } on DioError catch (error) {}
    }
    return Future.value([]);
  }
}
