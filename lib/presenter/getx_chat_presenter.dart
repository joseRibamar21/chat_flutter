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
  late UserEntity currentUser;
  bool isInit = false;
  final _rxSenders = Rx<List<Map<String, dynamic>>>([]);
  final _rxDesconect = Rx<String?>("");
  final _rxRoomName = Rx<String?>("");
  final _rxCurrentUser = Rx<UserEntity?>(null);
  final _rxNotificationMenssage = Rx<MessageEntity?>(null);
  final _rxIsTyping = Rx<bool>(false);
  final _rxUserMessageTyping = Rx<String?>(null);

  final SecureStorage secureStorage = SecureStorage();
  late PreferencesEntity _preferencesEntity;

  late RoomEntity _roomEntity;
  late final String? _roomLink;
  bool _isBackgroundScreen = false;

  @override
  Stream<List<MessageEntity>> get listMessagesStream => _rxListMessages.stream;
  @override
  Stream<List<Map<String, dynamic>>> get listSendersStream => _rxSenders.stream;
  @override
  Stream<String?> get desconectStream => _rxDesconect.stream;
  @override
  Stream<String?> get roomNameString => _rxRoomName.stream;
  @override
  Stream<UserEntity?> get currentUserStream => _rxCurrentUser.stream;
  @override
  Stream<MessageEntity?> get notificationMenssage =>
      _rxNotificationMenssage.stream;
  @override
  Stream<String?> get userMessageTypingStream => _rxUserMessageTyping.stream;

  late Timer timer;
  late int timerDate;

  @override
  void inicialization() async {
    RoomEntity? roomCapture;
    socket.desconect();

    _preferencesEntity = await preferences.getData();
    timerDeleteMessages();

    try {
      if (Get.parameters['link'] == null || Get.parameters['user'] == null) {
        _rxDesconect.value = "Dados invalidos ou corrompidos!";
      } else {
        roomCapture = encryterMessage.getRoomLink(Get.parameters['link'] ?? "");
        currentUser =
            encryterMessage.getUserEncryter(Get.parameters['user'] ?? "")!;
      }
    } catch (e) {
      await disp();
      _rxDesconect.value = "Sala indisponível!";
    }

    if (roomCapture == null) {
      await disp();
      _rxDesconect.value = "Sala indisponível!";
    }

    _rxCurrentUser.value = currentUser;
    await Future.delayed(const Duration(milliseconds: 200));
    socket.init();

    _rxRoomName.value = roomCapture!.name;
    _roomEntity = roomCapture;
    _roomLink = encryterMessage.getLinkRoom(RoomEntity(
        name: _roomEntity.name,
        masterHash: _roomEntity.masterHash,
        roomHash: _roomEntity.roomHash,
        password: _roomEntity.password,
        master: roomCapture.master,
        expirateAt: roomCapture.expirateAt));
    _inicialization();

    if (!socket.isConnect) {
      socket.connectRoom(
          '${_rxRoomName.value}+${_roomEntity.password}+${_roomEntity.master}+${_roomEntity.expirateAt}',
          currentUser.name);
    }

    socket.listenDesconect((p0) async {
      await disp();
      _rxDesconect.value = "Conexão com servidor perdida!";
    });

    socket.listenMessagens((event) {
      /// Pegar menssagem recebida

      MessageEntity? value = getSendMessage(event: event);
      if (value != null) {
        switch (value.body.function) {
          // caso algue se desconect
          case 0:
            _rxSenders.value.removeWhere((e) => e["user"] == value.username);
            _rxSenders.refresh();
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
            break;
          // conectado
          case 1:
            if (value.username != currentUser.name) {
              _rxUserMessageTyping.value = null;
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

            if (_isBackgroundScreen) {
              _rxNotificationMenssage.value = value;
            }
            break;
          case 2:
            _rxSenders.value.addIf(
                currentUser.name != value.username &&
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

            if (value.username != currentUser.name) {
              _rxListMessages.value = _rxListMessages.value..add(value);
              _rxListMessages.refresh();
            }
            break;
          // Caso fique inativo
          case 4:
            if (value.username != currentUser.name) {
              for (var element in _rxSenders.value) {
                if (element['user'] == value.username) {
                  element['status'] = 4;
                }
              }
              _rxSenders.refresh();
            }
            break;
          case 5:
            removeMessage(value);
            break;
          // expulsar todo mundo da sala
          case 6:
            _rxDesconect.value = "Sala finalizada!";
            break;
          // usuario esta digitando
          case 7:
            if (value.username != currentUser.name) {
              _rxUserMessageTyping.value = value.username;
            }
            break;
          // usuario parou de digitar
          case 8:
            _rxUserMessageTyping.value = null;
            break;
          default:
            _rxListMessages.value = _rxListMessages.value..add(value);
            _rxListMessages.refresh();
        }
      }
    });
  }

  /// Funcão para mandar uma mensagem.
  ///
  /// Parâmetros: [value] será a mensagem a ser enviada.
  @override
  void send(String? value) {
    _rxIsTyping.value = false;
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
            "Bem vindo a sala!\nTodas as mensagens possuem criptografia ponta a ponta e serão apagadas ao sair da sala."));
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

  void _sendUserState({required int status, String? message, String? image}) {
    Map<String, dynamic> body = prepareSendMessage(
        usarName: currentUser.name,
        userHash: currentUser.hash,
        status: status,
        message: message);
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
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      List<MessageEntity> list = [];
      for (var element in _rxListMessages.value) {
        if (element.time != null && (element.body.sendAt <= timerDate)) {
          list.add(element);

          /* sendRemoveMessage(id: element.body.id ?? "");
          removeMessage(element); */
        }
      }
      for (var element in list) {
        var t = MessageEntity(
            username: element.username,
            userHash: element.userHash,
            body: BodyEntity(
                id: null,
                message: element.body.id,
                function: 5,
                sendAt: DateTime.now().microsecondsSinceEpoch),
            time: null);
        sendRemoveMessage(id: element.body.id ?? "");
      }

      timerDate = DateTime.now().millisecondsSinceEpoch;
    });
  }

  removeMessage(MessageEntity messageEntity) {
    _rxListMessages.value = _rxListMessages.value..add(messageEntity);
    _rxListMessages.refresh();
    _rxListMessages.value.removeWhere(
        (element) => element.body.id == messageEntity.body.message);
    _rxListMessages.value
        .removeWhere((element) => element.body.id == messageEntity.body.id);
  }

  @override
  String? get link => _roomLink;

  @override
  String? get nameRoomlink => _rxRoomName.value;

  @override
  String? get nick => currentUser.name;

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

  @override
  void finishRoom() {
    _sendUserState(status: 6);
  }

  @override
  void backgroundScreen(bool value) {
    _isBackgroundScreen = value;
  }

  @override
  void isTyping(String? value) {
    if (value != "") {
      if (!_rxIsTyping.value) {
        _rxIsTyping.value = true;
        _sendUserState(status: 7);
      }
    } else {
      _rxIsTyping.value = false;
      _sendUserState(status: 8);
    }
  }

  @override
  bool isMaster() {
    bool t = currentUser.name + currentUser.hash ==
        _roomEntity.master + _roomEntity.masterHash;
    return t;
  }

  @override
  void sendImage(String? value) {
    send("image@:$value");
  }
}
