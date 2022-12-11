import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_flutter/domain/entities/entities.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../data/usecase/autentication_local.dart';
import '../../components/components.dart';
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

  late UserEntity userEntity;

  @override
  void initState() {
    widget.presenter.inicialization();
    WidgetsBinding.instance.addObserver(this);

    widget.presenter.notificationMenssage.listen((event) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0,
            channelKey: 'basic_channel',
            title: "Uma nova mensagem",
            body:
                "${event!.username} te mandou uma mensagem. Toque para ver!" //event!.text.message,
            ),
      );
    });
    /*   timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      widget.presenter.verifyExpirateRoom();
    }); */

    Future.delayed(const Duration(milliseconds: 1000), () {
      widget.presenter.verifyExpirateRoom();
    });
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
        widget.presenter.backgroundScreen(false);
        widget.presenter.resume();
        Future.delayed(const Duration(milliseconds: 40)).then((value) async {
          if (await _authenticationLocal.varifyCanAuthentican()) {
            _authController.verify(true);
          }
        });
        break;
      case AppLifecycleState.inactive:
        widget.presenter.backgroundScreen(true);
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
          validadePassword: widget.presenter.validadePassword,
          controller: _authController,
          body: Provider(
              create: (context) => widget.presenter,
              child: Scaffold(
                bottomSheet: FooterMessage(
                    typing: widget.presenter.isTyping,
                    controller: _textController,
                    sendMessage: _send),
                appBar: AppBar(
                  toolbarHeight: 60,
                  title: AppBarSender(
                      name: widget.presenter.nameRoomlink ?? "Sala"),
                ),
                body: StreamBuilder<UserEntity?>(
                    stream: widget.presenter.currentUserStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data != null) {
                        userEntity = snapshot.data!;
                      }
                      return Builder(
                        builder: (context) {
                          handleDesconect(
                              context, widget.presenter.desconectStream);
                          return Stack(
                            children: [
                              ListMessage(
                                stream: widget.presenter.listMessagesStream,
                                nick: userEntity.name + userEntity.hash,
                              ),
                              const CustomAlertConnection(),
                            ],
                          );
                        },
                      );
                    }),
              )),
        ),
      ),
    );
  }
}
