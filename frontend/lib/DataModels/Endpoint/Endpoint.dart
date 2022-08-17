import 'EndpointData.dart';
import 'EndpointSummary.dart';

class Endpoint {
  late int id;
  late String label;
  late Map<String, dynamic> staticInfo;
  late EndpointData data;

  Endpoint.fromSummary(EndpointSummary summary, this.data)
      : id = summary.id,
        label = summary.label;

  Endpoint(this.id, this.label, this.data);

  @override
  bool operator ==(Object other) => label == other;

  bool isLabelEqual(String name) => label == name;

  bool hasField(String field) => data.dataList[0].containsKey(field);

  @override
  String toString() => 'Endpoint{id: $id, label: $label, data: $data}';

  @override
  int get hashCode => super.hashCode + id * 0x1987987;
}
