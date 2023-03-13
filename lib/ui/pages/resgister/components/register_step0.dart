import 'package:flutter/material.dart';

import 'components.dart';

class RegisterSetp0 extends StatelessWidget {
  final PageController pageController;
  const RegisterSetp0({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),
            Image.asset("lib/ui/assets/imgs/icon.png",
                fit: BoxFit.fitWidth,
                color: Theme.of(context).secondaryHeaderColor),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Insira o codigo de desbloqueio",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            ResgisterCodeInput(onConfirm: () {}),
            const SizedBox(height: 90),
            Center(
                child: ValidadeCodeButton(
              pageController: pageController,
            )),
          ],
        ),
      ),
    );
  }
}
