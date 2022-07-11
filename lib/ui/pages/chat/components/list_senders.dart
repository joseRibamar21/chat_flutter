import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../chat_controller.dart';

class AppBarSender extends StatelessWidget {
  final String name;
  const AppBarSender({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ChatController>(context);
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
          title: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: const Text(
            "Lista de presentes",
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
    );
  }
}

class _ListSenders extends StatefulWidget {
  final ChatController controller;

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
          )
        ],
      );
    });
  }
}
