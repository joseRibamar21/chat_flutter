// ignore_for_file: unused_field

import 'package:get/get.dart';

import '../../domain/usecase/usecase.dart';
import '../../infra/cache/cache.dart';
import '../../ui/pages/resgister/register.dart';

class GetxRegisterPresenter extends GetxController
    implements RegisterPresenter {
  final LocalPreferences preferences;
  final SecureStorage secureStorage = SecureStorage();

  GetxRegisterPresenter({required this.preferences});

  final _rxNavigateTo = Rx<String>("");
  final _rxUiError = Rx<String>("");
  final _rxIsLoading = Rx<bool>(false);

  String _name = "";

  @override
  Stream<bool> get isLoading => _rxIsLoading.stream;

  @override
  Stream<String> get navigationStream => _rxNavigateTo.stream;

  @override
  Stream<String> get uiErrorStream => _rxUiError.stream;

  @override
  void register() async {
    _rxIsLoading.value = true;
    try {
      await secureStorage.writeSecureData('name', _name);
      _rxNavigateTo.value = "/home";
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
    }
    _rxIsLoading.value = false;
  }

  @override
  void validadeName(String value) {
    _name = value;
  }

  @override
  void inicialization() async {
    String? t = await secureStorage.readSecureData('name');
    if (t != null) {
      _rxNavigateTo.value = "/home";
    }
  }
}
