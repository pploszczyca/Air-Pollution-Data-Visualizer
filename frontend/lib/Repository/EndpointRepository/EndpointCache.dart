import '../../DataModels/Endpoint.dart';
import '../../DataModels/EndpointData.dart';
import '../../DataModels/EndpointSummary.dart';

class EndpointCache {
  final List<EndpointSummary> _endpointSummaryList = [];
  late Map<int, Endpoint> _endpointMap = {};
  bool _isEndpointSummaryLoaded = false;

  EndpointCache();

  Future<List<EndpointSummary>> getEndpointSummary() async =>
      Future.value(_endpointSummaryList);

  Future<EndpointData> getEndpointData(int id, int limit, int offset) {
    if (limit != -1 && offset != -1) {
      return Future.value(EndpointData(
          _endpointMap[id]!.data.dataList.sublist(offset, limit),
          _endpointMap[id]!.data.technicalInfo,
          _endpointMap[id]!.data.enableFieldsList));
    }
    return Future.value(_endpointMap[id]!.data);
  }

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

  void clearEndpointDataCache() {
    _endpointMap = {};
  }

  void saveEndpoint(int id, EndpointData data) {
    final EndpointSummary summary =
        _endpointSummaryList.singleWhere((element) => element.id == id);
    if (isEndpointInCache(id)) {
      _endpointMap[id] = Endpoint.fromSummary(summary, data);
    } else {
      _endpointMap.putIfAbsent(id, () => Endpoint.fromSummary(summary, data));
    }
  }
}
