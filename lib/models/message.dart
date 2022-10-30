class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
      ..addAll({'senderId': senderId})
      ..addAll({'receiverId': receiverId})
      ..addAll({'text': text})
      ..addAll({'timeSent': timeSent.millisecondsSinceEpoch})
      ..addAll({'messageId': messageId})
      ..addAll({'isSeen': isSeen});

    return result;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
