import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expirate_code_presenter.dart';

class ValidadeCodeButton extends StatelessWidget {
  const ValidadeCodeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<ExpirateCodePresenter>(context);
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
                    }
                  : null,
              child: const Text("Confirmar"));
        },
      ),
    );
  }
}
