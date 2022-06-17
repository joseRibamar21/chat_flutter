import 'package:flutter/material.dart';

class FooterMessage extends StatelessWidget {
  final TextEditingController controller;
  final Function() sendMessage;
  const FooterMessage(
      {Key? key, required this.controller, required this.sendMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12.0))),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                autofocus: false,
                controller: controller,
                cursorColor: Colors.white,
                keyboardType: TextInputType.multiline,
                autocorrect: true,
                enableSuggestions: true,
                maxLines: 4,
                minLines: 1,
                toolbarOptions: const ToolbarOptions(
                    copy: true, cut: true, selectAll: true, paste: true),
                onEditingComplete: sendMessage,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration:
                    const InputDecoration(hintText: "Escreva uma mensagem..."),
              ),
            )),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
