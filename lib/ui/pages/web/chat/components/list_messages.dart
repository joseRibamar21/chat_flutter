import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/entities.dart';
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
  late List<MessageEntity> list = [
    MessageEntity(
        time: DateTime.now().millisecondsSinceEpoch.toString(),
        userHash: "BOT",
        username: "SYSTEM_SPACE",
        body: BodyEntity(
            message: "",
            function: 1,
            id: '0',
            sendAt: DateTime.now().millisecondsSinceEpoch))
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
            element.body.id == event[event.length - 1].body.message);
        list.removeAt(index);
        if (index != -1) {
          if (animatedKey.currentState != null) {
            animatedKey.currentState?.removeItem(
                index,
                (context, animation) => SizeTransition(
                    sizeFactor: animation,
                    axis: Axis.vertical,
                    child: const SizedBox(height: 50.0, child: Card())));
          }
        }
      } else {
        list.insert(list.length - 1, event[event.length - 1]);
        if (animatedKey.currentState != null) {
          animatedKey.currentState?.insertItem(list.length - 2,
              duration: const Duration(milliseconds: 300));
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
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
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
          position: (list[index].username == widget.nick)
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
            id: list[index].body.id ?? "",
            menssage: list[index].body.message ?? "",
            sender: list[index].username,
            isSentder: (list[index].username == widget.nick),
            connection: list[index].body.function,
          ),
        );
      },
    );
    /* return ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        cacheExtent: 99,
        itemBuilder: (context, index) {
          return ChatItem(
              key: Key(index.toString()),
              menssage: "list[index].body.message",
              sender: "list[index].sender",
              isSentder: false, //(list[index].sender == widget.nick),
              connection: 1 //list[index].body.connecting,
              );
        }); */
  }
}
