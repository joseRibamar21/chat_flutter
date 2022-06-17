import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../chat_controller.dart';

class AppBarSender extends StatelessWidget {
  const AppBarSender({Key? key}) : super(key: key);

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
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 50),
                context: context,
                builder: (context) {
                  return _ListSenders(controller: controller);
                });
          },
          title: Text(
            controller.nickG,
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
  List<String> _list = [];

  @override
  void initState() {
    _list = widget.controller.getlistSnders;
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
          StreamBuilder<List<String>>(
            stream: widget.controller.listSendersStream,
            builder: ((context, snapshot) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 150),
                child: Container(
                  color: Colors.grey[100],
                  child: ListView(
                    shrinkWrap: true,
                    children: _list
                        .map<Widget>((e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.green,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            }),
          )
        ],
      );
    });
  }
}
