import 'package:get/get.dart';

import '../domain/usecase/usecase.dart';
import '../ui/pages/web/resgister/register.dart';

class GetxRegisterPresenterWeb extends GetxController
    implements RegisterPresenterWeb {
  final EncryterMessage encryterMessage;
  GetxRegisterPresenterWeb({required this.encryterMessage});

  final _rxNavigateTo = Rx<String?>("");
  final _rxUiError = Rx<String?>("");
  final _rxValid = Rx<bool>(false);
  final _rxNameError = Rx<String?>("");
  final _rxIsLoading = Rx<bool>(false);

  String _name = "";
  String _link = "";

  @override
  Stream<bool> get isLoading => _rxIsLoading.stream;
  @override
  Stream<bool> get isValidStream => _rxValid.stream;
  @override
  Stream<String?> get navigationStream => _rxNavigateTo.stream;
  @override
  Stream<String?> get uiErrorStream => _rxUiError.stream;
  @override
  Stream<String?> get nameErrorStream => _rxNameError.stream;

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

  _isFormValid() {
    _rxValid.value = _name.isNotEmpty &&
        _rxNameError.value == null &&
        !(_rxIsLoading.value == true);
  }

  @override
  void goToChatGenerate() {
    _name = _name.trim();
    _name = _name.replaceAll(" ", "_");
  }

  @override
  void goToChatLink() {
    _rxNavigateTo.value = null;
    _rxUiError.value = null;
    _name = _name.trim();
    _name = _name.replaceAll(" ", "_");
    try {
      var room = encryterMessage.getRoomLink(_link);
      if (room != null) {
        _rxNavigateTo.value = _rxNavigateTo.value = "/chat/$_name/$_link";
      } else {
        _rxUiError.value = "Sala inválida ou expirada!";
      }
    } catch (e) {
      _rxUiError.value = "Sala inválida ou expirada!";
    }
  }

  @override
  void validadeLink(String value) {
    _link = value;
  }
}