import 'package:adpv_frontend/DataModels/EndpointData.dart';
import 'package:adpv_frontend/DataModels/EndpointSummary.dart';

import 'EndpointCache.dart';
import 'EndpointRestRepository.dart';

class EndpointGateway {
  final EndpointRestRepository restRepository = EndpointRestRepository();
  final EndpointCache endpointCache = EndpointCache();

  EndpointGateway();

  Future<List<EndpointSummary>> getEndpointSummary() {
    if (endpointCache.isEndpointSummaryInCache()) {
      return endpointCache.getEndpointSummary();
    }
    print("RESTING ENDPOINTSUMMERY");
    final Future<List<EndpointSummary>> summary =
        restRepository.getEndpointSummaryList();
    summary.then(
        endpointCache.saveEndpointSummary);
    return summary;
  }

  Future<EndpointData> getEndpointData(int id, int? limit, int? offset) {
    if (endpointCache.isEndpointInCache(id)) {
      print("LOADING ENDPOINT FROM CACHE:" + id.toString());
      return endpointCache.getEndpointData(id, limit, offset);
    } else {
      print("RESTING ENDPOINTDATA");
      final Future<EndpointData> endpointDataFuture =
          restRepository.getEndpointData(id, limit, offset);
      endpointDataFuture.then((value) => endpointCache.saveEndpoint(id, value));
      return endpointDataFuture;
    }
  }

  void reloadSummary(){

  }
}
