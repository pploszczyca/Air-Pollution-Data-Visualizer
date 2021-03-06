import 'package:adpv_frontend/Models/EndpointData.dart';

import '../Models/EndpointSummary.dart';

abstract class AbstractEndpointRepository {
  Future<List<EndpointSummary>> getEndpointSummary();

  Future<EndpointData> getEndpointData(int id, int? limit, int? offset);
}
