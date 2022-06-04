import 'package:adpv_frontend/Models/EndpointData.dart';

import '../Models/EndpointSummary.dart';

abstract class AbstractEndpointRepository {

  Future<List<EndpointSummary>> getEndpointSummary();

  Future<List<dynamic>> getEndpointData(int id);
}