import 'dart:collection';
import '../Models/Endpoint.dart';

class EndpointRepository{
  final _endpointsMap = HashMap<String, Endpoint>();

  EndpointRepository.mock();


  Future<List<String>> getEndpointSummary() {
    return Future.delayed(
        const Duration(seconds: 1), () => _endpointsMap.keys.toList());
  }

  Future<Endpoint> getEndpoint(String name) {
    return Future.delayed(
        const Duration(seconds: 1), () => _endpointsMap[name]!);
  }


}
