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

  @override
  void initState() {
    _scrollController = ScrollController();
    _streamSubscription = widget.stream.listen((event) {
      _list = event;
      setState(() {});
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
    _scrollToBotton();
    return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _list.length,
        cacheExtent: 99,
        itemBuilder: (context, index) {
          return ChatItem(
            key: Key(index.toString()),
            menssage: _list[index].body.message,
            sender: _list[index].sender,
            isSentder: (_list[index].sender == widget.nick),
            connection: _list[index].body.connecting,
          );
        });
  }
}
