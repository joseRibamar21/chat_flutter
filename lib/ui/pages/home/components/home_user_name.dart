import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/entities.dart';
import '../home.dart';

class HomeUserName extends StatelessWidget {
  const HomeUserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var presenter = Provider.of<HomePresenter>(context);
    return StreamBuilder<UserEntity?>(
      stream: presenter.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Codinome: ${snapshot.data?.name ?? ""}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const Divider()
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
