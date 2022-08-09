import 'package:chat_flutter/ui/components/permissions/permissions.dart';
import 'package:get/get.dart';

import '../ui/pages/splash/splash.dart';

class GetxSplashPresenter extends GetxController implements SplashPresenter {
  final _rxNaviagation = Rx<String?>("");

  @override
  Stream<String?> get toNavigationStream => _rxNaviagation.stream;

  @override
  void inicialization() async {
    await Future.delayed(const Duration(milliseconds: 1000), () async  {
      await askPermissions();
      _rxNaviagation.value = '/register';
    });
  }
}
