import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class EnterRooomBottomLogin extends StatelessWidget {
  const EnterRooomBottomLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenterWeb>(context);
    return SizedBox(
      width: 150,
      height: 50,
      child: StreamBuilder<bool>(
          stream: presenter.isValidStream,
          builder: (context, snapshot) {
            return ElevatedButton(
                onPressed: snapshot.hasData && snapshot.data!
                    ? presenter.goToChatLink
                    : null,
                child: const Text("Entrar na sala"));
          }),
    );
  }
}
