import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../infra/cache/cache.dart';
import '../ui/components/permissions/permissions.dart';
import '../ui/pages/home/home.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final SecureStorage secureStorage;
  final LocalRoom localRoom;
  final EncryterMessage encryterMessage;
  final LocalPreferences preferences;

  GetxHomePresenter(
      {required this.secureStorage,
      required this.localRoom,
      required this.encryterMessage,
      required this.preferences});

  final _rxUiError = Rx<String?>("");
  final _rxUser = Rx<UserEntity?>(null);
  final _rxListRoom = Rx<List<RoomEntity>>([]);
  final _rxListRoomCopy = Rx<List<RoomEntity>>([]);
  final _rxIsSearching = Rx<bool>(false);
  final _rxNavigateTo = Rx<String?>("");
  late PreferencesEntity _preferencesEntity;

  @override
  Stream<bool> get isSeachingStream => _rxIsSearching.stream;

  @override
  Stream<UserEntity?> get userStream => _rxUser.stream;

  @override
  Stream<List<RoomEntity>> get listRoomStream => _rxListRoom.stream;

  @override
  Stream<String?> get navigatorStream => _rxNavigateTo.stream;

  @override
  Stream<String?> get uiErrorStream => _rxUiError.stream;

  @override
  void inicialization() async {
    try {
      _preferencesEntity = await preferences.getData();
      if (_preferencesEntity.nick.isNotEmpty) {
        _rxUser.value = UserEntity(
            name: _preferencesEntity.nick, hash: _preferencesEntity.nick);
      } else {
        throw "Error";
      }
    } catch (e) {
      _rxUiError.value = 'Error ao carregar dados';
      _rxNavigateTo.value = "/register";
    }
  }

  @override
  void deleteRoom(RoomEntity room) async {
    await localRoom.delete(room);
    var list = await localRoom.listOfRooms();
    if (list != null) {
      _rxListRoom.value.removeWhere((element) =>
          element.name == room.name && element.password == room.password);
      _rxListRoom.refresh();
      _rxListRoomCopy.value = list.listRoom;
    }
  }

  @override
  Future<void> loadRooms() async {
    try {
      _preferencesEntity = await preferences.getData();

      _rxUser.value = UserEntity(
          name: _preferencesEntity.nick, hash: _preferencesEntity.nick);

      RoomsEntity? list = await localRoom.listOfRooms();
      DateTime today = DateTime.now();
      if (list != null) {
        list.listRoom.removeWhere((element) =>
            element.master != _preferencesEntity.nick &&
            today.millisecondsSinceEpoch > int.parse(element.expirateAt!));
        _rxListRoom.value = list.listRoom;
        _rxListRoom.refresh();
        _rxListRoomCopy.value = list.listRoom;
      } else {
        _rxListRoom.value = [];
      }
    } catch (e) {
      _rxUiError.value = 'Error ao carregar salas';
    }
  }

  @override
  Future<void> createRoom(String name) async {
    try {
      await loadRooms();
      _preferencesEntity = await preferences.getData();
      _rxUser.value = _rxUser.value = UserEntity(
          name: _preferencesEntity.nick, hash: _preferencesEntity.nick);
      /* if (master != null) {
        await localRoom.newRoom(
            nameRoom: name,
            master: _preferencesEntity.,
            masterHash:"",
           expirateAt: (_preferencesEntity.timer + DateTime.now().millisecondsSinceEpoch)
                .toString());
      } else { */
      await localRoom.newRoom(
          nameRoom: name,
          password: "",
          master: _preferencesEntity.nick,
          masterHash: _preferencesEntity.hash,
          expirateAt:
              (_preferencesEntity.timer + DateTime.now().millisecondsSinceEpoch)
                  .toString());
      /* } */
      var list = await localRoom.listOfRooms();
      _rxListRoom.value = list.listRoom;
      _rxListRoomCopy.value = list.listRoom;
    } catch (e) {
      _rxUiError.value = "Erro ao salvar sala";
    }
  }

  @override
  Future<void> saveRooms(RoomEntity room) async {
    if (room.master != _preferencesEntity.nick &&
        room.masterHash != _preferencesEntity.hash) {
      await localRoom.save(room);
    }
  }

  @override
  Future<void> enterRoom(String code) async {
    _rxNavigateTo.value = null;
    _rxUiError.value = null;
    try {
      _preferencesEntity = await preferences.getData();
      _rxUser.value = UserEntity(
          name: _preferencesEntity.nick, hash: _preferencesEntity.nick);
      var userS = encryterMessage.encryterUser(UserEntity(
          name: _preferencesEntity.nick, hash: _preferencesEntity.hash));
      var roomS = encryterMessage.getRoomLink(code);
      if (_preferencesEntity.nick.isNotEmpty || roomS == null) {
        _rxUser.value = UserEntity(
            name: _preferencesEntity.nick, hash: _preferencesEntity.nick);
      } else {
        _rxUiError.value = "Sala Inválida!";
        throw "Error";
      }

      if (roomS?.master == _preferencesEntity.nick) {
        _rxUiError.value = "Você não pode entrar na sua sala como convidado!";
      } else {
        // Verifica se a sala não já esta expirada
        DateTime today = DateTime.now();
        if (int.parse(roomS!.expirateAt!) > today.millisecondsSinceEpoch) {
          localRoom.save(roomS);
          _rxNavigateTo.value = "/chat/${userS!}/$code";
        } else {
          _rxUiError.value = "Sala expirada!";
        }
      }
    } catch (e) {
      _rxUiError.value = "Sala não encontrada!";
    }
  }

  @override
  void goChat(RoomEntity room) async {
    _preferencesEntity = await preferences.getData();
    UserEntity user = UserEntity(
        name: _preferencesEntity.nick, hash: _preferencesEntity.hash);
    _rxUser.value = UserEntity(
        name: _preferencesEntity.nick, hash: _preferencesEntity.nick);
    _rxNavigateTo.value = null;

    ///Se a sala ainda não expirou
    if (int.parse(room.expirateAt ?? "0") >
        DateTime.now().millisecondsSinceEpoch) {
      var roomS = encryterMessage.getLinkRoom(room);
      var userS = encryterMessage.encryterUser(user);
      _rxNavigateTo.value = "/chat/${userS!}/$roomS";
    } else {
      //Atualiza a sala com o novo valor
      RoomEntity? roomT = await localRoom.refreshTime(
          room,
          (DateTime.now().millisecondsSinceEpoch + _preferencesEntity.timer)
              .toString());
      if (roomT != null) {
        ///Se a sala expirou mas deu certo atualizar
        var roomS = encryterMessage.getLinkRoom(roomT);
        var userS = encryterMessage.encryterUser(user);
        _rxNavigateTo.value = "/chat/${userS!}/$roomS";
      } else {
        _rxUiError.value = "Sala expirada";
        deleteRoom(room);
      }
    }

    loadRooms();
  }

  @override
  void goTo(String route) {
    Get.toNamed(route);
    /* preferences.reset();
    localRoom.deleteAll();
    Get.offAndToNamed('/register'); */
  }

  @override
  void filterRoom(String value) {
    if (value != "") {
      _rxListRoom.value = _rxListRoomCopy.value.where((element) {
        return element.name.toUpperCase().contains(value.toUpperCase());
      }).toList();
    } else {
      _rxListRoom.value = _rxListRoomCopy.value.toList();
    }
    _rxListRoom.refresh();
  }

  @override
  void returnFilterRoom() {
    _rxListRoom.value = _rxListRoomCopy.value.toList();
    _rxIsSearching.value = false;
  }

  @override
  void seaching(bool value) {
    _rxIsSearching.value = value;
  }

  @override
  bool validadePassword(String password) {
    if (_preferencesEntity.password == password) {
      return true;
    }
    return false;
  }

  @override
  void requiredContacts(Function f) async {
    bool confirm = false;
    bool teste = await wasAllowedContacts();
    _rxUiError.value = null;
    if (teste) {
      await f.call();
    } else {
      confirm = await askPermissions();
    }

    if (!confirm && !teste) {
      _rxUiError.value = "É nescessario permissão á lista de contatos!";
    }
  }

  @override
  Future<String> getCodeRoom(RoomEntity room) async {
    await loadRooms();
    var roomS = encryterMessage.getLinkRoom(room);
    String link = "$roomS";
    return link;
  }

  @override
  Future<bool> accountValid() async {
    PreferencesEntity p = await preferences.getData();
    if (int.parse(p.expirationCode) < DateTime.now().millisecondsSinceEpoch) {
      await Get.dialog(
          Dialog(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Seu código expirou!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Text("Entre em contato com o seu fornecedor."),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          preferences.reset();
                          localRoom.deleteAll();
                          Get.offAndToNamed('/register');
                        },
                        child: Text(
                          "Apagar tudo!",
                          style: TextStyle(color: Colors.red[700]),
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          var t = await Get.toNamed('/expirate');
                          if (t != null && t == true) {
                            Get.back();
                          }
                        },
                        child: const Text("Inserir outro código"))
                  ],
                )
              ],
            ),
          )),
          barrierDismissible: false);
      return false;
    }
    return true;
  }

  @override
  String get userName => _preferencesEntity.nick;
}
