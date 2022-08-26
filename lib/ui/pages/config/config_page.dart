import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'subpages/subpages.dart';

class ConfigPage extends StatelessWidget {
  final ConfigPresenter presenter;

  const ConfigPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(presenter);
    return Provider(
      create: (_) => presenter,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 30),
                  onPressed: Navigator.of(context).pop),
            ),
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
                      onTap: () async {
                        var t = await presenter.getName();
                        Get.to(AlterCodinameSubpage(
                          name: t,
                        ));
                      },
                      title: const Text("Alterar codinome"),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      subtitle: const Text(
                          "Alterar codinome do aplicativo, isso irá fazer com que todas as salas sejam atualizadas."),
                    ),
                    ListTile(
                      onTap: () async {
                        var t = await presenter.getTime();
                        Get.to(AlterTimerPage(mapTime: t),
                            transition: Transition.leftToRightWithFade);
                      },
                      title: const Text("Alterar tempo de sala padrão"),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      subtitle: const Text(
                          "Altere o tempo padrão de expiração da sala. A salas agora irão usar o novo tempo de expiração."),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: TextButton.icon(
                onPressed: presenter.logoff,
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
      ),
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
