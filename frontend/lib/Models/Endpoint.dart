import 'package:adpv_frontend/Models/EndpointData.dart';
import 'package:adpv_frontend/Models/EndpointSummary.dart';

class Endpoint{
  late int id;
  late String label;
  late Map<String, dynamic> staticInfo;
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
    return data.dataList[0].containsKey(field);
  }

  @override
  String toString() {
    return 'Endpoint{id: $id, label: $label, data: $data}';
  }
}