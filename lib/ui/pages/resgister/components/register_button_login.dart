import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class RegisterButtonLogin extends StatelessWidget {
  const RegisterButtonLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenter>(context);
    return SizedBox(
      width: 150,
      height: 50,
      child: StreamBuilder<bool>(
          stream: presenter.isValidStream,
          builder: (context, snapshot) {
            return ElevatedButton(
                onPressed: snapshot.hasData && snapshot.data!
                    ? () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        presenter.register();
                      }
                    : null,
                child: const Text("Confirmar"));
          }),
    );
  }
}
