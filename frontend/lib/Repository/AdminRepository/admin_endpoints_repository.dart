import 'package:adpv_frontend/Common/urls.dart';
import 'package:adpv_frontend/DataModels/enable_field.dart';
import 'package:adpv_frontend/DataModels/field_parser.dart';
import 'package:adpv_frontend/Repository/AdminRepository/fields_repository.dart';
import 'package:adpv_frontend/Repository/UserRepository/user_gateway.dart';
import 'package:dio/dio.dart';

import '../../DataModels/backend_response.dart';
import '../UserRepository/auth_gateway.dart';

class EndpointAdminField {
  int fieldId;
  int parserId;
  String label;
  String path;

  EndpointAdminField(this.fieldId, this.parserId, this.label, this.path);

  EndpointAdminField.fromJson(Map json)
      : fieldId = json['fieldId'],
        parserId = json['parserId'],
        label = json['label'],
        path = json['path'];
}

class EndpointAdminData {
  int id;
  int endpointNumber;
  String label;
  String sensorUrl;
  List<EndpointAdminField> fieldList;

  EndpointAdminData.fromJson(Map endpointDataJson)
      : id = endpointDataJson['id'],
        endpointNumber = endpointDataJson['endpointNumber'],
        label = endpointDataJson['label'],
        sensorUrl = endpointDataJson['sensorUrl'],
        fieldList = endpointDataJson['fieldAndParserList']
            // ignore: unnecessary_lambdas
            .map<EndpointAdminField>((e) => EndpointAdminField.fromJson(e))
            .toList();

  Map<String, String> getEndpointBasicInfo() => {
        "id": id.toString(),
        "number": endpointNumber.toString(),
        "label": label,
        "sensorUrl": sensorUrl
      };
}

class EndpointComplexData {
  Map<int, FieldParser> fieldParsers;
  Map<int, EnableField> enableFields;
  List<EndpointAdminData> endpoints;

  EndpointComplexData(this.fieldParsers, this.enableFields, this.endpoints);
}

class AdminEndpointsRepository {
  Dio _client = Dio();
  FieldsRepository fieldsRepository = FieldsRepository();
  UserGateway userGateway = UserGateway();

  Future<EndpointComplexData> getComplexData() async {
    final List<EndpointAdminData> endpoints = await getAllEndpoints();
    final Map<int, EnableField> fields = await getAllFields();
    final Map<int, FieldParser> parsers = await getAllParsers();

    return EndpointComplexData(parsers, fields, endpoints);
  }

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
            .map<EndpointAdminData>(
              //ignore: unnecessary_lambdas
              (endpoint) => EndpointAdminData.fromJson(endpoint),
            )
            .toList();
      }
    }
    return Future.error("Cannot get all endpoints list");
  }

  Future<Map<int, FieldParser>> getAllParsers() async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      final Response response = await _client.get(backendURL + "field/parser");
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        return {
          for (var e in backendResponse.data) e['id']: FieldParser.fromJson(e)
        };
      }
    }
    return Future.error("Cannot get all parsers list");
  }

  Future<Map<int, EnableField>> getAllFields() async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      final Response response = await _client.get(backendURL + "field");
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        return {
          for (var e in backendResponse.data) e['id']: EnableField.fromJson(e)
        };
      }
    }
    return Future.error("Cannot get all fields list");
  }

  void deleteEndpoint(int endpointId) async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      await _client.delete(
        backendURL + "sensor",
        queryParameters: {'endpointId': endpointId.toString()},
      );
    }else {
      return Future.error("Cannot delete endpoint list");
    }
  }

  Future<EndpointAdminData> updateEndpoint(
    int id,
    String number,
    String label,
    String sensorUrl,
    List<Map<String, String>> fieldAndParserKeys,
  ) async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      final Response response = await _client.put(
        backendURL + "sensor",
        data: {
          "endpointNumber": number,
          "label": label,
          "sensorUrl": sensorUrl,
          "fieldAndParserKeys": fieldAndParserKeys,
        },
        queryParameters: {"endpointId": id},
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        return Future.value(
          EndpointAdminData.fromJson(Map.from(backendResponse.data)),
        );
      }
    }
    return Future.error("Cannot update endpoint");
  }

  void deleteEndpoint(int endpointId) async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      await _client.delete(
        backendURL + "sensor",
        queryParameters: {'endpointId': endpointId.toString()},
      );
    }
    return Future.error("Cannot delete endpoint list");
  }

  Future<EndpointAdminData> updateEndpoint(
    int id,
    String number,
    String label,
    String sensorUrl,
    List<Map<String, String>> fieldAndParserKeys,
  ) async {
    _client = Dio();

    final AuthResponse authResponse = await userGateway.getFromMemory();

    if (authResponse.success) {
      final String token = authResponse.tokens!.accessToken;
      _client.options.headers["Authorization"] = "Bearer $token";

      final Response response = await _client.put(
        backendURL + "sensor",
        data: {
          "endpointNumber": number,
          "label": label,
          "sensorUrl": sensorUrl,
          "fieldAndParserKeys": fieldAndParserKeys,
        },
        queryParameters: {"endpointId": id},
      );
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        return Future.value(
          EndpointAdminData.fromJson(Map.from(backendResponse.data)),
        );
      }
    }
    return Future.error("Cannot update endpoint");
  }
}
