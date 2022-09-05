class EndpointSummary {
  final int id;
  final String label;

  EndpointSummary(this.id, this.label);

  EndpointSummary.fromJson(Map json)
      : id = json["id"],
        label = json["label"];

  EndpointSummary.empty()
      : id = -1,
        label = "";

  @override
  bool operator ==(Object other) => other is EndpointSummary && other.id == id;

  @override
  String toString() => id.toString() + " " + label;

  @override
  int get hashCode => id.hashCode;
}
