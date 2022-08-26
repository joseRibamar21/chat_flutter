import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config.dart';

class AlterCodinameSubpage extends StatelessWidget {
  final String name;
  const AlterCodinameSubpage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Get.find<ConfigPresenter>();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Alterar Codinome"),
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text(
                "Alterar codinome do aplicativo, isso irá fazer com que todas as salas sejam atualizadas."),
            const SizedBox(height: 30),
            _TextFieldCodiname(
              onConfirm: presenter.updateName,
              name: name,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFieldCodiname extends StatefulWidget {
  final Function(String value) onConfirm;
  final String name;
  const _TextFieldCodiname(
      {Key? key, required this.onConfirm, required this.name})
      : super(key: key);

  @override
  State<_TextFieldCodiname> createState() => __TextFieldCodinameState();
}

class __TextFieldCodinameState extends State<_TextFieldCodiname> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String codiName = "";

  @override
  void initState() {
    codiName = widget.name;
    super.initState();
  }

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
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                initialValue: widget.name,
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (value) => codiName = value,
                autocorrect: false,
                validator: (value) {
                  String name = value ?? "";
                  bool nameValid = RegExp(r'[^\w\s]+').hasMatch(name);
                  if (nameValid) {
                    return "Não permitido caracteres especiais!";
                  } else {
                    if (name.length < 3) {
                      return "O codinome deve ter mais que 2 caracteres!";
                    } else {
                      if (name.length > 50) {
                        return "O codinome deve ter menos que 50 caracteres!";
                      } else {
                        return null;
                      }
                    }
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
                onPressed: () {
                  if (validateAndSave()) {
                    widget.onConfirm.call(codiName);
                    Get.back();
                  }
                },
                child: const Text("Salvar")),
          )
        ],
      ),
    );
  }
}
