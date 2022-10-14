import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../chat.dart';

class AppBarSender extends StatelessWidget {
  final String name;
  const AppBarSender({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ChatWebPresenter>(context);
    return SizedBox(
      height: 60,
      child: ListTile(
        isThreeLine: true,
        title: StreamBuilder<String?>(
            stream: controller.roomNameString,
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? "Sala",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              );
            }),
        subtitle: StreamBuilder<String?>(
          stream: controller.userMessageTypingStream,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? Text(
                    "${snapshot.data} esta digitando...",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                : const Text(
                    "Opções da sala",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
          },
        ),
      ),
    );
  }
}
