import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  String? nick;
  List<Map<String, dynamic>> list = [];
  var _channel = WebSocketChannel.connect(
    Uri.parse('wss://wss.infatec.solutions'),
  );

  @override
  void initState() {
    nick = Get.arguments['nick'];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(jsonEncode({"sender": nick, "body": _controller.text}));
      _controller.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nick!),
      ),
      body: Builder(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ListMessage(
                  stream: _channel.stream,
                  nick: nick ?? "",
                  retornConnect: () {
                    _channel = WebSocketChannel.connect(
                      Uri.parse('wss://wss.infatec.solutions'),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: Container(
                //height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _controller,
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.multiline,
                        autocorrect: true,
                        enableSuggestions: true,
                        maxLines: 4,
                        minLines: 1,
                        onEditingComplete: _send,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        decoration:
                            const InputDecoration(hintText: "Digite algo..."),
                      ),
                    )),
                    IconButton(
                      onPressed: _send,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ListMessage extends StatefulWidget {
  final Stream<dynamic> stream;
  final String nick;
  final Function() retornConnect;
  const ListMessage(
      {Key? key,
      required this.stream,
      required this.nick,
      required this.retornConnect})
      : super(key: key);

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  late ScrollController _scrollController;
  List<Map<String, dynamic>> listMenssages = [];
  late Timer timerConnect;

  @override
  void initState() {
    _scrollController = ScrollController();
    timerConnect = Timer(const Duration(seconds: 1), () {});
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timerConnect.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: widget.stream,
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasData) {
            //listMenssages.insert(0, jsonDecode(snapshot.data));
            listMenssages.add(jsonDecode(snapshot.data));
            Future.delayed(const Duration(milliseconds: 50)).then((value) {
              final position = _scrollController.position.maxScrollExtent;

              _scrollController.animateTo(position,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn);
            });
          }
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.none) {
            timerConnect = Timer(const Duration(milliseconds: 100), () {
              print("Chamando");
              widget.retornConnect.call();
            });
          } else {
            timerConnect.cancel();
          }
          return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              //reverse: true,
              itemCount: listMenssages.length,
              itemBuilder: (context, index) {
                return ChatItem(
                    menssage: listMenssages[index]['body'],
                    sender: listMenssages[index]['sender'],
                    isSentder: (listMenssages[index]['sender'] == widget.nick));
              });
        });
  }
}

class ChatItem extends StatefulWidget {
  final String menssage;
  final String sender;
  final bool isSentder;
  const ChatItem({
    Key? key,
    required this.menssage,
    required this.sender,
    required this.isSentder,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        setState(() {
          _isSelect = !_isSelect;
        });
      },
      selected: _isSelect,
      selectedTileColor: Colors.grey[400],
      title: Align(
        alignment:
            widget.isSentder ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: widget.isSentder
              ? const EdgeInsets.only(left: 30, right: 10)
              : const EdgeInsets.only(left: 10, right: 30),
          child: Card(
            color: Colors.white54,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.isSentder
                  ? Text(widget.menssage)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(widget.sender,
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 5),
                          Text(widget.menssage)
                        ]),
            ),
          ),
        ),
      ),
    );
  }
}
