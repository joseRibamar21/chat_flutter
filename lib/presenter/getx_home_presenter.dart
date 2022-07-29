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
  //final _rxIsLoading = Rx<bool>(false);
  final _rxNavigateTo = Rx<String?>("");

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
  void deleteRoom(String name, String password) async {
    await localRoom.delete(RoomEntity(name: name, password: password));
    var list = await localRoom.listOfRooms();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    }
  }

  @override
  Future<void> loadRooms() async {
    try {
      var list = await localRoom.listOfRooms();
      if (list != null) {
        _rxListRoom.value = list.listRoom;
        _rxListRoom.refresh();
      } else {
        _rxListRoom.value = [];
      }
    } catch (e) {
      _rxUiError.value = 'Error ao carregar salas';
    }
  }

  @override
  Future<void> saveRooms(String name, String? password) async {
    try {
      await localRoom.newRoom(name);
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
      saveRooms(roomS.name, roomS.password);
    }
  }

  @override
  void goChat(RoomEntity room) {
    _rxNavigateTo.value = null;
    _rxNavigateTo.value =
        "/chat/${_rxName.value}/${room.name}/${room.password}";
  }

  @override
  void goRegister() {
    preferences.reset();
    Get.offAndToNamed('/register');
  }
}
