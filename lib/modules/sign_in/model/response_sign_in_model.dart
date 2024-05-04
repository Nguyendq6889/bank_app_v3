
class ResponseSignInModel {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;

  ResponseSignInModel({this.id, this.username, this.email, this.firstName, this.lastName, this.gender, this.image, this.token});

  ResponseSignInModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    email = json["email"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    gender = json["gender"];
    image = json["image"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["username"] = username;
    _data["email"] = email;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["gender"] = gender;
    _data["image"] = image;
    _data["token"] = token;
    return _data;
  }
}