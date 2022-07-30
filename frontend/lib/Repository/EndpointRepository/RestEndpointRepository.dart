import 'package:adpv_frontend/Repository/EndpointRepository/AbstractEndpointRepository.dart';
import 'package:adpv_frontend/Repository/EndpointRepository/RestEndpointService.dart';
import 'package:dio/dio.dart';

import '../../DataModels/EndpointData.dart';
import '../../DataModels/EndpointSummary.dart';

class RestEndpointRepository implements AbstractEndpointRepository {
  final Dio client;
  static RestEndpointService restEndpointService = RestEndpointService();
  static List<EndpointSummary> endpointSummaryList = [];
  static Map<int, EndpointData> endpointDataMap = {};

  RestEndpointRepository(this.client);

  @override
  Future<List<EndpointSummary>> getEndpointSummary() async {
    if (endpointSummaryList.isEmpty) {
      return restEndpointService
          .getEndpointSummaryList()
          .then((value) => endpointSummaryList = value);
    }
    return Future.value(endpointSummaryList);
  }

  @override
  Future<EndpointData> getEndpointData(int id, int? limit, int? offset) async {
    if (!endpointDataMap.containsKey(id)) {
      return restEndpointService
          .getEndpointData(id, limit, offset)
          .then((value) => endpointDataMap[id] = value);
    }
    return Future.value(endpointDataMap[id]);
  }
}
