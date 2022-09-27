import 'package:adpv_frontend/Common/consts.dart';

class Field {
  final int id;
  final String label;
  final String fieldType;
  final String? unitName;
  late bool isBelongingToGroup;

  Field(
    this.id,
    this.label,
    this.fieldType,
    this.unitName,
    this.isBelongingToGroup,
  );

  Field.fromJson(Map json)
      : id = json["id"],
        label = json["label"],
        fieldType = json["fieldType"],
        unitName = json["unitName"],
        isBelongingToGroup = json["isBelongingToGroup"];
}

class EndpointForGroup {
  final int id;
  final String label;
  late bool isBelongingToGroup;
  Map<String, Field> fields;

  EndpointForGroup(this.id, this.label, this.isBelongingToGroup, this.fields);

  void sortFields() {
    final sortedEntries = fields.entries.toList()
      ..sort((e1, e2) => (e1.value.label.compareTo(e2.value.label)));
    fields = Map.fromEntries(sortedEntries);
    fields.remove(ignoreId);
    fields.remove(ignoreField);
  }

  EndpointForGroup.fromJson(Map json)
      : id = json["id"],
        label = json["label"],
        // ignore: unnecessary_lambdas
        fields = {for (var e in json["fields"]) e["label"]: Field.fromJson(e)},
        isBelongingToGroup = json["isBelongingToGroup"];

  Map<String, dynamic> toJson() => {
        "endpointId": id,
        "fieldIds": fields.values
            .where((field) => field.isBelongingToGroup)
            .map((field) => field.id.toString())
            .toList(),
        "detailedMeasurementDays": 0,
        "approximationPrecission": 0 // na co to po co to?
      };
}

class GroupEndpointsData {
  final int groupId;
  final String groupName;
  Map<String, EndpointForGroup> endpoints;

  GroupEndpointsData(this.groupId, this.groupName, this.endpoints);

  GroupEndpointsData.empty()
      : groupId = -1,
        groupName = "",
        endpoints = {};

  List<Map<String, dynamic>> toJson() =>
      endpoints.values.map((value) => value.toJson()).toList();

  void sortFields() {
    for (var element in endpoints.values) {
      element.sortFields();
    }
  }
}
