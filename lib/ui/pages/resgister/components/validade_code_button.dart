import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class ValidadeCodeButton extends StatelessWidget {
  final PageController pageController;
  const ValidadeCodeButton({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenter>(context);
    return SizedBox(
      width: 150,
      height: 50,
      child: StreamBuilder<String?>(
        stream: presenter.codeErrorStream,
        builder: (context, snapshot) {
          return ElevatedButton(
              onPressed: snapshot.data == null
                  ? () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await presenter.verifyCode();
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceInOut);
                    }
                  : null,
              child: const Text("Confirmar"));
        },
      ),
    );
  }
}
