class GroupSummary {
  final int id;
  final String name;

  GroupSummary(this.id, this.name);

  GroupSummary.fromJson(Map json)
      : id = json["id"],
        name = json["name"];
}
