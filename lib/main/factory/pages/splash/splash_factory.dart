import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/splash/splash.dart';

Widget makeSplashPage() {
  return SplashPage(
    presenter: makeGetxSplashPresenter(),
  );
}

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter();
}
