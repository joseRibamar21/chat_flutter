import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../chat/components/components.dart';
import 'components/components.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => controller,
      child: WillPopScope(
        onWillPop: () async {
          return await showDialogReturn(
              context, "Deseja voltar para a pagina de registro?");
        },
        child: Scaffold(
          appBar: AppBar(
            leading: PopupMenuButton(
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: (_) {
                  return [
                    PopupMenuItem(
                        child: const Text("Sair"),
                        onTap: () {
                          Get.back();
                        })
                  ];
                }),
            title: const Text("Secreto"),
            actions: [
              /* IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search_rounded)) */
            ],
          ),
          body: Builder(builder: (_) {
            controller.inicialization();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<String>(
                      stream: controller.nameStream,
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
                                controller.saveRooms(t[0], t[1]);
                              }
                            },
                            icon: Icons.group_add_rounded,
                            title: "Nova Reunião",
                          ),
                          /* ElevatedButtonCustom(
                              function: () {},
                              icon: Icons.person_add_rounded,
                              title: "Adicionar"), */
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
