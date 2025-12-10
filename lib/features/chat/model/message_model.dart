class MessageModel {
  String msg;
  String createdAt;
  bool isMyMessage;

  MessageModel({
    required this.msg,
    required this.createdAt,
    this.isMyMessage = false,
  });
}
