import 'package:adpv_frontend/DataModels/GroupSummary.dart';
import 'package:dio/dio.dart';

import '../../Common/URLs.dart';
import '../../DataModels/BackendResponse.dart';

class GroupsRepository {
  final Dio _client = Dio();
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkB0ZXN0LmNvbSIsInJvbGVzIjpbIlVTRVIiLCJBRE1JTiJdLCJpZCI6MSwiZXhwIjoxNjYwODgzODk5fQ.1h0O3CbxQnnJIhIm6b_HHWlAnV0tAsJ8lcFh03Q0XkA";

  Future<List<GroupSummary>> getGroupsSummary() async {
    _client.options.headers["Authorization"] = "Bearer $token";
    try {
      final response = await _client.get(backendURL + getGroupSummaryURL);
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
    } on DioError catch (error) {
      print(error);
    }
    return Future.value([]);
  }

  Future<bool> deleteGroup(int id) async {
    _client.options.headers["Authorization"] = "Bearer $token";
    try {
      final response = await _client
          .delete(backendURL + groupURL, queryParameters: {'groupId': id});
      if (response.statusCode == 200) return Future.value(true);
    } on DioError catch (error) {
      print(error);
    }
    return Future.value(false);
  }
}
