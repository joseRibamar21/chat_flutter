import 'dart:convert';

import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final String id;
  final String message;
  final String sender;
  final bool isSentder;
  final int connection;
  final bool isSend;
  const ChatItem(
      {Key? key,
      required this.id,
      required this.message,
      required this.sender,
      required this.isSentder,
      required this.connection,
      required this.isSend})
      : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.connection) {
      case 0:
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${widget.sender} saiu!",
                style: Theme.of(context).textTheme.titleSmall),
          ),
        );
      case 1:
        if (widget.sender == "SYSTEM") {
          return _SystemMessage(message: widget.message);
        } else {
          if (widget.sender == "SYSTEM_SPACE") {
            return const SizedBox(height: 60);
          }
        }
        return widget.message == "null" || widget.message.isEmpty
            ? const SizedBox()
            : Align(
                alignment: widget.isSentder
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: _BalloonChat(
                    id: widget.id,
                    message: widget.message,
                    isSend: widget.isSend,
                    sender: widget.sender,
                    isSentder: widget.isSentder),
              );

      case 3:
        return Align(
          alignment: Alignment.center,
          child: Text("${widget.sender} entrou!",
              style: Theme.of(context).textTheme.titleSmall),
        );

      default:
        return const SizedBox();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class _SystemMessage extends StatelessWidget {
  final String message;
  const _SystemMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Center(
            child: Text(message,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    );
  }
}

class _BalloonChat extends StatelessWidget {
  const _BalloonChat(
      {Key? key,
      required this.message,
      required this.sender,
      required this.isSentder,
      required this.isSend,
      required this.id})
      : super(key: key);

  final String message;
  final String sender;
  final bool isSentder;
  final String id;
  final bool isSend;
  @override
  Widget build(BuildContext context) {
    /*  var controller = Provider.of<ChatPresenter>(context); */
    bool isImage = false;
    String newMessage = message;
    List<String> splitMessage = message.split('image@:');
    if (splitMessage.length > 1) {
      isImage = true;
      newMessage = splitMessage[1];
    }

    return Padding(
      padding: isSentder
          ? const EdgeInsets.only(left: 30, right: 10)
          : const EdgeInsets.only(right: 30, left: 10),
      child: /* PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
              onTap: () => controller.sendRemoveMessage(id: id),
              child: const Text("Apagar"))
        ],
        child: */
          Card(
        color: isSentder
            ? isSend
                ? Theme.of(context).cardColor
                : const Color(0xFFc8c8c8)
            : Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isSentder
              ? isImage
                  ? Image.memory(
                      base64Decode(newMessage),
                      gaplessPlayback: true,
                    )
                  : Text(newMessage)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sender, style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 5),
                    isImage
                        ? Image.memory(
                            base64Decode(newMessage),
                            gaplessPlayback: true,
                          )
                        : Text(newMessage)
                  ],
                ),
        ),
      ),
      /*   ), */
    );
  }
}

/*  */