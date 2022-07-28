import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../data/usecase/autentication_local.dart';
import '../../mixins/mixins.dart';
import 'chat.dart';
import 'components/components.dart';

class ChatPage extends StatefulWidget {
  final ChatPresenter presenter;

  const ChatPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with WidgetsBindingObserver, DesconectMixin {
  final TextEditingController _textController = TextEditingController();
  final BlockAuthController _authController = BlockAuthController();
  final AuthenticationLocal _authenticationLocal = AuthenticationLocal();

  @override
  void initState() {
    widget.presenter.inicialization();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() async {
    widget.presenter.disp();
    WidgetsBinding.instance.removeObserver(this);
    _authController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.presenter.resume();
        Future.delayed(const Duration(milliseconds: 40)).then((value) async {
          if (await _authenticationLocal.varifyCanAuthentican()) {
            _authController.verify(true);
          }
        });
        break;
      case AppLifecycleState.inactive:
        widget.presenter.inactive();
        break;
      case AppLifecycleState.detached:
        widget.presenter.disp();
        break;
      default:
    }
  }

  void _send() {
    if (_textController.text.isNotEmpty) {
      widget.presenter.send(_textController.text);
      _textController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialogReturn(context, 'Deseja sair desta sala?');
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlockAuth(
          controller: _authController,
          body: Provider(
            create: (context) => widget.presenter,
            child: Scaffold(
              bottomSheet: FooterMessage(
                  controller: _textController, sendMessage: _send),
              appBar: AppBar(
                toolbarHeight: 60,
                title: AppBarSender(name: Get.parameters['room'] ?? "Sala"),
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
                handleDesconect(context, widget.presenter.desconectStream);
                return ListMessage(
                  stream: widget.presenter.listMessagesStream,
                  nick: Get.parameters['name'] ?? "",
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
