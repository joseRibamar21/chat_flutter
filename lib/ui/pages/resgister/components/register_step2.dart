import 'package:flutter/material.dart';

import 'components.dart';

class RegisterSetp2 extends StatelessWidget {
  const RegisterSetp2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text("Insira uma senha numérica para utilizar o bloqueador do app!",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child:
                  Text("Senha", style: Theme.of(context).textTheme.titleMedium),
            ),
            TextPasswordFieldRegister(onConfirm: () {}),
            const SizedBox(height: 90),
            const Center(child: RegisterButtonLogin()),
          ],
        ),
      ),
    );
  }
}
