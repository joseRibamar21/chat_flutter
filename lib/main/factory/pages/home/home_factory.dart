import 'package:chat_flutter/infra/cache/cache.dart';
import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/home/home.dart';
import '../../usecases/usescases.dart';

Widget makeHomePage() {
  return HomePage(presenter: makeGetxHomePresenter());
}

HomePresenter makeGetxHomePresenter() => GetxHomePresenter(
    localRoom: makeGetLocalRooms(),
    secureStorage: SecureStorage(),
    encryterMessage: makeEncryptRoomMask(),
    preferences: makeGetPreferencesStorage());
