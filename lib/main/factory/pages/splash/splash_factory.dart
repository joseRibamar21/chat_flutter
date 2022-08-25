import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/splash/splash.dart';
import '../../usecases/usescases.dart';

Widget makeSplashPage() {
  if (kIsWeb) {
    return SplashPage(
      presenter: makeGetxSplashWebPresenter(),
    );
  } else {
    return SplashPage(
      presenter: makeGetxSplashPresenter(),
    );
  }
}

SplashPresenter makeGetxSplashPresenter() {
  return GetxSplashPresenter(preferences: makeGetPreferencesStorage());
}

SplashPresenter makeGetxSplashWebPresenter() {
  return GetxSplashPresenterWeb();
}
