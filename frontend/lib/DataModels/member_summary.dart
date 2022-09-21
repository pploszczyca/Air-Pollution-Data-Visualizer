class MemberSummary{
  int id;
  String email;

  MemberSummary(this.id, this.email);

  MemberSummary.fromJson(Map json)
      : id = json["id"],
  email = json["email"];
}
