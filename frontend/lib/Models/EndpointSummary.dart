class EndpointSummary{
  final int id;
  final String label;

  EndpointSummary(this.id, this.label);

  EndpointSummary.fromJson(Map json):
    id = json["id"],
    label = json["label"];

  @override
  bool operator ==(Object other) => other is EndpointSummary && other.id == id;

  @override
  String toString() {
    return id.toString() + " " +  label;
  }

  @override
  int get hashCode => id.hashCode;

}