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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text("Codinome",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    TextFieldRegister(onConfirm: () {}),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text("Senha",
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    TextPasswordFieldRegister(onConfirm: () {}),
                    const SizedBox(height: 40),
                    const Center(child: RegisterButtonLogin()),
                    const SizedBox(height: 90),
                    const Divider(),
                    Text(
                        "Para aumentar sua segurança, tenha cadastrado uma biometria em seu celular!",
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
              ),
            );
          }),
        );
      })),
    );
  }
}
