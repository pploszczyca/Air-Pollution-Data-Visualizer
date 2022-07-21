import '../DataModels/EndpointData.dart';
import '../DataModels/EndpointSummary.dart';

abstract class AbstractEndpointRepository {
  Future<List<EndpointSummary>> getEndpointSummary();

  Future<EndpointData> getEndpointData(int id, int? limit, int? offset);
}
