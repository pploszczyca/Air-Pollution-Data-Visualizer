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
  }

  EndpointForGroup.fromJson(Map json)
      : id = json["id"],
        label = json["label"],
        // ignore: unnecessary_lambdas
        fields = {for (var e in json["fields"]) e["label"]: Field.fromJson(e)},
        isBelongingToGroup = json["isBelongingToGroup"] {
    for (var element in fields.entries) {
      if ([ignoreId, ignoreLabel, ignoreField].contains(element.key)) {
        element.value.isBelongingToGroup = true;
      }
    }
  }

  Map<String, dynamic> toJson() => {
        "endpointId": id,
        "fieldIds": fields.values
            .where((field) => field.isBelongingToGroup)
            .map((field) => field.id.toString())
            .toList(),
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

  GroupEndpointsData.fromJson(Map json)
      : groupId = json["groupId"],
        groupName = json["groupName"],
        endpoints = {
          for (var e in json["endpoints"])
            e["label"]: EndpointForGroup.fromJson(e)
        };

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> list = endpoints.values
        .where((element) => element.isBelongingToGroup)
        .map((value) => value.toJson())
        .toList();
    return list;
  }

  void sortFields() {
    for (final element in endpoints.values) {
      element.sortFields();
    }
  }
}
