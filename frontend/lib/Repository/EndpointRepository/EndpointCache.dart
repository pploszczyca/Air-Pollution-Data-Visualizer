import '../../DataModels/Endpoint.dart';
import '../../DataModels/EndpointData.dart';
import '../../DataModels/EndpointSummary.dart';

class EndpointCache {
  final List<EndpointSummary> _endpointSummaryList = [];
  final Map<int, Endpoint> _endpointMap = {};
  bool _isEndpointSummaryLoaded = false;

  EndpointCache();

  Future<List<EndpointSummary>> getEndpointSummary() async =>
      Future.value(_endpointSummaryList);

  Future<EndpointData> getEndpointData(int id) =>
      Future.value(_endpointMap[id]!.data);

  bool isEndpointInCache(int endpointId) =>
      _endpointMap.containsKey(endpointId);

  bool isEndpointSummaryInCache() => _isEndpointSummaryLoaded;

  void saveEndpointSummary(List<EndpointSummary> data) {
    for (var element in data) {
      !_endpointSummaryList.contains(element)
          ? _endpointSummaryList.add(element)
          : null;
    }
    _isEndpointSummaryLoaded = true;
  }

  void saveEndpoint(int id, EndpointData data) {
    final EndpointSummary summary =
        _endpointSummaryList.singleWhere((element) => element.id == id);
    if (isEndpointInCache(id)) {
      _endpointMap[id] =
          Endpoint.fromSummary(summary, data);
      print("SAVED DATA: " + data.toString());
    } else {
      _endpointMap.putIfAbsent(id,() => Endpoint.fromSummary(summary, data));
    }
  }
}
