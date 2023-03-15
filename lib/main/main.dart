import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_flutter/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './factory/pages/pages.dart';
import '../ui/theme/theme.dart';

void inicialization() {
  WidgetsFlutterBinding();
  Provider.debugCheckInvalidValueType = null;
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        playSound: false,
        channelShowBadge: true,
        channelDescription: '',
      ),
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

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
            name: "/chat/:user/:link",
            page: makeChatPage,
            fullscreenDialog: true),
        GetPage(name: "/home", page: makeHomePage),
        GetPage(name: "/expirate", page: makeExpirateCode),
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
