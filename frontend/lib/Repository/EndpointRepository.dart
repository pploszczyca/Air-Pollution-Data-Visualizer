import 'dart:collection';

import 'package:adpv_frontend/Models/EndpointData.dart';

import '../Models/Endpoint.dart';

class EndpointRepository {
  final _endpointsMap = HashMap<String, Endpoint>();

  EndpointRepository.mock() {
    addMockData();
  }

  void addMockData() {
    final dataList = <EndpointData>[];
    dataList.add(EndpointData(
        -0.5006779432296753,
        968676.75,
        90.28626251220703,
        29.120689392089844,
        46.7068977355957,
        57.965518951416016,
        DateTime.utc(2022, 5, 24)));
    dataList.add(EndpointData(
        -0.5783050656318665,
        968457.3125,
        89.98811340332031,
        30.517240524291992,
        49.965518951416016,
        63.844825744628906,
        DateTime.utc(2022, 5, 25)));
    dataList.add(EndpointData(
        -0.6757627725601196,
        968460.625,
        89.82502746582031,
        28.758621215820312,
        47.620689392089844,
        58.379310607910156,
        DateTime.utc(2022, 5, 26)));
    dataList.add(EndpointData(
        -0.49101686477661133,
        968562.75,
        90.81085968017578,
        27.913793563842773,
        45.72413635253906,
        56.620689392089844,
        DateTime.utc(2022, 5, 27)));
    dataList.add(EndpointData(
        -0.7047452330589294,
        968398.4375,
        89.54646301269531,
        31.0,
        50.13793182373047,
        60.77586364746094,
        DateTime.utc(2022, 5, 28)));

    Endpoint endpoint1 = Endpoint.name(1, "mockitoEndpoint", dataList);

    _endpointsMap.addAll({endpoint1.endpointName: endpoint1});
  }

  Future<List<String>> getEndpointSummary(){
    return Future.delayed(const Duration(seconds: 1), () =>  _endpointsMap.keys.toList());
  }

  Future<Endpoint> getEndpoint(String name) {
    return Future.delayed(
        const Duration(seconds: 2), () => _endpointsMap[name]!);
  }
}
