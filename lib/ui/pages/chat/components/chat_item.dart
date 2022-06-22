import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final String menssage;
  final String sender;
  final bool isSentder;
  final int connection;
  const ChatItem({
    Key? key,
    required this.menssage,
    required this.sender,
    required this.isSentder,
    required this.connection,
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  // bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
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
        return widget.menssage == "null" || widget.menssage.isEmpty
            ? const SizedBox()
            : ListTile(
                /* onLongPress: () {
            setState(() {
              _isSelect = !_isSelect;
            });
          }, */
                //selected: _isSelect,
                selectedTileColor: Colors.grey[200],
                title: Align(
                  alignment: widget.isSentder
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: _BalloonChat(widget: widget),
                ),
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
}

class _BalloonChat extends StatelessWidget {
  const _BalloonChat({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ChatItem widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isSentder
          ? const EdgeInsets.only(
              left: 30,
            )
          : const EdgeInsets.only(right: 30),
      child: Card(
        color: widget.isSentder
            ? Theme.of(context).cardColor
            : Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.isSentder
              ? Text(widget.menssage)
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.sender,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(widget.menssage)
                ]),
        ),
      ),
    );
  }
}
