import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './factory/pages/pages.dart';
import '../ui/pages/pages.dart';
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
      initialRoute: "/register",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(name: "/register", page: makeRegisterPage),
        GetPage(
            name: "/chat/:name/:room/:password",
            page: makeChatPage,
            fullscreenDialog: true),
        GetPage(name: "/home", page: makeHomePage),
      ],
    );
  }
}
