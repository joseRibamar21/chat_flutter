import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/entities.dart';
import '../../pages.dart';
import '../home_controller.dart';

class RoomsListView extends StatelessWidget {
  const RoomsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context);
    return StreamBuilder<List<RoomEntity>>(
        stream: controller.listRoomStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: LinearProgressIndicator(),
              );
            case ConnectionState.done:
            case ConnectionState.active:
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          await Get.to(
                              ChatPage(
                                  name: controller.nick,
                                  room: snapshot.data![index].name,
                                  password: snapshot.data![index].password),
                              fullscreenDialog: true);
                        },
                        leading: IconButton(
                            onPressed: () {
                              controller.deleteRoom(snapshot.data![index].name,
                                  snapshot.data![index].password);
                            },
                            icon: Icon(Icons.remove,
                                color: Theme.of(context).iconTheme.color)),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).iconTheme.color),
                        title: Text(snapshot.data![index].name),
                      );
                    });
              } else {
                return const Center(
                  child: Text(
                      "Crie uma nova sala de reuniao com nome e senha para começar!",
                      textAlign: TextAlign.center),
                );
              }

            default:
              return const SizedBox();
          }
        });
  }
}
