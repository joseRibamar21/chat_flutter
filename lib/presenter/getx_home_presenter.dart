import 'package:get/get.dart';

import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../infra/cache/cache.dart';
import '../ui/pages/home/home.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final SecureStorage secureStorage;
  final LocalRoom localRoom;
  GetxHomePresenter({required this.secureStorage, required this.localRoom});

  final _rxUiError = Rx<String>("");
  final _rxName = Rx<String>("");
  final _rxListRoom = Rx<List<RoomEntity>>([]);
  final _rxIsLoading = Rx<bool>(false);
  final _rxNavigateTo = Rx<String>("");

  @override
  Stream<String> get nameStream => _rxName.stream;

  @override
  Stream<List<RoomEntity>> get listRoomStream => _rxListRoom.stream;

  @override
  void inicialization() async {
    try {
      String pre = await secureStorage.readSecureData('name');
      var list = await localRoom.listRoom();
      if (list != null) {
        _rxListRoom.value = list.listRoom;
      } else {
        _rxListRoom.value = [];
      }
      _rxName.value = pre;
    } catch (e) {
      _rxUiError.value = 'Error ao carregar dados';
      _rxNavigateTo.value = "/register";
    }

    _rxListRoom.refresh();
  }

  @override
  void deleteRoom(String name, String password) async {
    await localRoom.delete(RoomEntity(name: name, password: password));
    var list = await localRoom.listRoom();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    }
  }

  @override
  Future<void> loadRooms() async {
    try {
      var list = await localRoom.listRoom();
      if (list != null) {
        _rxListRoom.value = list.listRoom;
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
      var list = await localRoom.listRoom();
      _rxListRoom.value = list.listRoom;
    } catch (e) {
      _rxUiError.value = "Erro ao salvar sala";
    }
  }

  @override
  Future<void> searchRoom(String link) async {
    /* var roomS = localRoom.getRoomFromLink(link);
    if (roomS != null) {
      saveRooms(roomS.name, roomS.password);
    } */
  }
}
