import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuario"),
      ),
      bottomSheet: Container(
        height: 60,
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autocorrect: true,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(hintText: "Digite algo..."),
              ),
            )),
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Builder(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return index % 2 == 0
                          ? const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 30),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras lacinia magna non faucibus auctor. Maecenas vestibulum arcu magna, sed congue nulla maximus eu. Suspendisse pellentesque mauris nec nibh tempor, a consectetur nunc vestibulum. Morbi id mi felis. Duis vel dolor nisl. Pellentesque luctus tellus odio, quis pulvinar sapien volutpat consectetur. Curabitur ultrices vitae nisl ut scelerisque. Vestibulum at justo eget libero eleifend feugiat. Donec finibus pharetra turpis, id mollis diam lobortis quis."),
                                  ),
                                ),
                              ),
                            )
                          : const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 30, right: 10),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                        "Nam ac velit rhoncus, placerat odio id, gravida nibh."),
                                  ),
                                ),
                              ),
                            );
                    }),
              ),
            ),
            const SizedBox(height: 60)
          ],
        );
      }),
    );
  }
}
