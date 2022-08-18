import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/config/config.dart';
import '../../usecases/usescases.dart';

Widget makeConfigPage() {
  return ConfigPage(presenter: makeGetxConfigPresenter());
}

ConfigPresenter makeGetxConfigPresenter() {
  return GetxConfigPresenter(
      localRoom: makeGetLocalRooms(), preferences: makeGetPreferencesStorage());
}
