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
    var list = await roomsStorage.getRooms();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    }

    _rxName.value = pre;
  }

  Future<void> saveRooms(String name, String password) async {
    await roomsStorage.saveRoom(name, password);
    var list = await roomsStorage.getRooms();
    if (list != null) {
      _rxListRoom.value = list.listRoom;
    }
  }

  Future<void> loadRooms() async {
    await roomsStorage.getRooms();
  }

  String get nick => _rxName.value;
}
