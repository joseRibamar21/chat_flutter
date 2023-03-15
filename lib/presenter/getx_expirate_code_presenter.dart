import 'package:get/get.dart';

import '../domain/usecase/usecase.dart';
import '../main/factory/usecases/usescases.dart';
import '../ui/pages/expirate_code/expirate_code_presenter.dart';

class GetxExpirateCodePresenter extends GetxController
    implements ExpirateCodePresenter {
  final _rxCodeError = Rx<String?>(null);
  String _code = "";

  final LocalPreferences preferences = makeGetPreferencesStorage();

  @override
  Stream<String?> get codeErrorStream => _rxCodeError.stream;

  @override
  void validadeCode(String value) {
    _code = value;
    if (value.isEmpty) {
      _rxCodeError.value = "Campo vazio.";
    } else {
      _rxCodeError.value = null;
    }
  }

  @override
  Future<bool> verifyCode() async {
    DateTime now = DateTime.now();

    switch (_code) {
      case "dev123":
        int timeExpire = now.millisecondsSinceEpoch + (24 * 60 * 60 * 1000);
        preferences.setCode(code: _code, expiration: timeExpire.toString());
        Get.back(result: true);
        break;
      case "000000":
        int timeExpire = 0;
        preferences.setCode(code: _code, expiration: timeExpire.toString());
        Get.back(result: false);
        break;
      default:
        int timeExpire = 0;
        preferences.setCode(code: _code, expiration: timeExpire.toString());
        Get.back(result: false);
    }
    return true;
  }
}
