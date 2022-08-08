import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/chat/chat.dart';
import '../../../../ui/pages/web/chat/chat.dart';
import '../../socket/socket.dart';
import '../../usecases/usescases.dart';

Widget makeChatPage() {
  if (!kIsWeb) {
    return ChatPage(presenter: makeGetxChatPresenter());
  } else {
    return ChatPageWeb(presenter: makeGetxChatPresenterWeb());
  }
}

ChatPresenter makeGetxChatPresenter() => GetxChatPresenter(
    socket: makeSocketIO(),
    encryterMessage: makeEncryptRoomMask(),
    preferences: makeGetPreferencesStorage());

ChatWebPresenter makeGetxChatPresenterWeb() => GetxChatWebPresenter(
    socket: makeSocketIO(), encryterMessage: makeEncryptRoomMask());
