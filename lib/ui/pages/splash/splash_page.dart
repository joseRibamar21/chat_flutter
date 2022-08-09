import 'package:flutter/material.dart';

import '../../mixins/mixins.dart';
import 'splash.dart';

class SplashPage extends StatelessWidget with NavigationManager {
  final SplashPresenter presenter;
  const SplashPage({Key? key, required this.presenter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.inicialization();
        handleNaviationLogin(presenter.toNavigationStream);

        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset("lib/ui/assets/imgs/icon.png",
                fit: BoxFit.fitWidth,
                color: Theme.of(context).secondaryHeaderColor),
          ),
        );
      }),
    );
  }
}
