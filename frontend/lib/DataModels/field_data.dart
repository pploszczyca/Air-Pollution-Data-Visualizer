//ignore_for_file:  constant_identifier_names
enum FieldType { FOR_CHART, STATIC_NUMBER, STRING, ERROR }

extension FieldTypeExtension on FieldType {
  FieldType fromString(String typeString) {
    switch (typeString) {
      case "FOR_CHART":
        return FieldType.FOR_CHART;
      case "STRING":
        return FieldType.STRING;
      case "STATIC_NUMBER":
        return FieldType.STATIC_NUMBER;
    }
    return FieldType.ERROR;
  }
}

class UnitSummary {
  int id;
  String name;

  UnitSummary(this.id, this.name) ;

  UnitSummary.fromJson(Map json)
  : id = json['id'],
  name = json['name'];

}

class FieldData {
  int id;
  String name;
  FieldType type;
  UnitSummary unit;

  FieldData(this.id, this.name, this.type, this.unit);

  FieldData.fromJson(Map json)
      : id = json['id'],
        name = json['label'],
        type = FieldType.FOR_CHART.fromString(json['fieldType']),
        unit = json['unit'] == null ? UnitSummary(-1, "") : UnitSummary.fromJson(json['unit']);
}
