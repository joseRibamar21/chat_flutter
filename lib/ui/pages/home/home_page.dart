import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../mixins/mixins.dart';
import '../chat/components/components.dart';
import 'components/components.dart';
import 'home.dart';

class HomePage extends StatelessWidget with NavigationManager {
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
            title: const Text("Secreto"),
            leading: IconButton(
                onPressed: presenter.goRegister,
                icon: const Icon(Icons.exit_to_app_rounded)),
          ),
          body: Builder(builder: (_) {
            presenter.inicialization();
            Future.delayed(
                const Duration(milliseconds: 100), presenter.loadRooms);
            handleNaviationPush(presenter.navigatorStream);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<String>(
                      stream: presenter.nameStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Codinome: ${snapshot.data}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 100,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          ElevatedButtonCustom(
                            function: () async {
                              var t = await newRoomDialog(context);
                              if (t != null) {
                                presenter.saveRooms(t, null);
                              }
                            },
                            icon: Icons.group_add_rounded,
                            title: "Nova Reunião",
                          ),
                          ElevatedButtonCustom(
                              function: () async {
                                var t = await searchRoomDialog(context);
                                if (t != null) {
                                  presenter.searchRoom(t);
                                }
                              },
                              icon: Icons.person,
                              title: "Adicionar Sala"),
                        ],
                      ),
                    ),
                  ),
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
            );
          }),
        ),
      ),
    );
  }
}

class ElevatedButtonCustom extends StatelessWidget {
  final IconData icon;
  final Function() function;
  final String? title;
  const ElevatedButtonCustom(
      {Key? key, required this.icon, required this.function, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: const CircleBorder()),
            onPressed: function,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(icon, size: 45),
            ),
          ),
        ),
        title == null ? const SizedBox() : Text(title ?? ""),
      ],
    );
  }
}
