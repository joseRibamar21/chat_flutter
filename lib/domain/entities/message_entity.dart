import 'entities.dart';

class MessageEntity {
  final String username;
  final String userHash;
  final BodyEntity body;
  final String? time;
  MessageEntity(
      {required this.username,
      required this.userHash,
      required this.body,
      required this.time});
}
