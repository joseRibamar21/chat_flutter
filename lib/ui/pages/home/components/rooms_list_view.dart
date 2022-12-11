import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../domain/entities/entities.dart';
import '../home.dart';

class RoomsListView extends StatelessWidget {
  const RoomsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<HomePresenter>(context);
    return StreamBuilder<List<RoomEntity>>(
        stream: presenter.listRoomStream,
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
                        onTap: () => presenter.goChat(snapshot.data![index]),
                        onLongPress: () {
                          _showOptionsRoom(
                            context,
                            delete: () {
                              Navigator.pop(context);
                              presenter.deleteRoom(snapshot.data![index]);
                            },
                            shareLink: (() async {
                              Navigator.pop(context);
                              await Share.share(
                                  await presenter
                                      .getCodeRoom(snapshot.data![index]),
                                  subject: "Secreto");
                            }),
                          );
                        },
                        trailing: Icon(Icons.arrow_forward_ios_rounded,
                            color: Theme.of(context).iconTheme.color),
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(
                          _formatDate(
                            DateTime.fromMillisecondsSinceEpoch(int.tryParse(
                                    snapshot.data![index].expirateAt ?? "0") ??
                                0),
                          ),
                        ),
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

  String _formatDate(DateTime time) {
    String minutes = "00";
    if (time.minute < 10) {
      minutes = "0${time.minute}";
    } else {
      minutes = "${time.minute}";
    }

    return "expira em: ${time.day}/${time.month}/${time.year} ${time.hour}:$minutes";
  }
}

Future<void> _showOptionsRoom(BuildContext context,
    {required Function() delete, required Function() shareLink}) async {
  await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 50),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                onTap: shareLink,
                title: const Text("Compartilhar link"),
                trailing: Icon(Icons.share_rounded,
                    color: Theme.of(context).iconTheme.color)),
            const SizedBox(height: 50),
            ListTile(
                onTap: delete,
                title: const Text("Apagar Sala"),
                trailing:
                    Icon(Icons.delete, color: Theme.of(context).errorColor))
          ],
        );
      });
}
