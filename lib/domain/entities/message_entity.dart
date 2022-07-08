import 'entities.dart';

class MessageEntity {
  final String sender;
  final BodyEntity body;
  final int? sentAt;
  MessageEntity(
      {required this.sender, required this.body, required this.sentAt});
}
