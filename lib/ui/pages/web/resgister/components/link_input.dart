import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class RegisterLinkInput extends StatelessWidget {
  const RegisterLinkInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenterWeb>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          onChanged: presenter.validadeLink,
          decoration:
              const InputDecoration(hintText: "Coloque seu codigo aqui!"),
          autocorrect: false,
        ),
      ),
    );
  }
}
