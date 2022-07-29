import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../mixins/mixins.dart';
import 'components/components.dart';
import 'register.dart';

class RegisterPageWeb extends StatelessWidget
    with NavigationManager, UIErrorManager {
  final RegisterPresenterWeb presenter;
  const RegisterPageWeb({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleNaviationPush(presenter.navigationStream);
    handleUIError(context, presenter.uiErrorStream);
    return Provider(
      create: (context) => presenter,
      child: Scaffold(body: Builder(builder: (context) {
        return SafeArea(
          child: Builder(builder: (context) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text("Digite um codinome!",
                        style: Theme.of(context).textTheme.titleLarge),
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
                      child: TextFieldRegister(onConfirm: () {}),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 600,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: Text("Possui um codigo?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center),
                                ),
                                const Expanded(child: RegisterLinkInput()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const EnterRooomBottomLogin(),
                          const SizedBox(height: 40),
                          /* Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text("Quer gerar uma sala?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      textAlign: TextAlign.center),
                                ),
                                const GenerateRooomBottomLogin(),
                              ],
                            ),
                          ), */
                        ],
                      ),
                    )
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
