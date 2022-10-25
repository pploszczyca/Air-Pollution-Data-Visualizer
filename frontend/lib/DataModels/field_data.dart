//ignore_for_file:  constant_identifier_names
enum FieldType { FOR_CHART, STATIC_NUMBER, STRING }

class UnitSummary {
  int id;
  String name;

  UnitSummary(this.id, this.name) ;
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
        type = json['fieldType'],
        unit = UnitSummary(json['unit']['id'], json['unit']['name']);
}
