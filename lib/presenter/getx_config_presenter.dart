import 'package:get/get.dart';

import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../ui/pages/pages.dart';

class GetxConfigPresenter extends GetxController implements ConfigPresenter {
  final LocalRoom localRoom;
  final LocalPreferences preferences;

  GetxConfigPresenter({required this.localRoom, required this.preferences});

  @override
  void logoff() {
    preferences.reset();
    localRoom.deleteAll();
    Get.offAndToNamed('/register');
  }

  @override
  Future updateTime(int h, int m) async {
    int newtime = (h * 60 * 60 * 1000) + (m * 60 * 1000);
    await preferences.setTime(time: newtime);
  }

  @override
  Future<Map<String, dynamic>> getTime() async {
    PreferencesEntity preferencesEntity = await preferences.getData();

    double h = (preferencesEntity.timer / (60 * 60 * 1000)).toDouble();

    double m = (h - h.floorToDouble()) * 60;

    return {"h": h.floorToDouble(), "m": m.floorToDouble()};
  }

  @override
  Future<String> getName() async {
    PreferencesEntity preferencesEntity = await preferences.getData();
    return preferencesEntity.nick;
  }

  @override
  Future<void> updateName(String codiname) async {
    localRoom.updateAllRoomsMaster(codiname);
    await preferences.setName(name: codiname);
  }
}
