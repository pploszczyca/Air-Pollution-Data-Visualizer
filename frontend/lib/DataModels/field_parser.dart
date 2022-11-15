class FieldParser {
  int id;
  String path;

  FieldParser.fromJson(Map json)
      : id = json['id'],
        path = json['path'];
}
