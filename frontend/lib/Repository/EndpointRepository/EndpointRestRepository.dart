import 'package:adpv_frontend/DataModels/Endpoint/EndpointSummary.dart';
import 'package:dio/dio.dart';

import '../../Common/Consts.dart';
import '../../Common/URLs.dart';
import '../../DataModels/Endpoint/EnableField.dart';
import '../../DataModels/Endpoint/EndpointData.dart';

class BackendResponse<T> {
  final T data;
  final String error;

  BackendResponse(this.data, this.error);

  BackendResponse.fromJson(Map json)
      : data = json["data"],
        error = json["error"];
}

class EndpointRestRepository {
  final Dio client = Dio();

  EndpointRestRepository();

  Future<List<EndpointSummary>> getEndpointSummaryList(
      String accessToken) async {
    client.options.headers["Authorization"] = "Bearer $accessToken";
    client.options.headers["accept"] = "*/*";
    try {
      final Response response =
          await client.get(backendURL + getDataSummaryURL);
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        if (backendResponse.error == "") {
          List<EndpointSummary> endpointSummaryList = [];
          endpointSummaryList = backendResponse.data
              .map<EndpointSummary>((e) =>
                  EndpointSummary.fromJson(e)) // do not refactor! UFO MAGIC!
              .toList();
          return Future.value(endpointSummaryList);
        }
      }
    } catch (error) {}

    return Future.value([]);
  }

  bool _isChartData(String field, List<EnableField> enableFieldsList) =>
      !enableFieldsList
          .firstWhere((element) => element.label == field)
          .isForChart();

  Future<EndpointData> getEndpointData(
      int id, int? limit, int? offset, String accessToken) async {
    limit = limit ?? 25;
    offset = offset ?? 0;
    client.options.headers["Authorization"] = "Bearer $accessToken";
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

        final BackendResponse fieldResponse =
            BackendResponse.fromJson(fields.data);

        if (backendResponse.error == "" && fieldResponse.error == "") {
          final List<EnableField> enableFields = fieldResponse.data
              .map<EnableField>((e) => EnableField.fromJson(Map.from(e)))
              .toList();

          final EndpointData endpointData = EndpointData(
            backendResponse.data.map<Map<dynamic, dynamic>>((e) {
              final Map map = Map.from(e);
              map.removeWhere((key, value) =>
                  _isChartData(key, enableFields) && key != ignoreField);
              return map;
            }).toList(),
            backendResponse.data.map<Map<dynamic, dynamic>>((e) {
              final Map map = Map.from(e);
              map.removeWhere((key, value) => !_isChartData(key, enableFields));
              return map;
            }).toList(),
            enableFields,
          );
          return Future.value(endpointData);
        }
      }
    } on Exception catch (error) {}
    return Future(EndpointData.empty);
  }
}
