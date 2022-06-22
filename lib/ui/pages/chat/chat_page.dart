import 'package:chat_flutter/data/usecase/autentication_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'chat_controller.dart';
import 'components/components.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final BlockAuthController _authController = BlockAuthController();
  String? nick;
  ChatController controller = ChatController();

  @override
  void initState() {
    nick = Get.arguments['nick'];
    controller.init(nick);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() async {
    controller.disp();
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _authController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.resume();

        break;
      case AppLifecycleState.inactive:
        controller.inactive();
        break;
      case AppLifecycleState.detached:
        controller.disp();
        break;
      default:
    }
  }

  void _send() {
    if (_textController.text.isNotEmpty) {
      controller.send(_textController.text, nick!);
      _textController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => controller,
      child: BlockAuth(
        controller: _authController,
        body: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            title: const AppBarSender(),
            actions: [
              IconButton(
                  onPressed: () async {
                    _authController.verify(true);
                  },
                  icon: const Icon(Icons.security))
            ],
          ),
          body: Builder(builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: FocusScope.of(context).unfocus,
                    child: ListMessage(
                      stream: controller.listMessagesStream,
                      nick: nick ?? "",
                    ),
                  ),
                ),
                FooterMessage(controller: _textController, sendMessage: _send)
              ],
            );
          }),
        ),
      ),
    );
  }
}
