import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../register.dart';

class TextFieldRegister extends StatefulWidget {
  final Function() onConfirm;
  const TextFieldRegister({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<TextFieldRegister> createState() => _TextFieldRegisterState();
}

class _TextFieldRegisterState extends State<TextFieldRegister> {
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
    var presenter = Provider.of<RegisterPresenterWeb>(context);
    return SizedBox(
      width: 600,
      child: Card(
        child: StreamBuilder<String?>(
            stream: presenter.nameErrorStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: textControler,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: presenter.validadeName,
                  decoration: InputDecoration(errorText: snapshot.data),
                  autocorrect: false,
                ),
              );
            }),
      ),
    );
  }
}
