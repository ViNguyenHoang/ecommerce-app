class MessageModel {
  String? message;
  String? sentByme;

  MessageModel({required this.message, required this.sentByme});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(message: json["message"], sentByme: json["sentByme"]);
  }
}
