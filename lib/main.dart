import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './ui/theme/theme.dart';
import './ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: makeTheme1(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(name: "/home", page: () => const HomePage()),
        GetPage(
            name: "/chat",
            page: () => const ChatPage(),
            fullscreenDialog: true),
      ],
    );
  }
}
