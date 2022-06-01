import 'package:adpv_frontend/Models/EndpointData.dart';

class Endpoint{
  late int id;
  late String endpointName;
  late List<EndpointData> dataList = <EndpointData>[];

  Endpoint.name(this.id, this.endpointName, this.dataList);

  Endpoint.noList(this.id, this.dataList);
}