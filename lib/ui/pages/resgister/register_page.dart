import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import 'components/components.dart';
import 'register.dart';

class RegisterPage extends StatelessWidget
    with NavigationManager, UIErrorManager {
  final RegisterPresenter presenter;
  const RegisterPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleNaviationLogin(presenter.navigationStream);
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
                  Text("Digite um codinome!",
                      style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text(
                        "Devido a criptografia, não utilize caracteres especiais no seu nome e no nome das salas!",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: TextFieldRegister(onConfirm: presenter.register),
                  ),
                  const SizedBox(height: 40),
                  const RegisterButtonLogin(),
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
