class User {
  String? name;
  String? email;
  String? password;
  String? image;

  String? uid;

  User({
    this.name,
    this.email,
    this.password,
    this.image,
    this.uid,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['lastName'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['lastName'] = name;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    data['uid'] = uid;
    return data;
  }
}
