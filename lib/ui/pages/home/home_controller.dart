import 'package:get/get.dart';

import '../../../data/usecase/usecase.dart';
import '../../../domain/usecase/usecase.dart';
import '../../../factories.dart/cache/cache.dart';
import '../../../infra/cache/cache.dart';

class HomeController extends GetxController {
  final _rxName = Rx<String>("");
  final LocalPreferences preferences = makePreferences();
  final SecureStorage secureStorage = SecureStorage();
  final RoomsStorage roomsStorage = RoomsStorage();

  Stream<String> get nameStream => _rxName.stream;

  void inicialization() async {
    String pre = await secureStorage.readSecureData('name');

    _rxName.value = pre;
  }

  Future<void> saveRooms() async {
    await roomsStorage.getRooms();
    await roomsStorage.saveRoom("Teste", "password");
  }

  Future<void> loadRooms() async {
    await roomsStorage.getRooms();
  }
}
