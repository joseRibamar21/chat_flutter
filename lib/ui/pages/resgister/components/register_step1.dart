import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';
import 'components.dart';

class RegisterSetp1 extends StatelessWidget {
  final PageController pageController;
  const RegisterSetp1({
    required this.pageController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenter>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text("Insira um codinome para utilizar a aplicação!",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Codinome",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            TextFieldRegister(onConfirm: () {}),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder<String?>(
                  stream: presenter.nameErrorStream,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data == null &&
                              snapshot.connectionState == ConnectionState.active
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.bounceInOut);
                            }
                          : null,
                      child: const Text("Proximo"),
                    );
                  }),
            ),
            const SizedBox(height: 90),
            const Divider(),
            Text(
                "Para aumentar sua segurança, tenha cadastrado uma biometria em seu celular!",
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
