import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';
import 'components/components.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  String? nick;
  ChatController controller = ChatController();

  @override
  void initState() {
    controller.init();
    nick = Get.arguments['nick'];
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller.disp();
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {}
  }

  void _send() {
    if (_textController.text.isNotEmpty) {
      controller.send(_textController.text, nick!);
      _textController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nick!),
        actions: [
          IconButton(onPressed: controller.teste, icon: Icon(Icons.abc))
        ],
      ),
      body: Builder(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ListMessage(
                stream: controller.listMessagesStream,
                nick: nick ?? "",
              ),
            ),
            FooterMessage(controller: _textController, sendMessage: _send)
          ],
        );
      }),
    );
  }
}
