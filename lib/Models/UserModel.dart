class User {
  String avatar;
  String bio;
  String sId;
  String email;
  String phone;
  String password;
  String name;

  User(
      {this.avatar,
      this.bio,
      this.sId,
      this.email,
      this.phone,
      this.password,
      this.name});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    bio = json['bio'];
    sId = json['_id'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['bio'] = this.bio;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['name'] = this.name;
    return data;
  }
}
