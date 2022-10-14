import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class ChatContact {
  final String chatContactId;
  final String senderName;
  final String receiverName;
  final String senderId;
  final String receiverId;
  final String senderProfilePictureURL;
  final String receiverProfilePictureURL;
  final String lastMessage;
  final String productPic;
  final String productName;
  final String productId;
  final DateTime timeSent;
  const ChatContact({
    required this.chatContactId,
    required this.senderName,
    required this.receiverName,
    required this.senderId,
    required this.receiverId,
    required this.senderProfilePictureURL,
    required this.receiverProfilePictureURL,
    required this.lastMessage,
    required this.productPic,
    required this.productName,
    required this.productId,
    required this.timeSent,
  });

  ChatContact.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : chatContactId = snapshot.id,
        senderName = snapshot.data()['senderName'] ?? 'null geldi',
        receiverName = snapshot.data()['receiverName'] as String,
        senderId = snapshot.data()['senderId'] as String,
        receiverId = snapshot.data()['receiverId'] as String,
        senderProfilePictureURL = snapshot.data()['senderProfilePictureURL'] as String,
        receiverProfilePictureURL = snapshot.data()['receiverProfilePictureURL'] as String,
        lastMessage = snapshot.data()['lastMessage'] as String,
        productPic = snapshot.data()['productPic'] as String,
        productName = snapshot.data()['productName'] as String,
        productId = snapshot.data()['productId'] as String,
        timeSent = DateTime.fromMillisecondsSinceEpoch(snapshot.data()['timeSent']);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'chatContactId': chatContactId});
    result.addAll({'senderName': senderName});
    result.addAll({'receiverName': receiverName});
    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'senderProfilePictureURL': senderProfilePictureURL});
    result.addAll({'receiverProfilePictureURL': receiverProfilePictureURL});
    result.addAll({'lastMessage': lastMessage});
    result.addAll({'productPic': productPic});
    result.addAll({'productName': productName});
    result.addAll({'productId': productId});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});

    return result;
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      chatContactId: map['chatContactId'] ?? '',
      senderName: map['senderName'] ?? '',
      receiverName: map['receiverName'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      senderProfilePictureURL: map['senderProfilePictureURL'] ?? '',
      receiverProfilePictureURL: map['receiverProfilePictureURL'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      productPic: map['productPic'] ?? '',
      productName: map['productName'] ?? '',
      productId: map['productId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
