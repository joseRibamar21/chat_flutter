import 'package:flutter/material.dart';

Future<String?> searchRoomDialog(BuildContext context) async {
  String? t;
  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Insira o id da sala"),
                TextField(
                  decoration: const InputDecoration(hintText: "Id da Sala"),
                  autofocus: true,
                  onChanged: (value) {
                    t = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Confirmar"),
                )
              ],
            ),
          ),
        );
      });
  return t;
}
