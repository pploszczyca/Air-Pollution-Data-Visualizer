class EndpointSummary{
  final int id;
  final String label;

  EndpointSummary(this.id, this.label);

  EndpointSummary.fromJson(Map json):
    id = json["id"],
    label = json["label"];

  @override
  String toString() {
    return id.toString() + " " +  label;
  }
}