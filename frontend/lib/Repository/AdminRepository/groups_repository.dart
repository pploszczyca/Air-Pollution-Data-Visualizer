import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:adpv_frontend/DataModels/member_summary.dart';
import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/backend_response.dart';
import '../../DataModels/group_summary.dart';
import '../UserRepository/auth_gateway.dart';
import '../UserRepository/user_gateway.dart';

class GroupsRepository {
  final Dio _client = Dio();
  UserGateway userGateway = UserGateway();

  GroupsRepository();

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

  Future<GroupData> getGroupData(int id) async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response = await _client.get(
          backendURL + groupURL,
          queryParameters: {'groupId': id},
        );
        if (response.statusCode == 200) {
          final BackendResponse backendResponse =
              BackendResponse.fromJson(response.data);
          if (backendResponse.error == "") {
            var groupInfo = GroupData.fromJson(backendResponse.data);
            // final List<MemberInfo> members =
            //     backendResponse.data["shortUserInfos"]
            //         .map<MemberInfo>(
            //           (e) => MemberInfo.fromJson(Map.from(e)),
            //         )
            //         .toList();
            // groupInfo.members = members;
            // do not refactor! UFO MAGIC!
            return Future.value(groupInfo);
          }
        }
      } on DioError catch (error) {
        return Future.error(error);
      }
    }
    return Future.value(null);
  }

  Future<bool> deleteGroup(int id) async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response = await _client
            .delete(backendURL + groupURL, queryParameters: {'groupId': id});
        if (response.statusCode == 200) {
          return Future.value(true);
        }
      } on DioError catch (error) {
        return Future.error(error);
      }
    }
    return Future.value(false);
  }

  Future<GroupSummary> createGroup(String name) async {
    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      try {
        final response =
            await _client.post(backendURL + groupURL, data: {'name': name});
        if (response.statusCode == 200) {
          final BackendResponse backendResponse =
              BackendResponse.fromJson(response.data);
          if (backendResponse.error == "") {
            final GroupSummary groupData =
                GroupSummary.fromJson(backendResponse.data);
            return Future.value(groupData);
          }
        }
      } on DioError catch (error) {
        return Future.error(error);
      }
    }
    return Future.value(GroupSummary(-1, ''));
  }
}
