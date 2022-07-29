import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/resgister/register.dart';
import '../../usecases/usescases.dart';

Widget makeRegisterPage() {
  return RegisterPage(presenter: makeGetxRegisterPresenter());
}

RegisterPresenter makeGetxRegisterPresenter() =>
    GetxRegisterPresenter(preferences: makeGetPreferencesStorage());
