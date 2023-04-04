import 'dart:async';
import 'package:chat_flutter/data/models/models.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';
import 'components.dart';

class ListMessage extends StatefulWidget {
  final Stream<List<MessageEntity>> stream;
  final String nick;
  const ListMessage({Key? key, required this.stream, required this.nick})
      : super(key: key);

  @override
  State<ListMessage> createState() => ListMessageState();
}

class ListMessageState extends State<ListMessage> {
  late ScrollController _scrollController;
  late List<MessageViewModel> list = [
    MessageViewModel(
        isSend: false,
        message: MessageEntity(
            time: DateTime.now().millisecondsSinceEpoch.toString(),
            username: "SYSTEM_SPACE",
            userHash: "BOT",
            body: BodyEntity(
                message: "",
                function: 1,
                id: '0',
                sendAt: DateTime.now().millisecondsSinceEpoch)))
  ];
  late StreamSubscription _streamSubscription;
  late GlobalKey<AnimatedListState> animatedKey;

  @override
  void initState() {
    _scrollController = ScrollController();
    animatedKey = GlobalKey<AnimatedListState>();

    _streamSubscription = widget.stream.listen((event) {
      /// Para excluir algo da lista
      if (event[event.length - 1].body.function == 5) {
        int index = list.indexWhere((element) =>
            element.message.body.id == event[event.length - 1].body.message);
        list.removeAt(index);
        if (index != -1) {
          if (animatedKey.currentState != null) {
            animatedKey.currentState?.removeItem(
              index,
              (context, animation) => SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                child: const SizedBox(
                  height: 50.0,
                  child: Card(),
                ),
              ),
            );
          }
        }
      } else {
        String userNick =
            "${event[event.length - 1].username}${event[event.length - 1].userHash}";

        // Caso eu esteja recebendo a minha mensagem
        if (userNick == widget.nick) {
          int index = list.indexWhere((element) =>
              element.message.body.id == event[event.length - 1].body.id);

          // Se achar a mensagem
          if (index != -1) {
            if (animatedKey.currentState != null) {
              animatedKey.currentState?.setState(() {
                list[index].isSend = true;
              });
            }
          } else {
            list.insert(
                list.length - 1,
                MessageViewModel(
                    isSend: false, message: event[event.length - 1]));
            if (animatedKey.currentState != null) {
              animatedKey.currentState?.insertItem(list.length - 2,
                  duration: const Duration(milliseconds: 300));
            }
          }
        } else {
          list.insert(
              list.length - 1,
              MessageViewModel(
                  isSend: false, message: event[event.length - 1]));
          if (animatedKey.currentState != null) {
            animatedKey.currentState?.insertItem(list.length - 2,
                duration: const Duration(milliseconds: 300));
          }

          _scrollToBotton();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBotton() {
    Future.delayed(const Duration(milliseconds: 250)).then((value) {
      final position = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(position,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      controller: _scrollController,
      shrinkWrap: true,
      initialItemCount: list.length,
      key: animatedKey,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position:
              (list[index].message.username + list[index].message.userHash ==
                      widget.nick)
                  ? Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation)
                  : Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(animation),
          child: ChatItem(
            key: Key(index.toString()),
            id: list[index].message.body.id ?? "",
            message: list[index].message.body.message ?? "",
            sender: list[index].message.username,
            isSentder:
                (list[index].message.username + list[index].message.userHash ==
                    widget.nick),
            connection: list[index].message.body.function,
            isSend: list[index].isSend!,
          ),
        );
      },
    );
  }
}
