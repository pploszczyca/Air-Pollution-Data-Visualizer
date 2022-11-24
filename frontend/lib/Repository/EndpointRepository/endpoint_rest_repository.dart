import 'package:adpv_frontend/DataModels/endpoint_summary.dart';
import 'package:dio/dio.dart';

import '../../Common/consts.dart';
import '../../Common/urls.dart';
import '../../DataModels/enable_field.dart';
import '../../DataModels/endpoint_data.dart';
import '../rest_client.dart';

class BackendResponse<T> {
  final T data;
  final String error;

  BackendResponse(this.data, this.error);

  BackendResponse.fromJson(Map json)
      : data = json["data"],
        error = json["error"];
}

class EndpointRestRepository {
  final RestClient client = RestClient();

  EndpointRestRepository();

  Future<List<EndpointSummary>> getEndpointSummaryList(
  ) async {
    try {
      final Response response =
          await client.get(backendURL + getDataSummaryURL);
      if (response.statusCode == 200) {
        final BackendResponse backendResponse =
            BackendResponse.fromJson(response.data);

        if (backendResponse.error == "") {
          List<EndpointSummary> endpointSummaryList = [];
          endpointSummaryList = backendResponse.data
              .map<EndpointSummary>(
                // ignore: unnecessary_lambdas
                (e) => EndpointSummary.fromJson(e),
              ) // do not refactor! UFO MAGIC!
              .toList();
          return Future.value(endpointSummaryList);
        }
      }
    } on Exception catch (error) {
      return Future.error(error);
    }
    return Future.value([]);
  }

  bool _isChartData(String field, List<EnableField> enableFieldsList) =>
      !enableFieldsList
          .firstWhere((element) => element.label == field)
          .isForChart();

  Future<EndpointData> getEndpointData(
    int id,
    int? limit,
    int? offset,
  ) async {
    limit = limit ?? 25;
    offset = offset ?? 0;
    try {
      final Response response = await client.get(
        backendURL + getEndpointDataURL,
        queryParameters: {
          'sensorId': id,
          'limit': limit,
          'offset': offset,
        },
      );

      final Response fields = await client.get(
        backendURL + getFieldEnable,
        queryParameters: {'endpointId': id},
      );

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
              map.removeWhere(
                (key, value) =>
                    _isChartData(key, enableFields) && key != ignoreField,
              );
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
    } catch (error) {
      return Future.error(error);
    }
    return Future(EndpointData.empty);
  }
}
