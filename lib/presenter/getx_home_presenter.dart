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
  final _rxName = Rx<String>("");
  final _rxListRoom = Rx<List<RoomEntity>>([]);
  final _rxListRoomCopy = Rx<List<RoomEntity>>([]);
  final _rxIsSearching = Rx<bool>(false);
  final _rxNavigateTo = Rx<String?>("");
  late PreferencesEntity _preferencesEntity;

  @override
  Stream<bool> get isSeachingStream => _rxIsSearching.stream;

  @override
  Stream<String> get nameStream => _rxName.stream;

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
        _rxName.value = _preferencesEntity.nick;
      } else {
        throw "Error";
      }
    } catch (e) {
      _rxUiError.value = 'Error ao carregar dados';
      _rxNavigateTo.value = "/register";
    }
  }

  @override
  void deleteRoom(
    String name,
    String password,
  ) async {
    await localRoom.delete(RoomEntity(
        name: name, password: password, master: "", expirateAt: null));
    var list = await localRoom.listOfRooms();
    if (list != null) {
      _rxListRoom.value.removeWhere(
          (element) => element.name == name && element.password == password);
      _rxListRoom.refresh();
      _rxListRoomCopy.value = list.listRoom;
    }
  }

  @override
  Future<void> loadRooms() async {
    try {
      var list = await localRoom.listOfRooms();
      if (list != null) {
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
  Future<void> saveRooms(String name, String? master) async {
    try {
      if (master != null) {
        await localRoom.newRoom(
            name,
            master,
            (_preferencesEntity.timer + DateTime.now().millisecondsSinceEpoch)
                .toString());
      } else {
        await localRoom.newRoom(
            name,
            _rxName.value,
            (_preferencesEntity.timer + DateTime.now().millisecondsSinceEpoch)
                .toString());
      }
      var list = await localRoom.listOfRooms();
      _rxListRoom.value = list.listRoom;
      _rxListRoomCopy.value = list.listRoom;
    } catch (e) {
      _rxUiError.value = "Erro ao salvar sala";
    }
  }

  @override
  Future<void> enterRoom(String link) async {
    _rxNavigateTo.value = null;
    try {
      List<String> list = link.split("/");
      if (list.length == 1) {
        var roomS = encryterMessage.getRoomLink(list[0]);
        if (roomS != null) {
          _rxNavigateTo.value = "/chat/${_rxName.value}/${list[0]}";
        }
      } else {
        var roomS = encryterMessage.getRoomLink(list[4]);
        if (roomS != null) {
          if (roomS.master == _rxName.value) {
            _rxUiError.value =
                "Você não pode entrar na sua sala como convidado!";
          } else {
            _rxNavigateTo.value = "/chat/${list[3]}/${list[4]}";
          }
        }
      }
    } catch (e) {
      _rxUiError.value = "Sala não encontrada!";
    }
  }

  @override
  void goChat(RoomEntity room) async {
    _rxNavigateTo.value = null;

    ///Se a sala ainda não expirou
    if (int.parse(room.expirateAt ?? "0") >
        DateTime.now().millisecondsSinceEpoch) {
      var roomS = encryterMessage.getLinkRoom(room);
      _rxNavigateTo.value = "/chat/${_rxName.value}/$roomS";
    } else {
      //Atualiza a sala com o novo valor
      RoomEntity? roomT = await localRoom.refreshTime(
          room,
          (DateTime.now().millisecondsSinceEpoch + _preferencesEntity.timer)
              .toString());
      if (roomT != null) {
        ///Se a sala expirou mas deu certo atualizar
        var roomS = encryterMessage.getLinkRoom(roomT);
        _rxNavigateTo.value = "/chat/${_rxName.value}/$roomS";
      } else {
        _rxUiError.value = "Sala expirada";
        deleteRoom(room.name, room.password);
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
  String getLinkRoom(RoomEntity room) {
    var roomS = encryterMessage.getLinkRoom(room);
    String link = "143.244.167.43/#/chat/${room.name}/$roomS";
    return link;
  }
}
