import 'package:flutter/material.dart';

import 'config.dart';

class ConfigPage extends StatelessWidget {
  final ConfigPresenter presenter;

  const ConfigPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 24, bottom: 36),
                    child: ConfigTitleText(),
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text("Alterar codinome"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    subtitle: const Text(
                        "Alterar codinome do aplicativo, isso irá fazer com que todas as salas sejam atualizadas."),
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text("Alterar tempo de sala padrão"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    subtitle: const Text(
                        "Altere o tempo padão de expiração da sala."),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.exit_to_app_rounded,
                  color: Theme.of(context).errorColor),
              label: Text(
                "Sair do aplicativo",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class ConfigTitleText extends StatelessWidget {
  const ConfigTitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Configurações",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
