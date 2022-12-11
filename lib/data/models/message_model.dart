import 'dart:convert';

import '../../domain/entities/entities.dart';
import 'models.dart';

class MessageModel {
  final String username;
  final String userHash;
  final BodyEntity body;
  final String? time;
  MessageModel(
      {required this.username,
      required this.userHash,
      required this.body,
      required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        username: json['username'],
        userHash: json['userHash'],
        time: json['time'],
        body: BodyModel.fromJson(jsonDecode(json["body"])).toEntity());
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "userHash": userHash,
        "body": jsonEncode(BodyModel.fromEntity(body).toJson()),
      };

  MessageEntity toEntity() => MessageEntity(
      username: username, userHash: userHash, body: body, time: time);
}
