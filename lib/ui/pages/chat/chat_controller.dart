import 'dart:async';

import 'package:get/get.dart';

import '../../../data/helpers/helpers.dart';

import '../../../domain/entities/entities.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../infra/cache/cache.dart';

class ChatController extends GetxController {
  final _rxListMessages = Rx<List<MessageEntity>>([]);

  late String nickG;
  bool isInit = false;
  final _rxSenders = Rx<List<Map<String, dynamic>>>([]);
  final _rxDesconect = Rx<bool>(false);
  final SecureStorage secureStorage = SecureStorage();
  late final String? _room;
  late final String? _password;

  final Socket _socket = io.io(
    'http://143.244.150.213:3000',
    <String, dynamic>{
      'transports': ['websocket']
    },
  );

  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;
  Stream<List<Map<String, dynamic>>> get listSendersStream => _rxSenders.stream;
  Stream<bool> get desconectStream => _rxDesconect.stream;
  late Timer timer;
  late int timerDate;

  void desconect() {
    _rxDesconect.value = true;
  }

  void init(String room, String password, String name) async {
    //Primeiras acoes a serem executas
    /* if (nick != null && !isInit) { */
    nickG = name;
    _room = room;
    _password = password;

    _inicialization();
    /* } */
    //Abrir canal

    _socket.emit('joinRoom', {"username": nickG, 'room': '$_room+$_password '});

    _socket.on("message", (event) {
      print(event);

      /// Pegar menssagem recebida

      MessageEntity? value = getSendMessage(event: event);

      if (value != null) {
        switch (value.text.function) {
          // caso algue se desconect
          case 0:
            _rxSenders.value.removeWhere((e) => e["user"] == value.username);
            _rxSenders.refresh();
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            break;
          // conectado
          case 1:
            if (value.username != nickG) {
              for (var element in _rxSenders.value) {
                if (element['user'] == value.username) {
                  element['status'] = 1;
                }
              }
              _rxSenders.refresh();
            }

            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            break;
          case 2:
            _rxSenders.value.addIf(
                nickG != value.username, {"user": value.username, "status": 1});
            _rxSenders.refresh();
            break;
          // Caso possua um novo conectado
          case 3:
            _rxSenders.value = [];
            _sendUserState(status: 2);

            if (value.username != nickG) {
              _rxListMessages.value = _rxListMessages.value..add(value);
              _rxListMessages.refresh();
            }
            break;
          // Caso fique inativo
          case 4:
            if (value.username != nickG) {
              for (var element in _rxSenders.value) {
                if (element['user'] == value.username) {
                  element['status'] = 4;
                }
              }
              _rxSenders.refresh();
            }
            break;
          case 5:
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            _rxListMessages.value.removeWhere(
                (element) => element.text.id == value.text.message);
            break;
          default:
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
        }
      }
    });

    _socket.onDisconnect((data) {
      _rxDesconect.value = true;
    });
  }

  /// Funcão para mandar uma mensagem.
  ///
  /// Parâmetros: [value] será a mensagem a ser enviada.
  void send(String? value) {
    if (value!.isNotEmpty) {
      _sendUserState(status: 1, message: value);
    }
  }

  /// Função para apagar uma mensagem para todos
  void sendRemoveMessage({required String id}) async {
    _sendUserState(message: id, status: 5);
  }

  /// Funcão que emite um sinal de retorno de visibilidade.
  void resume() {
    _sendUserState(status: 1);
  }

  /// Funcão que emite um sinal de visibilidade inativa.
  void inactive() {
    _sendUserState(status: 4);
  }

  void _inicialization() async {
    //Mandar menssagem para todos verem sua disponibilidade
    //_socket.emit('chatMessage', {"username": 'Jose', 'text': "olaaa"});
    isInit = true;
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      _rxListMessages.value = _rxListMessages.value
        ..add(messageSystem(
            "Bem vindo a sala!\nTodas as mensagens possuem criptografia ponta a ponta e seram apagadas ao sair da sala."));
      _sendUserState(status: 3);
    });
  }

  Future<void> disp() async {
    if (isInit) {
      _sendUserState(status: 0);
      isInit = false;
    }

    //_socket.ondisconnect();
  }

  void _sendUserState({required int status, String? message}) {
    Map<String, dynamic> body =
        prepareSendMessage(usarName: nickG, status: status, message: message);
    _socket.emit('chatMessage', body);
  }

  List<Map<String, dynamic>> getlistSenders() {
    _rxSenders.refresh();
    return _rxSenders.value;
  }

  Future<void> timerDeleteMessages() async {
    timerDate = DateTime.now().millisecondsSinceEpoch;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      List<MessageEntity> list = [];
      for (var element in _rxListMessages.value) {
        if (element.time != null && (element.text.sendAt <= timerDate)) {
          list.add(element);

          /* sendRemoveMessage(id: element.body.id); */
          /* removeMessage(element); */
        }
      }
      for (var element in list) {
        var t = MessageEntity(
            username: element.username,
            text: BodyEntity(
                id: null,
                message: element.text.id,
                function: 5,
                sendAt: DateTime.now().microsecondsSinceEpoch),
            time: null);
        removeMessage(t);
      }

      timerDate = DateTime.now().millisecondsSinceEpoch;
    });
  }

  removeMessage(MessageEntity messageEntity) {
    _rxListMessages.value = _rxListMessages.value..add(messageEntity);
    _rxListMessages.refresh();
    _rxListMessages.value.removeWhere(
        (element) => element.text.id == messageEntity.text.message);
  }
}
