import 'package:get/get.dart';

mixin NavigationManagerLogin {
  void handleNaviationLogin(Stream<String> stream) {
    stream.listen((event) {
      Get.offNamed(event);
    });
  }
}
