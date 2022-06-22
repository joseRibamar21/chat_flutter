import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/entities/entities.dart';
import '../../../data/models/models.dart';

class ChatController extends GetxController {
  final _rxListMessages = Rx<List<MessageEntity>>([]);
  late Stream<dynamic> _channelStream;
  late StreamSubscription<dynamic> _channelObs;
  late String nickG;
  bool isInit = false;
  final _rxSenders = Rx<List<Map<String, dynamic>>>([]);

  WebSocketChannel? _channel =
      WebSocketChannel.connect(Uri.parse('wss://wss.infatec.solutions'));

  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;
  Stream<List<Map<String, dynamic>>> get listSendersStream => _rxSenders.stream;

  void init(String? nick) async {
    _channelStream = _channel!.stream;

    if (nick != null && !isInit) {
      nickG = nick;
      _sendUserState(status: 3);
      isInit = true;
    }

    _channelObs = _channelStream.listen((event) async {
      print(event);
      print(_rxSenders.value);
      var message = jsonDecode(event);
      MessageEntity value = MessageEntity(
          sender: message['sender'],
          body: BodyModel.fromJson(message['body']).toEntity());

      switch (value.body.connecting) {
        // caso algue se desconect
        case 0:
          _rxSenders.value.removeWhere((e) => e["user"] == value.sender);
          _rxSenders.refresh();
          _rxListMessages.value = _rxListMessages.value..add(value);
          _rxListMessages.refresh();
          break;
        // conectado
        case 1:
          if (value.sender != nickG) {
            for (var element in _rxSenders.value) {
              if (element['user'] == value.sender) {
                element['status'] = 1;
              }
            }
            _rxSenders.refresh();
          }

          _rxListMessages.value = _rxListMessages.value..add(value);
          _rxListMessages.refresh();
          break;
        case 2:
          _rxSenders.value = [];
          _rxSenders.value.addIf(
              nickG != value.sender, {"user": value.sender, "status": 1});
          _rxSenders.refresh();
          break;
        // Caso possua um novo conectado
        case 3:
          _sendUserState(status: 2);

          if (value.sender != nickG) {
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            _rxSenders.value.addIf(
                nickG != value.sender, {"user": value.sender, "status": 1});
            _rxSenders.refresh();
          }
          break;
        // Caso fique inativo
        case 4:
          if (value.sender != nickG) {
            for (var element in _rxSenders.value) {
              if (element['user'] == value.sender) {
                element['status'] = 4;
              }
            }
            _rxSenders.refresh();
          }
          break;
        default:
          _rxListMessages.value = _rxListMessages.value..add(value);
          _rxListMessages.refresh();
      }
    });
  }

  void send(String? value, String nick) {
    if (value!.isNotEmpty) {
      _sendUserState(status: 1, message: value);
    }
  }

  void resume() {
    _sendUserState(status: 1);
  }

  void inactive() {
    _sendUserState(status: 4);
  }

  Future<void> disp() async {
    if (isInit) {
      _sendUserState(status: 0);
      isInit = false;
    }
    _channelObs.cancel();
    _channel = null;
  }

  void _sendUserState({required int status, String? message}) {
    var body = jsonEncode(MessageModel(
            sender: nickG,
            body: BodyModel(message: message ?? "", connecting: status)
                .toEntity())
        .toJson());
    _channel?.sink.add(body);
  }

  List<Map<String, dynamic>> get getlistSnders => _rxSenders.value;
}
