import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:dio/dio.dart';

import '../../Common/URLs.dart';
import '../../DataModels/BackendResponse.dart';

class GroupsRepository {
  final Dio _client = Dio();
  String token = 'todo: function obtaining token';

  Future<List<GroupSummary>> getGroupsSummary() async {
    _client.options.headers["Authorization"] = "Bearer $token";

    try {
      final response = await _client.get(backendURL + getGroupSummaryURL, );
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
    return Future.value([]);
  }
}
