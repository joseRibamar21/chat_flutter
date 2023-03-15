import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../expirate_code_presenter.dart';

class ResgisterCodeInput extends StatefulWidget {
  final Function() onConfirm;
  const ResgisterCodeInput({Key? key, required this.onConfirm})
      : super(key: key);

  @override
  State<ResgisterCodeInput> createState() => _ResgisterCodeInputState();
}

class _ResgisterCodeInputState extends State<ResgisterCodeInput> {
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
    var presenter = Provider.of<ExpirateCodePresenter>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<String?>(
            stream: presenter.codeErrorStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: textControler,
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: presenter.validadeCode,
                decoration: InputDecoration(
                    hintText: "####-####-####", errorText: snapshot.data),
                autocorrect: false,
              );
            }),
      ),
    );
  }
}
