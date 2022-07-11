import 'package:flutter/material.dart';

Future<List<dynamic>?> newRoomDialog(BuildContext context) async {
  String? name;
  String? password;
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        maxLength: 50,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            label: Text(
                          "Senha",
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
  if (name != null && password != null) {
    return [name, password];
  } else {
    return null;
  }
}
