import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../data/entities/entities.dart';

class ChatController extends GetxController {
  final _rxListMessages = Rx<List<MessageEntity>>([]);
  late Stream<dynamic> _channelStream;
  late StreamSubscription<dynamic> _channelObs;
  int? t;

  WebSocketChannel? _channel =
      WebSocketChannel.connect(Uri.parse('wss://wss.infatec.solutions'));

  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;

  void init() async {
    _channelStream = _channel!.stream;

    _channelObs = _channelStream.listen((event) async {
      var message = jsonDecode(event);
      _rxListMessages.value = _rxListMessages.value
        ..add(MessageEntity(sender: message['sender'], body: message['body']));
      _rxListMessages.refresh();
    });
  }

  void send(String? value, String nick) {
    if (value!.isNotEmpty) {
      _channel?.sink.add(jsonEncode({"sender": nick, "body": value}));
    }
  }

  void disp() {
    _channelObs.cancel();
    _channel = null;
  }

  void teste() async {
    var t;
  }
}
