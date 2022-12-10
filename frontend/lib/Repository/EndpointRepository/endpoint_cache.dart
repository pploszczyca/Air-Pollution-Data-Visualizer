import '../../DataModels/endpoint.dart';
import '../../DataModels/endpoint_data.dart';
import '../../DataModels/endpoint_summary.dart';

class EndpointCache {
  final List<EndpointSummary> _endpointSummaryList = [];
  late Map<int, Endpoint> _endpointMap = {};
  bool _isEndpointSummaryLoaded = false;

  EndpointCache();

  Future<List<EndpointSummary>> getEndpointSummary() async =>
      Future.value(_endpointSummaryList);

  Future<EndpointData> getEndpointData(int id, int limit, int offset) {
    if (limit != -1 && offset != -1) {
      final endpointData = _endpointMap[id]!.data;
      return Future.value(
        EndpointData(
          endpointData.dataList.sublist(offset, limit),
          endpointData.technicalInfo,
          endpointData.enableFieldsList,
        ),
      );
    }
    return Future.value(_endpointMap[id]!.data);
  }

  bool isEndpointInCache(int endpointId, int dataSize) => _endpointMap.containsKey(endpointId) &&
        _endpointMap[endpointId]!.data.dataList.length > dataSize;

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
    _endpointMap[id] = Endpoint.fromSummary(summary, data);
  }
}
