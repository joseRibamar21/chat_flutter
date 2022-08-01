import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class HomeUserName extends StatelessWidget {
  const HomeUserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<HomePresenter>(context);
    return StreamBuilder<String>(
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
        });
  }
}
