import 'Unit.dart';

class EnableField {
  int id;
  String label;
  String fieldType;
  Unit unit;

  EnableField(this.id, this.label, this.fieldType, this.unit);

  EnableField.fromJson(Map json)
      : id = json["id"],
        label = json["label"],
        fieldType = json["fieldType"],
        unit = Unit.fromJson(json['unit'] ?? {}); // important "{}" :))

  @override
  String toString() {
    return 'EnableField{id: $id, label: $label, fieldType: $fieldType, unit: $unit} \n';
  }
}
