import 'package:adpv_frontend/Models/BackendResponse.dart';
import 'package:adpv_frontend/Models/EnableField.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/URLs.dart';
import 'package:dio/dio.dart';

import '../Models/EndpointData.dart';

class RestClient implements AbstractEndpointRepository {
  final Dio client;

  RestClient(this.client);

  @override
  Future<List<EndpointSummary>> getEndpointSummary() async {
    try {
      Response response = await client.get(backendURL + getDataSummaryURL);

      if (response.statusCode == 200) {
        BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return Future.value(backendResponse.data
              .map<EndpointSummary>((e) => EndpointSummary.fromJson(e))
              .toList());
        }
        //print(backendResponse.error);
      }
    } catch (error) {
      //print(error);
    }

    return Future.value([]);
  }

  @override
  Future<EndpointData> getEndpointData(int id) async {
    try {
      Response response = await client.get(backendURL + getEndpointDataURL,
          queryParameters: {'sensorId': id});

      Response fields = await client.get(backendURL + getFieldEnable,
          queryParameters: {'endpointId': id});

      if (response.statusCode == 200 && fields.statusCode == 200) {
        BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        BackendResponse fieldResponse = BackendResponse.fromJson(fields.data);

        if (backendResponse.error == "" && fieldResponse.error == "") {
          List<EnableField> enableFields = fieldResponse.data
              .map<EnableField>((e) => EnableField.fromJson(Map.from(e)))
              .toList();

          return Future.value(EndpointData(
              backendResponse.data
                  .map<Map<dynamic, dynamic>>((e) => Map.from(e))
                  .toList(),
              enableFields));
        }
      }
    } catch (error) {
      print(error);
    }

    return Future.value(EndpointData.empty());
  }

  @override
  Future<EndpointData> getRecentData(int id, int limit, int offset) async {
    try {
      Response response =
          await client.get(backendURL + getEndpointDataURL, queryParameters: {
        'sensorId': id,
        'limit': limit,
        'offset': offset,
      });
      if (response.statusCode == 200) {
        BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return Future.value(EndpointData.onlyData(backendResponse.data
              .map<Map<dynamic, dynamic>>((e) => Map.from(e))
              .toList()));
        }
      }
    } catch (error) {
      print(error);
    }

    return Future.value(EndpointData.empty());
  }
}
