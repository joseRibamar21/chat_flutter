import 'package:flutter/material.dart';

import '../../../../presenter/presenter.dart';
import '../../../../ui/pages/chat/chat.dart';
import '../../socket/socket.dart';
import '../../usecases/usescases.dart';

Widget makeChatPage() => ChatPage(
      presenter: makeGetxChatPresenter(),
    );

ChatPresenter makeGetxChatPresenter() => GetxChatPresenter(
    socket: makeSocketIO(), encryterMessage: makeEncryptRoomMask());
