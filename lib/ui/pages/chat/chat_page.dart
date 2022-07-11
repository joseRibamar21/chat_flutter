import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../data/usecase/autentication_local.dart';
import '../../mixins/mixins.dart';
import 'chat_controller.dart';
import 'components/components.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with WidgetsBindingObserver, DesconectMixin {
  final TextEditingController _textController = TextEditingController();
  final BlockAuthController _authController = BlockAuthController();
  final AuthenticationLocal _authenticationLocal = AuthenticationLocal();
  String? nick;
  ChatController controller = ChatController();

  @override
  void initState() {
    nick = "Jose";
    controller.init(nick);
    WidgetsBinding.instance.addObserver(this);
    controller.timerDeleteMessages();

    super.initState();
  }

  @override
  void dispose() async {
    await controller.disp();
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
        Future.delayed(const Duration(milliseconds: 40)).then((value) async {
          if (await _authenticationLocal.varifyCanAuthentican()) {
            _authController.verify(true);
          }
        });
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
      controller.send(_textController.text);
      _textController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialogReturn(context);
      },
      child: BlockAuth(
        controller: _authController,
        body: Provider(
          create: (context) => controller,
          child: Scaffold(
            bottomSheet:
                FooterMessage(controller: _textController, sendMessage: _send),
            appBar: AppBar(
              toolbarHeight: 60,
              title: const AppBarSender(),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            child: const Text("Configurações"),
                          )
                        ])
              ],
            ),
            body: Builder(builder: (context) {
              handleDesconect(context, controller.desconectStream);
              return ListMessage(
                stream: controller.listMessagesStream,
                nick: nick ?? "",
              );
            }),
          ),
        ),
      ),
    );
  }
}
