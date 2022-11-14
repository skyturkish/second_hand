// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      text: json['text'] as String,
      timeSent: DateTime.parse(json['timeSent'] as String),
      messageId: json['messageId'] as String,
      isSeen: json['isSeen'] as bool,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'text': instance.text,
      'timeSent': instance.timeSent.toIso8601String(),
      'messageId': instance.messageId,
      'isSeen': instance.isSeen,
    };
