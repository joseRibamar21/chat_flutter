import 'package:get/get.dart';

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
}
