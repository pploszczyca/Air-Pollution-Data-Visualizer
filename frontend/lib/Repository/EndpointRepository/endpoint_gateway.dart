import 'package:adpv_frontend/DataModels/endpoint_data.dart';
import 'package:adpv_frontend/DataModels/endpoint_summary.dart';

import '../UserRepository/user_gateway.dart';
import 'endpoint_cache.dart';
import 'endpoint_rest_repository.dart';

class EndpointGateway {
  final EndpointRestRepository restRepository = EndpointRestRepository();
  final EndpointCache endpointCache = EndpointCache();
  final UserGateway userGateway;

  EndpointGateway(this.userGateway);

  Future<List<EndpointSummary>> getEndpointSummary({bool? needUpdate}) async {
    needUpdate = needUpdate ?? false;
    if (endpointCache.isEndpointSummaryInCache() && !needUpdate) {
      endpointCache.clearEndpointDataCache();
      return endpointCache.getEndpointSummary();
    }
    final List<EndpointSummary> summary =
        await restRepository.getEndpointSummaryList();

    endpointCache.saveEndpointSummary(summary);
    return summary;
  }

  Future<EndpointData> getEndpointData(
    int id,
    int? limit,
    int? offset,
    bool needUpdate,
  ) {
    limit = limit ?? -1;
    offset = offset ?? -1;
    if (endpointCache.isEndpointInCache(id) && !needUpdate) {
      return endpointCache.getEndpointData(id, limit, offset);
    } else {
      return updateCacheAndGetEndpointData(id, limit, offset);
    }
  }

  Future<EndpointData> updateCacheAndGetEndpointData(
    int id,
    int limit,
    int offset,
  ) {
    final Future<EndpointData> endpointDataFuture =
        restRepository.getEndpointData(
      id,
      limit,
      offset,
    );
    endpointDataFuture.then((value) {
      endpointCache.saveEndpoint(id, value);
    });
    return endpointDataFuture;
  }

  void clearEndpointDataCache() {
    endpointCache.clearEndpointDataCache();
  }
}
