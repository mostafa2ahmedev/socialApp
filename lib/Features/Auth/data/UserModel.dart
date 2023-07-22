class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool isEmailVerfied;
  String? image;
  String? bio;
  String? cover;
  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      required this.isEmailVerfied,
      this.image,
      this.cover,
      this.bio});

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
        email: json?['email'],
        name: json?['name'],
        phone: json?['phone'],
        uId: json?['uId'],
        isEmailVerfied: json?['isEmailVerfied'],
        image: json?['image'],
        bio: json?['bio'],
        cover: json?['cover']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerfied': isEmailVerfied,
      'image': image,
      'bio': bio,
      'cover': cover
    };
  }
}
