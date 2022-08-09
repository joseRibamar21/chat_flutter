import 'package:get/get.dart';

mixin NavigationManager {
  void handleNaviationLogin(Stream<String?> stream) {
    stream.listen((event) {
      if (event != null) {
        Get.offNamed(event);
      }
    });
  }

  void handleNaviationPush(Stream<String?> stream) {
    stream.listen((event) {
      if (event != null) {
        Get.toNamed(event);
      }
    });
  }
}
