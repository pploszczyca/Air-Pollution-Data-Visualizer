import 'package:adpv_frontend/Common/urls.dart';
import 'package:adpv_frontend/Repository/EndpointRepository/endpoint_rest_repository.dart';
import 'package:dio/dio.dart';

import '../UserRepository/user_gateway.dart';
import '../rest_client.dart';

class UserGroups {
  int id;
  String name;

  UserGroups(this.id, this.name);

  UserGroups.fromJson(Map json)
      : id = json["id"],
        name = json["name"];
}

class UserData {
  int id;
  String email;
  List<String> roles;
  List<UserGroups> groups;

  UserData(this.id, this.email, this.roles, this.groups);

  UserData.fromJson(Map json)
      : id = json["id"],
        email = json["email"],
        roles = List.from(json["roles"]),
        groups = json["groups"]
            // ignore: unnecessary_lambdas
            .map<UserGroups>((group) => UserGroups.fromJson(group))
            .toList();
}

class AdminUsersRepository {
  final RestClient _client = RestClient();
  UserGateway userGateway = UserGateway();

  Future<List<UserData>> getAllUsers() async {
    try {
      final response = await _client.get(backendURL + "user/all");

      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          final List<UserData> list = backendResponse.data
              .map<UserData>(
                // ignore: unnecessary_lambdas
                (e) => UserData.fromJson(e),
              )
              .toList();
          return list;
        }
      }
    } on DioError catch (error) {
      return Future.error(error);
    }
    return Future.error("Cannot fetch users data");
  }

  Future<void> deleteUser(int id) async {
    try {
      await _client
          .delete(backendURL + "user", queryParameters: {"userId": id});
      return;
    } on DioError catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> saveRoles(
    Set<String> toRemove,
    Set<String> toAdd,
    int userId,
  ) async {
    try {
      for (String role in toRemove) {
        await _client.delete(
          backendURL + "role",
          queryParameters: {
            "userId": userId.toString(),
            "roleName": role,
          },
        );
      }
      for (String role in toAdd) {
        await _client.post(
          backendURL + "role",
          queryParameters: {
            "userId": userId.toString(),
            "roleName": role,
          },
        );
      }
      return Future.value(true);
    } on DioError catch (error) {
      return Future.error(error);
    }
  }
}
