import 'dart:math';

import 'package:get/get.dart';

import '../../../data/usecase/usecase.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecase/usecase.dart';
import '../../../factories.dart/cache/cache.dart';
import '../../../infra/cache/cache.dart';

class HomeController extends GetxController {
  final _rxName = Rx<String>("");
  final _rxListRoom = Rx<List<RoomEntity>>([]);

  final LocalPreferences preferences = makePreferences();
  final SecureStorage secureStorage = SecureStorage();
  final RoomsStorage roomsStorage = RoomsStorage();

  Stream<String> get nameStream => _rxName.stream;
  Stream<List<RoomEntity>> get listRoomStream => _rxListRoom.stream;

  void inicialization() async {
    String pre = await secureStorage.readSecureData('name');
    try {
      var list = await roomsStorage.getRooms();
      if (list != null) {
        _rxListRoom.value = list.listRoom;
      } else {
        _rxListRoom.value = [];
      }
    } catch (e0) {}

    _rxListRoom.refresh();
    _rxName.value = pre;
  }

  Future<void> saveRooms(String name, String? password) async {
    var rng = Random();
    String p;
    if (password == null) {
      p = rng.nextInt(999999999).toString();
    } else {
      p = password;
    }
    await roomsStorage.saveRoom(name, p);
    var list = await roomsStorage.getRooms();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    } else {
      _rxListRoom.value = [];
    }
  }

  Future<void> searchRoom(String link) async {
    var roomS = roomsStorage.getRoomFromLink(link);
    if (roomS != null) {
      saveRooms(roomS.name, roomS.password);
    }
  }

  Future<void> loadRooms() async {
    await roomsStorage.getRooms();
  }

  void deleteRoom(String name, String password) async {
    await roomsStorage.deleteRoom(name, password);
    var list = await roomsStorage.getRooms();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    }
  }

  String get nick => _rxName.value;
}
