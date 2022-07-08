import 'package:get/get.dart';

mixin NavigationManager {
  void handleNaviation(Stream<String> stream) {
    stream.listen((event) {
      Get.offAndToNamed(event);
    });
  }
}
