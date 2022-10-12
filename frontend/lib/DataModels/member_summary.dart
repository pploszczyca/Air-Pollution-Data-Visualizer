class UserSummary{
  int id;
  String email;

  UserSummary(this.id, this.email);

  UserSummary.fromJson(Map json)
      : id = json["id"],
        email = json["email"];
}
