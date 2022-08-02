import 'package:get/get.dart';

import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../infra/cache/cache.dart';
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

  final _rxUiError = Rx<String>("");
  final _rxName = Rx<String>("");
  final _rxListRoom = Rx<List<RoomEntity>>([]);
  final _rxListRoomCopy = Rx<List<RoomEntity>>([]);
  final _rxIsSearching = Rx<bool>(false);
  final _rxNavigateTo = Rx<String?>("");

  @override
  Stream<bool> get isSeachingStream => _rxIsSearching.stream;

  @override
  Stream<String> get nameStream => _rxName.stream;

  @override
  Stream<List<RoomEntity>> get listRoomStream => _rxListRoom.stream;

  @override
  Stream<String?> get navigatorStream => _rxNavigateTo.stream;

  @override
  void inicialization() async {
    try {
      PreferencesEntity p = await preferences.getData();
      if (p.nick.isNotEmpty) {
        _rxName.value = p.nick;
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
    await localRoom
        .delete(RoomEntity(name: name, password: password, master: ""));
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
  Future<void> saveRooms(String name, String? password, String? master) async {
    try {
      if (master != null) {
        await localRoom.newRoom(name, master);
      } else {
        await localRoom.newRoom(name, _rxName.value);
      }
      var list = await localRoom.listOfRooms();
      _rxListRoom.value = list.listRoom;
    } catch (e) {
      _rxUiError.value = "Erro ao salvar sala";
    }
  }

  @override
  Future<void> searchRoom(String link) async {
    var roomS = encryterMessage.getRoomLink(link);
    if (roomS != null) {
      await localRoom.save(roomS);
    }
    var list = await localRoom.listOfRooms();
    _rxListRoom.value = list.listRoom;
  }

  @override
  void goChat(RoomEntity room) {
    var roomS = encryterMessage.getLinkRoom(room);
    _rxNavigateTo.value = null;
    _rxNavigateTo.value = "/chat/${_rxName.value}/$roomS";
  }

  @override
  void goRegister() {
    preferences.reset();
    Get.offAndToNamed('/register');
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
}
