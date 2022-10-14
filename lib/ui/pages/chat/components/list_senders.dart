import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../chat.dart';

class AppBarSender extends StatelessWidget {
  final String name;
  const AppBarSender({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ChatPresenter>(context);
    return SizedBox(
      height: 60,
      child: ListTile(
        isThreeLine: true,
        onTap: () async {
          await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 50),
              context: context,
              builder: (context) {
                return _ListSenders(controller: controller);
              });
        },
        title: StreamBuilder<String?>(
            stream: controller.roomNameString,
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? "Sala",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              );
            }),
        subtitle: StreamBuilder<String?>(
          stream: controller.userMessageTypingStream,
          builder: (context, snapshot) {
            return snapshot.data != null
                ? Text(
                    "${snapshot.data} esta digitando...",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  )
                : const Text(
                    "Opções da sala",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
          },
        ),
      ),
    );
  }
}

class _ListSenders extends StatefulWidget {
  final ChatPresenter controller;

  const _ListSenders({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<_ListSenders> createState() => __ListSendersState();
}

class __ListSendersState extends State<_ListSenders> {
  List<Map<String, dynamic>> _list = [];

  @override
  void initState() {
    _list = widget.controller.getlistSenders();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Divider(thickness: 3),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Opções",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: Icon(Icons.copy_outlined,
                color: Theme.of(context).iconTheme.color),
            title: Text(
              "Copiar codigo da sala",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onTap: () {
              FlutterClipboard.copy(widget.controller.link ?? "").then((value) {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 100)).then(
                    (value) => Fluttertoast.showToast(
                        msg: "Copiado",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[800],
                        textColor: Colors.white,
                        fontSize: 16.0));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.web_outlined,
                color: Theme.of(context).iconTheme.color),
            title: Text(
              "Copiar link da sala",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            onTap: () {
              FlutterClipboard.copy(
                      "143.244.167.43/#/chat/${widget.controller.nameRoomlink}/${widget.controller.link}")
                  .then((value) {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 100)).then(
                    (value) => Fluttertoast.showToast(
                        msg: "Copiado",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[800],
                        textColor: Colors.white,
                        fontSize: 16.0));
              });
            },
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app_rounded,
                  color: Theme.of(context).iconTheme.color),
              title: Text(
                "Encerrar Sala",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              onTap: widget.controller.finishRoom),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Text(
              "Presentes na sala",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: widget.controller.listSendersStream,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                _list = snapshot.data!;
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 150),
                child: ListView(
                  shrinkWrap: true,
                  children: _list.isEmpty
                      ? const [
                          Center(child: Text("Vc está sozinho aqui!")),
                          SizedBox(height: 20)
                        ]
                      : _list
                          .map<Widget>((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e["user"] ?? "Error",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: e["status"] == 1
                                          ? Colors.green
                                          : e["status"] == 4
                                              ? Colors.grey[500]
                                              : Theme.of(context).errorColor,
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
