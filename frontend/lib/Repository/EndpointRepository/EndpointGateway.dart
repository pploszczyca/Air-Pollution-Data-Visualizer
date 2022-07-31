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
    final Future<List<EndpointSummary>> summary =
        restRepository.getEndpointSummaryList();
    summary.then(endpointCache.saveEndpointSummary);
    return summary;
  }

  Future<EndpointData> getEndpointData(
      int id, int? limit, int? offset, bool needUpdate) {
    limit = limit ?? -1;
    offset = offset ?? -1;
    if (endpointCache.isEndpointInCache(id) && !needUpdate) {
      return endpointCache.getEndpointData(id, limit, offset);
    } else {
      return updateCacheAndGetEndpointData(id, limit, offset);
    }
  }

  Future<EndpointData> updateCacheAndGetEndpointData(int id, int limit, int offset) {
    final Future<EndpointData> endpointDataFuture =
        restRepository.getEndpointData(id, limit, offset);
    endpointDataFuture.then((value) {
      endpointCache.saveEndpoint(id, value);
    });
    return endpointDataFuture;
  }
  
  

  void clearEndpointDataCache() {
    endpointCache.clearEndpointDataCache();
  }

}
