import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../../components/components.dart';
import '../../../mixins/mixins.dart';
import 'chat.dart';
import 'components/components.dart';

class ChatPageWeb extends StatefulWidget {
  final ChatWebPresenter presenter;

  const ChatPageWeb({Key? key, required this.presenter}) : super(key: key);

  @override
  State<ChatPageWeb> createState() => _ChatPageWebState();
}

class _ChatPageWebState extends State<ChatPageWeb>
    with WidgetsBindingObserver, DesconectMixin {
  final TextEditingController _textController = TextEditingController();
  late Timer timer;

  @override
  void initState() {
    widget.presenter.inicialization();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      widget.presenter.verifyExpirateRoom();
    });
    super.initState();
  }

  @override
  void dispose() async {
    widget.presenter.disp();
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.presenter.resume();
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
        child: Provider(
          create: (context) => widget.presenter,
          child: Scaffold(
            bottomSheet:
                FooterMessage(controller: _textController, sendMessage: _send),
            appBar: AppBar(
              toolbarHeight: 60,
              title:
                  AppBarSender(name: widget.presenter.nameRoomlink ?? "Sala"),
            ),
            body: Builder(builder: (context) {
              handleDesconect(context, widget.presenter.desconectStream);
              return Stack(
                children: [
                  ListMessage(
                    stream: widget.presenter.listMessagesStream,
                    nick: Get.parameters['nick'] ?? "",
                  ),
                  const CustomAlertConnection(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
