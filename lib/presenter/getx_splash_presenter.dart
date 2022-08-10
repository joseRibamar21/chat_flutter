import 'package:get/get.dart';

import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../ui/components/permissions/permissions.dart';
import '../ui/pages/splash/splash.dart';

class GetxSplashPresenter extends GetxController implements SplashPresenter {
  final LocalPreferences preferences;

  GetxSplashPresenter({required this.preferences});

  final _rxUiError = Rx<String>("");
  final _rxNaviagation = Rx<String?>("");

  @override
  Stream<String?> get toNavigationStream => _rxNaviagation.stream;

  @override
  void inicialization() async {
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      await askPermissions();
      try {
        PreferencesEntity p = await preferences.getData();
        if (p.nick.isNotEmpty && p.password.isNotEmpty) {
          _rxNaviagation.value = "/home";
        } else {
          _rxNaviagation.value = "/register";
        }
      } catch (e) {
        _rxUiError.value = "Erro ao carregar dados!";
        _rxNaviagation.value = "/register";
      }
    });
  }
}
