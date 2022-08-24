import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './factory/pages/pages.dart';
import '../ui/theme/theme.dart';

void inicialization() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Secreto',
      debugShowCheckedModeBanner: false,
      theme: makeTheme2(),
      defaultTransition: Transition.leftToRightWithFade,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: makeSplashPage),
        GetPage(name: "/register", page: () => makeRegisterPage(context)),
        GetPage(
            name: "/chat/:nick/:link",
            page: makeChatPage,
            fullscreenDialog: true),
        GetPage(name: "/home", page: makeHomePage),
        GetPage(
          name: "/config",
          page: makeConfigPage,
          /* opaque: true,
            maintainState: true, */
        ),
      ],
    );
  }
}
