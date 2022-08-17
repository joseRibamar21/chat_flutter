import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/config/config.dart';

Widget makeConfigPage() {
  return ConfigPage(presenter: makeGetxConfigPresenter());
}

ConfigPresenter makeGetxConfigPresenter() {
  return GetxConfigPresenter();
}
