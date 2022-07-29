import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/resgister/register.dart';
import '../../../../ui/pages/web/web.dart';
import '../../usecases/usescases.dart';

Widget makeRegisterPage(BuildContext context) {
  /// Verifica se a aplicacao esta rodadando em web
  if (kIsWeb) {
    return RegisterPageWeb(presenter: makeGetxRegisterPresenterWeb());
  } else {
    return RegisterPage(presenter: makeGetxRegisterPresenter());
  }
}

/// Controller da pagina de registro
RegisterPresenter makeGetxRegisterPresenter() =>
    GetxRegisterPresenter(preferences: makeGetPreferencesStorage());

/// Controller da pagina de registro web
RegisterPresenterWeb makeGetxRegisterPresenterWeb() =>
    GetxRegisterPresenterWeb(encryterMessage: makeEncryptRoomMask());
