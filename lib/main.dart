import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './ui/theme/theme.dart';
import './ui/pages/pages.dart';

void main() {
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
        GetPage(name: "/register", page: () => const RegisterPage()),
        GetPage(
            name: "/chat/:name/:room/:password",
            page: () => ChatPage(),
            fullscreenDialog: true),
      ],
    );
  }
}
