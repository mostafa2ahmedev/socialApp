class CommentModel {
  String? name;
  String? uId;
  String? dateTime;
  String? image;
  String? commentData;
  CommentModel(
      {this.name, this.uId, this.image, this.dateTime, this.commentData});

  factory CommentModel.fromJson(Map<String, dynamic>? json) {
    return CommentModel(
      name: json?['name'],
      uId: json?['uId'],
      image: json?['image'],
      dateTime: json?['dateTime'],
      commentData: json?['commentData'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'commentData': commentData
    };
  }
}
