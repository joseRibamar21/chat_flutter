import 'package:get/get.dart';

import '../../../infra/cache/cache.dart';
import '../domain/entities/entities.dart';
import '../domain/usecase/usecase.dart';
import '../ui/pages/resgister/register.dart';

class GetxRegisterPresenter extends GetxController
    implements RegisterPresenter {
  final LocalPreferences preferences;
  final SecureStorage secureStorage = SecureStorage();

  GetxRegisterPresenter({required this.preferences});

  final _rxNavigateTo = Rx<String>("");
  final _rxUiError = Rx<String>("");
  final _rxValid = Rx<bool>(false);
  final _rxNameError = Rx<String?>("");
  final _rxIsLoading = Rx<bool>(false);

  String _name = "";

  @override
  Stream<bool> get isLoading => _rxIsLoading.stream;
  @override
  Stream<bool> get isValidStream => _rxValid.stream;
  @override
  Stream<String> get navigationStream => _rxNavigateTo.stream;
  @override
  Stream<String> get uiErrorStream => _rxUiError.stream;
  @override
  Stream<String?> get nameErrorStream => _rxNameError.stream;

  @override
  Future<bool> register() async {
    _rxIsLoading.value = true;

    await preferences.setName(name: _name);
    _rxNavigateTo.value = "/home";
    _rxIsLoading.value = false;
    return true;
  }

  @override
  void validadeName(String value) {
    _name = value;
    bool nameValid = RegExp(r'[^\w\s]+').hasMatch(value);
    if (nameValid) {
      _rxNameError.value = "Não permitido caracteres especiais!";
    } else {
      if (_name.length < 3) {
        _rxNameError.value = "O codinome deve ter mais que 2 caracteres!";
      } else {
        if (_name.length > 50) {
          _rxNameError.value = "O codinome deve ter menos que 50 caracteres!";
        } else {
          _rxNameError.value = null;
        }
      }
    }
    _name.replaceAll(" ", "_");
    _isFormValid();
  }

  @override
  void inicialization() async {
    try {
      PreferencesEntity p = await preferences.getData();
      if (p.nick.isNotEmpty) {
        _rxNavigateTo.value = "/home";
      }
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
    }
  }

  _isFormValid() {
    _rxValid.value = _name.isNotEmpty &&
        _rxNameError.value == null &&
        !(_rxIsLoading.value == true);
  }
}
