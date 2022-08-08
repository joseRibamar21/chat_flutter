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
  final _rxPasswordError = Rx<String?>("");
  final _rxIsLoading = Rx<bool>(false);

  String _name = "";
  String _password = "";

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
  Stream<String?> get passwordErrorStream => _rxPasswordError.stream;

  @override
  Future<bool> register() async {
    _rxIsLoading.value = true;
    _name = _name.trim();
    _name = _name.replaceAll(" ", "_");
    _password = _password.trim();
    _password = _password.replaceAll(" ", "");
    await preferences.setName(name: _name);
    await preferences.setPassword(password: _password);
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
      if (p.nick.isNotEmpty && p.password.isNotEmpty) {
        _rxNavigateTo.value = "/home";
      }
    } catch (e) {
      _rxUiError.value = "Erro ao carregar dados!";
    }
  }

  _isFormValid() {
    _rxValid.value = _name.isNotEmpty &&
        _password.isNotEmpty &&
        _rxNameError.value == null &&
        _rxPasswordError.value == null &&
        !(_rxIsLoading.value == true);
  }

  @override
  void validadePassword(String value) {
    _password = value;

    int? validade = int.tryParse(value);

    if (validade == null) {
      _rxPasswordError.value = "Apenas valores interios!";
    } else {
      if (_password.length < 3) {
        _rxPasswordError.value = "A senha deve ter mais que 2 dígitos!";
      } else {
        if (_password.length > 7) {
          _rxPasswordError.value = "O codinome deve no máximo 6 caracteres!";
        } else {
          _rxPasswordError.value = null;
        }
      }
    }
    _password.replaceAll(" ", "_");
    _isFormValid();
  }
}
