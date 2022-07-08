// ignore_for_file: unused_field

import 'package:get/get.dart';

import '../../domain/usecase/usecase.dart';
import '../../ui/pages/resgister/register.dart';

class GetxRegisterPresenter extends GetxController
    implements RegisterPresenter {
  final LocalPreferences preferences;

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
      preferences.setName(name: _name);
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
    }
    _rxIsLoading.value = false;
    _rxNavigateTo.value = "/home";
  }

  @override
  void validadeName(String value) {
    _name = value;
  }
}
