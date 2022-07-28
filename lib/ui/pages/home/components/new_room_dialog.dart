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
                FormNewRoomDialog(
                  onChange: (value) => name = value,
                )
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

class FormNewRoomDialog extends StatefulWidget {
  final Function(String? value) onChange;

  const FormNewRoomDialog({Key? key, required this.onChange}) : super(key: key);

  @override
  State<FormNewRoomDialog> createState() => _FormNewRoomDialogState();
}

class _FormNewRoomDialogState extends State<FormNewRoomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;

  bool validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  maxLength: 50,
                  validator: (value) {
                    bool nameValid = RegExp(r'[^\w\s]+').hasMatch(value!);
                    if (nameValid) {
                      return "Não permitido caracteres especiais!";
                    } else {
                      if (value.length < 3) {
                        return "O codinome deve ter mais que 2 caracteres!";
                      } else {
                        if (value.length > 50) {
                          return "O codinome deve ter menos que 50 caracteres!";
                        } else {
                          return null;
                        }
                      }
                    }
                  },
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
            child: ElevatedButton(
                onPressed: () {
                  if (validateAndSave()) {
                    widget.onChange(name);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Confirmar")),
          )
        ],
      ),
    );
  }
}
