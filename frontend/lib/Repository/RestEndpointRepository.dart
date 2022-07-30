import 'package:adpv_frontend/Repository/AbstractEndpointRepository.dart';
import 'package:dio/dio.dart';

import '../Common/Consts.dart';
import '../Common/URLs.dart';
import '../DataModels/EnableField.dart';
import '../DataModels/EndpointData.dart';
import '../DataModels/EndpointSummary.dart';

class BackendResponse<T> {
  final T data;
  final String error;

  BackendResponse(this.data, this.error);

  BackendResponse.fromJson(Map json)
      : data = json["data"],
        error = json["error"];
}

class RestEndpointRepository implements AbstractEndpointRepository {
  final Dio client;
  List<EndpointSummary> endpointSummaryList = [];
  Map<int, EndpointData> endpointDataMap = {};

  RestEndpointRepository(this.client) {
    getEndpointSummary().then((value) => endpointSummaryList = value);
  }

  @override
  Future<List<EndpointSummary>> getEndpointSummary() async {
    if (endpointSummaryList.isEmpty) {
      try {
        final Response response =
            await client.get(backendURL + getDataSummaryURL);
        if (response.statusCode == 200) {
          final BackendResponse backendResponse =
              BackendResponse.fromJson(response.data);
          if (backendResponse.error == "") {
            endpointSummaryList = backendResponse.data
                .map<EndpointSummary>((e) => EndpointSummary.fromJson(e))
                .toList();
            return Future.value(endpointSummaryList);
          }
        }
        endpointSummaryList = [];
        return Future.value(endpointSummaryList);
      } catch (error) {
        //print(error);
      }
    }
    return Future.value(endpointSummaryList);
  }

  bool isChartData(String field, List<EnableField> enableFieldsList) =>
      !enableFieldsList
          .firstWhere((element) => element.label == field)
          .isForChart();

  @override
  Future<EndpointData> getEndpointData(int id, int? limit, int? offset) async {
    if (!endpointDataMap.containsKey(id)) {
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
                    isChartData(key, enableFields) && key != ignoreField);
                return map;
              }).toList(),
              backendResponse.data.map<Map<dynamic, dynamic>>((e) {
                final Map map = Map.from(e);
                map.removeWhere(
                    (key, value) => !isChartData(key, enableFields));
                return map;
              }).toList(),
              enableFields,
            );
            endpointDataMap.putIfAbsent(id, () => endpointData);
            return Future.value(endpointData);
          }
        }
      } on Exception catch (error) {
        print(error);
      }
    }
    return Future.value(endpointDataMap[id]);
  }
}
