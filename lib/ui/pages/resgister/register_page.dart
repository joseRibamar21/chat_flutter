import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import 'register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with NavigationManager, UIErrorManager {
  RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    handleNaviation(controller.navigationStream);
    handleUIError(context, controller.uiErrorStream);
    return Provider(
      create: (context) => controller,
      child: Scaffold(body: Builder(builder: (context) {
        return SafeArea(
          child: Builder(builder: (context) {
            controller.inicialization();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text("Digite um nome!",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Text(
                      "Devido a criptografia, não utilize caracteres especiais no seu nome e no nome das salas!",
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: TextFieldRegister(onConfirm: controller.register),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          bool test = await controller.register();
                          if (test) {
                            Get.toNamed('/home');
                          }
                        },
                        child: const Text("Confirmar")),
                  ),
                  const SizedBox(height: 90),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      children: [
                        const Divider(),
                        Text(
                            "Para aumentar sua segurança, tenha cadastrado uma biometria em seu celular!",
                            style: Theme.of(context).textTheme.bodySmall)
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        );
      })),
    );
  }
}

class TextFieldRegister extends StatefulWidget {
  final Function() onConfirm;
  const TextFieldRegister({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<TextFieldRegister> createState() => _TextFieldRegisterState();
}

class _TextFieldRegisterState extends State<TextFieldRegister> {
  late TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<RegisterController>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodyMedium,
          onEditingComplete: widget.onConfirm,
          onChanged: controller.validadeName,
        ),
      ),
    );
  }
}
