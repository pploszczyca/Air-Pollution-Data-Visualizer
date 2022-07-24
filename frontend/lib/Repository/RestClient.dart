import 'package:adpv_frontend/Models/BackendResponse.dart';
import 'package:adpv_frontend/Models/EnableField.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';
import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/URLs.dart';
import 'package:dio/dio.dart';

import '../Common/Common.dart';
import '../Models/EndpointData.dart';

class RestClient implements AbstractEndpointRepository {
  final Dio client;

  RestClient(this.client);

  @override
  Future<List<EndpointSummary>> getEndpointSummary() async {
    try {
      final Response response = await client.get(backendURL + getDataSummaryURL);

      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);
        if (backendResponse.error == "") {
          return Future.value(backendResponse.data
              .map<EndpointSummary>((e) => EndpointSummary.fromJson(e))
              .toList());
        }
      }
    } catch (error) {
      //print(error);
    }

    return Future.value([]);
  }

  bool isChartData(String field, List<EnableField> enableFieldsList) => !enableFieldsList
        .firstWhere((element) => element.label == field)
        .isForChart();

  @override
  Future<EndpointData> getEndpointData(int id, int? limit, int? offset) async {
    limit = limit ?? 25;
    offset = offset ?? 0;
    try {
      final Response response =
          await client.get(backendURL + getEndpointDataURL, queryParameters: {
        'sensorId': id,
        'limit': limit,
        'offset': offset,
      });

      final Response fields = await client.get(backendURL + getFieldEnable,
          queryParameters: {'endpointId': id});

      if (response.statusCode == 200 && fields.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        final BackendResponse fieldResponse = BackendResponse.fromJson(fields.data);

        if (backendResponse.error == "" && fieldResponse.error == "") {
          final List<EnableField> enableFields = fieldResponse.data
              .map<EnableField>((e) => EnableField.fromJson(Map.from(e)))
              .toList();

          return Future.value(EndpointData(
            backendResponse.data.map<Map<dynamic, dynamic>>((e) {
              final Map map = Map.from(e);
              map.removeWhere((key, value) =>
                  isChartData(key, enableFields) && key != ignoreField);
              return map;
            }).toList(),
            backendResponse.data.map<Map<dynamic, dynamic>>((e) {
              final Map map = Map.from(e);
              map.removeWhere((key, value) => !isChartData(key, enableFields));
              return map;
            }).toList(),
            enableFields,
          ));
        }
      }
    } on Exception catch (error) {
        print(error);
    }
    return Future.value(EndpointData.empty());
  }
}
