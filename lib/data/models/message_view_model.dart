import '../../domain/entities/entities.dart';

class MessageViewModel {
  late bool? isSend;
  final MessageEntity message;
  MessageViewModel({required this.isSend, required this.message});
}
