import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class TextPasswordFieldRegister extends StatefulWidget {
  final Function() onConfirm;
  const TextPasswordFieldRegister({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<TextPasswordFieldRegister> createState() =>
      _TextPasswordFieldRegisterState();
}

class _TextPasswordFieldRegisterState extends State<TextPasswordFieldRegister> {
  late TextEditingController? textControler;

  @override
  void initState() {
    textControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textControler?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<RegisterPresenter>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<String?>(
            stream: presenter.passwordErrorStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: textControler,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: presenter.validadePassword,
                decoration: InputDecoration(errorText: snapshot.data),
                autocorrect: false,
              );
            }),
      ),
    );
  }
}
