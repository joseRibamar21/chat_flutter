import 'entities.dart';

class MessageEntity {
  final String username;
  final BodyEntity text;
  final String? time;
  MessageEntity(
      {required this.username, required this.text, required this.time});
}
