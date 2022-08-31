import 'package:adpv_frontend/DataModels/Endpoint/EndpointData.dart';
import 'package:adpv_frontend/DataModels/Endpoint/EndpointSummary.dart';

import '../UserRepository/UserGateway.dart';
import 'EndpointCache.dart';
import 'EndpointRestRepository.dart';

class EndpointGateway {
  final EndpointRestRepository restRepository = EndpointRestRepository();
  final EndpointCache endpointCache = EndpointCache();
  final UserGateway userGateway;

  EndpointGateway(this.userGateway);

  Future<List<EndpointSummary>> getEndpointSummary() async {
    if (endpointCache.isEndpointSummaryInCache()) {
      return endpointCache.getEndpointSummary();
    }
    final List<EndpointSummary> summary = await restRepository
        .getEndpointSummaryList(userGateway.user.tokenResponse.accessToken);

    endpointCache.saveEndpointSummary(summary);
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

  Future<EndpointData> updateCacheAndGetEndpointData(
      int id, int limit, int offset) {
    final Future<EndpointData> endpointDataFuture =
        restRepository.getEndpointData(
            id, limit, offset, userGateway.user.tokenResponse.accessToken);
    endpointDataFuture.then((value) {
      endpointCache.saveEndpoint(id, value);
    });
    return endpointDataFuture;
  }

  void clearEndpointDataCache() {
    endpointCache.clearEndpointDataCache();
  }
}
