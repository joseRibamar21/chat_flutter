import 'dart:convert';

import '../../domain/entities/entities.dart';
import 'models.dart';

class MessageModel {
  final String username;
  final BodyEntity text;
  final String? time;
  MessageModel(
      {required this.username, required this.text, required this.time});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        username: json['username'],
        time: json['time'],
        text: BodyModel.fromJson(jsonDecode(json["text"])).toEntity());
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "text": jsonEncode(BodyModel.fromEntity(text).toJson()),
      };

  MessageEntity toEntity() =>
      MessageEntity(username: username, text: text, time: time);
}
