class ChatModel {
  String? dataTime;
  String? senderId;
  String? recieverId;
  String? text;
  ChatModel({this.dataTime, this.recieverId, this.senderId, this.text});

  factory ChatModel.fromJson(Map<String, dynamic>? json) {
    return ChatModel(
      dataTime: json?['dataTime'],
      recieverId: json?['recieverId'],
      senderId: json?['senderId'],
      text: json?['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dataTime': dataTime,
      'recieverId': recieverId,
      'senderId': senderId,
      'text': text
    };
  }
}
