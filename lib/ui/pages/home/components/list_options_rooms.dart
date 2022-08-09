import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'components.dart';

class HomeListOptionsRooms extends StatefulWidget {
  const HomeListOptionsRooms({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeListOptionsRooms> createState() => _HomeListOptionsRoomsState();
}

class _HomeListOptionsRoomsState extends State<HomeListOptionsRooms> {
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<HomePresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isSeachingStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _isOpen = !snapshot.data!;
          }
          return !_isOpen
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 100,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        _ElevatedButtonCustom(
                          function: () async {
                            var t = await newRoomDialog(context);
                            if (t != null) {
                              presenter.saveRooms(t, null);
                            }
                          },
                          icon: Icons.group_add_rounded,
                          title: "Nova Reunião",
                        ),
                        _ElevatedButtonCustom(
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
                );
        });
  }
}

class _ElevatedButtonCustom extends StatelessWidget {
  final IconData icon;
  final Function() function;
  final String? title;
  const _ElevatedButtonCustom(
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
