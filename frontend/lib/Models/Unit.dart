class Unit {
  int id;
  String name;

  Unit(this.id, this.name);

  Unit.fromJson(Map map)
      : id = map['id'] ?? -1,
        name = map['name'] ?? "";
}
