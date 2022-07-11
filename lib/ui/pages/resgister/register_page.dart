import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import 'register.dart';

class RegisterPage extends StatelessWidget
    with NavigationManager, UIErrorManager {
  final RegisterPresenter presenter;
  const RegisterPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleNaviation(presenter.navigationStream);
    handleUIError(context, presenter.uiErrorStream);
    return Provider(
      create: (context) => presenter,
      child: Scaffold(body: Builder(builder: (context) {
        return SafeArea(
          child: Builder(builder: (context) {
            presenter.inicialization();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text("Digite um nome!",
                      style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: TextFieldRegister(onConfirm: presenter.register),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: presenter.register,
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
    var presenter = Provider.of<RegisterPresenter>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodyMedium,
          onEditingComplete: widget.onConfirm,
          onChanged: presenter.validadeName,
        ),
      ),
    );
  }
}
