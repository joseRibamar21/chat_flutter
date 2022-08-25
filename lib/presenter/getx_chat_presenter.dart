import 'dart:async';

import 'package:get/get.dart';

import '../../../data/helpers/helpers.dart';

import '../../../domain/entities/entities.dart';

import '../../../infra/cache/cache.dart';
import '../data/socket/socket.dart';
import '../domain/usecase/usecase.dart';
import '../ui/pages/chat/chat.dart';

class GetxChatPresenter extends GetxController implements ChatPresenter {
  final SocketClient socket;
  final EncryterMessage encryterMessage;
  final LocalPreferences preferences;
  GetxChatPresenter(
      {required this.socket,
      required this.encryterMessage,
      required this.preferences});

  final _rxListMessages = Rx<List<MessageEntity>>([]);
  late String? nickG;
  bool isInit = false;
  final _rxSenders = Rx<List<Map<String, dynamic>>>([]);
  final _rxDesconect = Rx<String?>("");
  final _rxRoomName = Rx<String?>("");
  final SecureStorage secureStorage = SecureStorage();
  late RoomEntity _roomEntity;
  late final String? _roomLink;
  late PreferencesEntity _preferencesEntity;

  @override
  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;
  @override
  Stream<List<Map<String, dynamic>>> get listSendersStream => _rxSenders.stream;
  @override
  Stream<String?> get desconectStream => _rxDesconect.stream;

  @override
  Stream<String?> get roomNameString => _rxRoomName.stream;

  late Timer timer;
  late int timerDate;

  @override
  void inicialization() async {
    RoomEntity? linkCapture;

    socket.desconect();

    _preferencesEntity = await preferences.getData();

    try {
      linkCapture = encryterMessage.getRoomLink(Get.parameters['link'] ?? "");
    } catch (e) {
      await disp();
      _rxDesconect.value = "Sala indisponível!";
    }

    if (linkCapture == null) {
      await disp();
      _rxDesconect.value = "Sala indisponível!";
    }

    socket.init();

    nickG = Get.parameters['nick'];
    _rxRoomName.value = linkCapture!.name;
    _roomEntity = linkCapture;
    _roomLink = encryterMessage.getLinkRoom(RoomEntity(
        name: _rxRoomName.value!,
        password: _roomEntity.password,
        master: linkCapture.master,
        expirateAt: linkCapture.expirateAt));

    _inicialization();

    if (!socket.isConnect) {
      socket.connectRoom(
          '${_rxRoomName.value}+${_roomEntity.password}+${_roomEntity.master}+${_roomEntity.expirateAt}',
          nickG);
    }
    socket.listenMessagens((event) {
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
                  element['last_time'] = DateTime.now().millisecondsSinceEpoch;
                }
              }
              _rxSenders.refresh();
            }

            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            break;
          case 2:
            _rxSenders.value.addIf(
                nickG != value.username &&
                    (_rxSenders.value.indexWhere(
                            (element) => element['user'] == value.username) ==
                        -1),
                {
                  "user": value.username,
                  "status": 1,
                  "last_time": DateTime.now().millisecondsSinceEpoch
                });
            _verifyIsConnected();
            _rxSenders.refresh();
            break;
          // Caso possua um novo conectado
          case 3:
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

    socket.listenDesconect((p0) async {
      if (p0 != null) {
        await disp();
        _rxDesconect.value = "Conexão com servidor perdida!";
      }
    });
  }

  /// Funcão para mandar uma mensagem.
  ///
  /// Parâmetros: [value] será a mensagem a ser enviada.
  @override
  void send(String? value) {
    if (value!.isNotEmpty) {
      _sendUserState(status: 1, message: value);
    }
  }

  /// Função para apagar uma mensagem para todos
  @override
  void sendRemoveMessage({required String id}) async {
    _sendUserState(message: id, status: 5);
  }

  /// Funcão que emite um sinal de retorno de visibilidade.
  @override
  void resume() {
    _sendUserState(status: 1);
  }

  /// Funcão que emite um sinal de visibilidade inativa.
  @override
  void inactive() {
    _sendUserState(status: 4);
  }

  void _inicialization() async {
    isInit = true;
    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      _rxListMessages.value = _rxListMessages.value
        ..add(messageSystem(
            "Bem vindo a sala!\nTodas as mensagens possuem criptografia ponta a ponta e seram apagadas ao sair da sala."));
      _sendUserState(status: 3);
    });
  }

  @override
  Future<void> disp() async {
    if (isInit) {
      _sendUserState(status: 0);

      isInit = false;
    }

    //socket.ondisconnect();
  }

  void _sendUserState({required int status, String? message}) {
    Map<String, dynamic> body =
        prepareSendMessage(usarName: nickG!, status: status, message: message);
    socket.sendMenssage(body);
  }

  @override
  List<Map<String, dynamic>> getlistSenders() {
    _verifyIsConnected();
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

  @override
  String? get link => _roomLink;

  @override
  String? get nameRoomlink => _rxRoomName.value;

  @override
  String? get nick => nickG;

  @override
  Future<void> verifyConnection() async {
    if (!socket.isConnect) {
      bool tryReconnect = await socket.reconnect();

      if (!tryReconnect) {
        disp();
        _rxDesconect.value = "Conexão com servidor perdida!";
      }
    }
  }

  @override
  void verifyExpirateRoom() {
    if (_roomEntity.expirateAt != null) {
      if (DateTime.now().millisecondsSinceEpoch >
          int.parse(_roomEntity.expirateAt ?? "0")) {
        disp();
        _rxDesconect.value = "Sala expirada!";
      }
    }
  }

  @override
  bool validadePassword(String password) {
    if (_preferencesEntity.password == password) {
      return true;
    }
    return false;
  }

  _verifyIsConnected() {
    for (var element in _rxSenders.value) {
      if (element['last_time'] + 180000 <
          DateTime.now().millisecondsSinceEpoch) {
        element['status'] = 4;
      }
    }
  }
}
