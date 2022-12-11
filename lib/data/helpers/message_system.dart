import '../../domain/entities/entities.dart';

MessageEntity messageSystem(String message) {
  return MessageEntity(
    username: 'SYSTEM',
    time: null,
    userHash: "BOT",
    body: BodyEntity(
        id: "0",
        message: message,
        function: 1,
        sendAt: DateTime.now().microsecondsSinceEpoch),
  );
}
