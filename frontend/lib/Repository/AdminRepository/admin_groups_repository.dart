import 'package:adpv_frontend/DataModels/group_data.dart';
import 'package:dio/dio.dart';

import '../../Common/urls.dart';
import '../../DataModels/backend_response.dart';
import '../../DataModels/group_endpoints.dart';
import '../../DataModels/group_summary.dart';
import '../../DataModels/user_summary.dart';
import '../rest_client.dart';

class AdminGroupsRepository {
  final RestClient _client = RestClient();

  AdminGroupsRepository();

  Future<List<GroupSummary>> getGroupsSummary() async {
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
    return Future.value([]);
  }

  Future<GroupData> getGroupData(int id) async {
    try {
      final response = await _client.get(
        backendURL + groupMembersURL,
        queryParameters: {'groupId': id},
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return Future.value(GroupData.fromJson(backendResponse.data));
        }
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.value(GroupData(-1, '', []));
  }

  Future<bool> deleteGroup(int id) async {
    try {
      final response = await _client
          .delete(backendURL + groupURL, queryParameters: {'groupId': id});
      if (response.statusCode == 200) {
        return Future.value(true);
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.value(false);
  }

  Future<GroupSummary> createGroup(String name) async {
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
    return Future.value(GroupSummary(-1, ''));
  }

  Future<GroupEndpointsData> getEndpointsForGroup(int groupId) async {
    try {
      final Response response = await _client.get(
        backendURL + groupEndpointsUrl,
        queryParameters: {"groupId": groupId.toString()},
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return GroupEndpointsData.fromJson(
            backendResponse.data,
          );
        }
      }
    } on DioError catch (error) {
      return Future.error(error);
    } catch (error) {
      return Future.error(error);
    }
    return Future.error("Cannot get endpoints for group");
  }

  Future<GroupEndpointsData> updateGroupEndpoints(
    GroupEndpointsData groupEndpointsData,
  ) async {
    try {
      final Response response = await _client.put(
        backendURL + groupEndpointsUrl,
        queryParameters: {"groupId": groupEndpointsData.groupId.toString()},
        data: groupEndpointsData.toJson(),
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return GroupEndpointsData.fromJson(
            backendResponse.data,
          );
        }
      }
    } on DioError catch (error) {
      return Future.error(error);
    } catch (error) {
      return Future.error(error);
    }
    return Future.error("Cannot post");
  }

  Future<bool> deleteMember(int memberId, int groupId) async {
    try {
      final response = await _client.delete(
        backendURL + removeMemberURL,
        queryParameters: {'groupId': groupId, 'userId': memberId},
      );
      if (response.statusCode == 200) {
        return Future.value(true);
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.value(false);
  }

  Future<List<UserSummary>> getMembersNotInGroup(int groupId) async {
    try {
      final response = await _client.get(
        backendURL + usersNotInGroup,
        queryParameters: {'groupId': groupId},
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          final List<UserSummary> usersList = backendResponse.data
              .map<UserSummary>(
                // ignore: unnecessary_lambdas
                (e) => UserSummary.fromJson(e),
              )
              .toList();
          return Future.value(usersList);
        }
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.value([]);
  }

  Future<bool> addMember(int userId, int groupId) async {
    try {
      final response = await _client.post(
        backendURL + addUserToGroupURL,
        queryParameters: {'groupId': groupId, 'userId': userId},
      );
      if (response.statusCode == 200) {
        return Future.value(true);
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.value(false);
  }
}
