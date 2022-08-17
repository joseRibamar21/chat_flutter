import 'package:flutter/material.dart';

import 'config.dart';

class ConfigPage extends StatelessWidget {
  final ConfigPresenter presenter;

  const ConfigPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Tela de Configurações")),
    );
  }
}
