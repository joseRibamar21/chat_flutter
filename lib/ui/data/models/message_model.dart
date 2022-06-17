import 'dart:convert';

import '../entities/entities.dart';
import 'models.dart';

class MessageModel {
  final String sender;
  final BodyEntity body;
  MessageModel({required this.sender, required this.body});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        sender: json['message'],
        body: BodyModel.fromJson(jsonDecode(json["body"])).toEntity());
  }

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "body": jsonEncode(BodyModel.fromEntity(body).toJson())
      };

  MessageEntity toEntity() => MessageEntity(sender: sender, body: body);
}
