import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
        title: const Text("Chat"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Builder(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          function: () {},
                          icon: Icons.person_add_rounded,
                          title: "Adicionar"),
                      ElevatedButtonCustom(
                        function: () {},
                        icon: Icons.group_add_rounded,
                        title: "Reunião",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Salas",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 20,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed('/chat');
                      },
                      title: const Text("Usuario"),
                      subtitle: const Text("Mensagem"),
                      trailing: const CircleAvatar(
                        child: Text("1"),
                      ),
                    );
                  })
            ],
          ),
        );
      }),
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
