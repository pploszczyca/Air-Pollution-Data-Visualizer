import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';

class Endpoint{
  late int id;
  late String label;
  late EndpointData data;

  Endpoint.fromSummary(EndpointSummary summary, this.data):
        id = summary.id, label = summary.label;

  Endpoint(this.id, this.label, this.data);



  @override
  bool operator ==(Object other) {
      return label == other;
  }

  bool isLabelEqual(String name){
    return label == name;
  }

  bool hasField(String field){
    if(data.dataList[0][field] != null){
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return 'Endpoint{id: $id, label: $label, data: $data}';
  }
}