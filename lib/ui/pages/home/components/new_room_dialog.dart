import 'package:flutter/material.dart';

Future<String?> newRoomDialog(BuildContext context) async {
  String? name;
  await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nova Reunião",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Text(
                    "Devido a criptografia, não utilize caracteres especiais no seu nome e no nome das salas!",
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center),

                    
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        maxLength: 50,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                            label: Text(
                          "Nome da Sala",
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Confirmar"))
              ],
            ),
          ),
        );
      });
  if (name != null) {
    return name;
  } else {
    return null;
  }
}
