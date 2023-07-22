class PostModel {
  String? name;
  String? uId;
  String? dateTime;
  String? image;
  String? postImage;
  String? postData;
  PostModel(
      {this.name,
      this.uId,
      this.image,
      this.dateTime,
      this.postImage,
      this.postData});

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    return PostModel(
      name: json?['name'],
      uId: json?['uId'],
      image: json?['image'],
      dateTime: json?['dateTime'],
      postImage: json?['postImage'],
      postData: json?['postData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'postData': postData
    };
  }
}
