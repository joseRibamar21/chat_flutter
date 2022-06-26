import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    switch (connection) {
      case 0:
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("$sender saiu!",
                style: Theme.of(context).textTheme.titleSmall),
          ),
        );
      case 1:
        if (sender == "SYSTEM") {
          return _SystemMessage(message: menssage);
        } else {
          if (sender == "SYSTEM_SPACE") {
            return const SizedBox(height: 60);
          }
        }
        return menssage == "null" || menssage.isEmpty
            ? const SizedBox()
            : Align(
                alignment:
                    isSentder ? Alignment.centerRight : Alignment.centerLeft,
                child: _BalloonChat(
                    menssage: menssage, sender: sender, isSentder: isSentder),
              );

      case 3:
        return Align(
          alignment: Alignment.center,
          child: Text("$sender entrou!",
              style: Theme.of(context).textTheme.titleSmall),
        );

      default:
        return const SizedBox();
    }
  }
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
  const _BalloonChat({
    Key? key,
    required this.menssage,
    required this.sender,
    required this.isSentder,
  }) : super(key: key);

  final String menssage;
  final String sender;
  final bool isSentder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSentder
          ? const EdgeInsets.only(left: 30, right: 10)
          : const EdgeInsets.only(right: 30, left: 10),
      child: Card(
        color: isSentder
            ? Theme.of(context).cardColor
            : Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isSentder
              ? Text(menssage)
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(sender, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 5),
                  Text(menssage)
                ]),
        ),
      ),
    );
  }
}
