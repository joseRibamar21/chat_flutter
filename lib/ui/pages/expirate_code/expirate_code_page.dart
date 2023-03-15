import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'expirate_code_presenter.dart';

class ExpirateCodePage extends StatelessWidget {
  final ExpirateCodePresenter presenter;
  const ExpirateCodePage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider(
          create: (context) => presenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text("Insira o novo codigo para desbloquear o app!"),
                  const SizedBox(height: 30),
                  ResgisterCodeInput(onConfirm: presenter.verifyCode),
                  const SizedBox(height: 40),
                  const ValidadeCodeButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
