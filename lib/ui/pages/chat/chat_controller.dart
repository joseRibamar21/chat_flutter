import 'dart:async';
import 'dart:convert';

import 'package:chat_flutter/data/usecase/encrypt_message.dart';
import 'package:flutter/foundation.dart';
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

  EncryptMessage encryptMessage = EncryptMessage();
  WebSocketChannel? _channel =
      WebSocketChannel.connect(Uri.parse('wss://wss.infatec.solutions'));

  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;
  Stream<List<Map<String, dynamic>>> get listSendersStream => _rxSenders.stream;

  void init(String? nick) async {
    _channelStream = _channel!.stream;

    //Primeiras acoes a serem executas
    if (nick != null && !isInit) {
      _inicialization(nick);
    }
    //Abrir canal
    _channelObs = _channelStream.listen((event) async {
      _status();

      // Pegar menssagem recebida
      var message = jsonDecode(event);
      var teste = jsonDecode(message['body']);
      try {
        teste['message'] = teste['message'] != null
            ? encryptMessage.dencrypt(teste['message'])
            : null;
      } finally {}
      MessageEntity value = MessageEntity(
          sender: message['sender'],
          body: BodyModel.fromJson(teste).toEntity());

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
      var messageEncryted = encryptMessage.encrypt(value);
      _sendUserState(status: 1, message: messageEncryted);
    }
  }

  void resume() {
    if (_channelObs.isPaused) {
      _channelObs.resume();
    }
    _sendUserState(status: 1);
  }

  void inactive() {
    _sendUserState(status: 4);
  }

  void _inicialization(String nick) async {
    //ATUALIZAR NICK
    nickG = nick;
    //Mandar menssagem para todos verem sua disponibilidade
    _sendUserState(status: 3);
    isInit = true;
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      _rxListMessages.value = _rxListMessages.value
        ..add(MessageEntity(
            sender: 'SYSTEM',
            body: BodyEntity(
                message:
                    "Bem vindo a sala!\nTodas as mensagens possuem criptografia ponta a ponta e seram apagadas ao sair da sala.",
                connecting: 1)));
    });
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

  List<Map<String, dynamic>> get getlistSenders => _rxSenders.value;

  void _status() {
    if (kDebugMode) {
      print("Channel Paused: ${_channelObs.isPaused}");
      print("Messages");
      for (var element in _rxListMessages.value) {
        print("${element.body.message} - ${element.body.connecting} ");
      }
      //print(_rxSenders.value);
    }
  }
}
