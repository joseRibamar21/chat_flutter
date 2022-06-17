import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/entities/entities.dart';
import '../../data/models/models.dart';

class ChatController extends GetxController {
  final _rxListMessages = Rx<List<MessageEntity>>([]);
  late Stream<dynamic> _channelStream;
  late StreamSubscription<dynamic> _channelObs;
  late String _nick;
  bool isInit = false;
  List<String> senders = [];

  WebSocketChannel? _channel =
      WebSocketChannel.connect(Uri.parse('wss://wss.infatec.solutions'));

  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;

  void init(String? nick) async {
    _channelStream = _channel!.stream;

    if (nick != null && !isInit) {
      _nick = nick;
      var body = jsonEncode(MessageModel(
              sender: nick,
              body: BodyModel(message: "null", connecting: 3).toEntity())
          .toJson());
      _channel?.sink.add(body);
      isInit = true;
    }

    _channelObs = _channelStream.listen((event) async {
      print(event);
      var message = jsonDecode(event);
      MessageEntity value = MessageEntity(
          sender: message['sender'],
          body: BodyModel.fromJson(message['body']).toEntity());

      switch (value.body.connecting) {
        // caso algue se desconect
        case 0:
          senders.remove(value.sender);
          _rxListMessages.value = _rxListMessages.value..add(value);
          _rxListMessages.refresh();
          break;
        case 2:
          senders.addIf(_nick != value.sender, value.sender);

          break;
        // Caso possua um novo conectado
        case 3:
          var body = jsonEncode(MessageModel(
                  sender: _nick,
                  body: BodyModel(message: "null", connecting: 2).toEntity())
              .toJson());
          _channel?.sink.add(body);
          if (value.sender != _nick) {
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
          }
          break;
        default:
          _rxListMessages.value = _rxListMessages.value..add(value);
          _rxListMessages.refresh();
      }
      print(senders);
    });
  }

  void send(String? value, String nick) {
    if (value!.isNotEmpty) {
      var body = jsonEncode(MessageModel(
              sender: nick,
              body: BodyModel(message: value, connecting: 1).toEntity())
          .toJson());
      _channel?.sink.add(body);
    }
  }

  Future<void> disp() async {
    if (isInit) {
      var body = jsonEncode(MessageModel(
              sender: _nick,
              body: BodyModel(message: "null", connecting: 0).toEntity())
          .toJson());
      _channel?.sink.add(body);
      isInit = false;
    }
    _channelObs.cancel();
    _channel = null;
  }
}
