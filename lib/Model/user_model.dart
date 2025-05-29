class userModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? profile;
  String? bio;
  String? createdAt;
  String? lastOnline;
  String? status;

  userModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.profile,
      this.bio,
      this.createdAt,
      this.lastOnline,
      this.status});

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profile = json['profile'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    lastOnline = json['lastOnline'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['profile'] = this.profile;
    data['bio'] = this.bio;
    data['createdAt'] = this.createdAt;
    data['lastOnline'] = this.lastOnline;
    data['status'] = this.status;
    return data;
  }
}
