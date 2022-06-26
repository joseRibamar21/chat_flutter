import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../data/entities/entities.dart';
import 'components.dart';

class ListMessage extends StatefulWidget {
  final Stream<List<MessageEntity>> stream;
  final String nick;
  const ListMessage({Key? key, required this.stream, required this.nick})
      : super(key: key);

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  late ScrollController _scrollController;
  late List<MessageEntity> _list = [];
  late StreamSubscription _streamSubscription;
  late GlobalKey<AnimatedListState> animatedKey;

  @override
  void initState() {
    _scrollController = ScrollController();
    animatedKey = GlobalKey<AnimatedListState>();
    _streamSubscription = widget.stream.listen((event) {
      _list.add(event[event.length - 1]);
      if (animatedKey.currentState != null) {
        animatedKey.currentState?.insertItem(_list.length - 1,
            duration: const Duration(milliseconds: 300));
        _scrollToBotton();
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
      initialItemCount: _list.length,
      key: animatedKey,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: (_list[index].sender == widget.nick)
              ? Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1, 0),
                ).animate(animation)
              : Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
          child: ChatItem(
            key: Key(index.toString()),
            menssage: _list[index].body.message,
            sender: _list[index].sender,
            isSentder: (_list[index].sender == widget.nick),
            connection: _list[index].body.connecting,
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
              menssage: "_list[index].body.message",
              sender: "_list[index].sender",
              isSentder: false, //(_list[index].sender == widget.nick),
              connection: 1 //_list[index].body.connecting,
              );
        }); */
  }
}
