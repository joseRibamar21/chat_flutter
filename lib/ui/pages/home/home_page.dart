import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import '../chat/components/components.dart';
import 'components/components.dart';
import 'home.dart';

class HomePage extends StatelessWidget with NavigationManager, KeyboardManager {
  final HomePresenter presenter;

  const HomePage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => presenter,
      child: WillPopScope(
        onWillPop: () async {
          return await showDialogReturn(context, "Deseja sair do app?");
        },
        child: Scaffold(
          appBar: AppBar(
              title: HomeAppBar(
            presenter: presenter,
          )),
          body: Builder(builder: (_) {
            presenter.inicialization();

            Future.delayed(
                const Duration(milliseconds: 100), presenter.loadRooms);
            handleNaviationPush(presenter.navigatorStream);
            return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeUserName(),
                    const HomeListOptionsRooms(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Salas",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const RoomsListView()
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
