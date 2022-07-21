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
  String toString() => 'EnableField{id: $id, label: $label, fieldType: $fieldType, unit: $unit} \n';

  bool isForChart() => fieldType == "FOR_CHART";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnableField &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode =>
      id.hashCode ^ label.hashCode ^ fieldType.hashCode ^ unit.hashCode;
}
