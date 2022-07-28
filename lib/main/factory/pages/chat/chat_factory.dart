import 'package:chat_flutter/presenter/presenter.dart';
import 'package:flutter/material.dart';

import '../../../../ui/pages/chat/chat.dart';
import '../../socket/socket.dart';

Widget makeChatPage() => ChatPage(
      presenter: makeGetxChatPresenter(),
    );

ChatPresenter makeGetxChatPresenter() =>
    GetxChatPresenter(socket: makeSocketIO());
