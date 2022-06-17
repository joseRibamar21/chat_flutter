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
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.connection) {
      case 0:
        return Align(
          alignment: Alignment.center,
          child: Card(
            color: Colors.red[200],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.isSentder
                  ? Text(widget.menssage)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text("${widget.sender} saiu!",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]),
            ),
          ),
        );
      case 1:
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

      case 3:
        return Align(
          alignment: Alignment.center,
          child: Card(
            color: Colors.green[200],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.isSentder
                  ? Text(widget.menssage)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text("${widget.sender} entrou!",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ]),
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
