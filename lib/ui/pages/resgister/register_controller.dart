// ignore_for_file: unused_field

import 'package:get/get.dart';

import '../../../infra/cache/cache.dart';

class RegisterController extends GetxController {
  final SecureStorage secureStorage = SecureStorage();

  final _rxNavigateTo = Rx<String>("");
  final _rxUiError = Rx<String>("");
  final _rxIsLoading = Rx<bool>(false);

  String _name = "";

  Stream<bool> get isLoading => _rxIsLoading.stream;

  Stream<String> get navigationStream => _rxNavigateTo.stream;

  Stream<String> get uiErrorStream => _rxUiError.stream;

  Future<bool> register() async {
    _rxIsLoading.value = true;
    try {
      await secureStorage.writeSecureData('name', _name);
      // _rxNavigateTo.value = "/home";
      _rxIsLoading.value = false;
      return true;
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
      _rxIsLoading.value = false;
      return false;
    }
  }

  void validadeName(String value) {
    _name = value;
  }

  void inicialization() async {
    String? t = await secureStorage.readSecureData('name');
    if (t != null) {
      _rxNavigateTo.value = "/home";
    }
  }
}
