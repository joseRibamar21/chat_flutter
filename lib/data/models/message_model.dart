import 'dart:convert';

import '../../domain/entities/entities.dart';
import 'models.dart';

class MessageModel {
  final String sender;
  final BodyEntity body;
  final int? sentAt;
  MessageModel(
      {required this.sender, required this.body, required this.sentAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        sender: json['message'],
        sentAt: json['sentAt'],
        body: BodyModel.fromJson(jsonDecode(json["body"])).toEntity());
  }

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "body": jsonEncode(BodyModel.fromEntity(body).toJson()),
        "sentAt": sentAt
      };

  MessageEntity toEntity() =>
      MessageEntity(sender: sender, body: body, sentAt: sentAt);
}
