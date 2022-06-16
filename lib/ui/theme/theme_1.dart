import 'package:flutter/material.dart';

ThemeData makeTheme1() {
  const Color primary = Color(0xFF1D356C);
  const Color secondary = Color(0xFF1C6892);

  TextTheme textTheme = const TextTheme(
      titleMedium: TextStyle(fontSize: 18),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));

  AppBarTheme appBarTheme = const AppBarTheme(
      backgroundColor: primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white));

  PopupMenuThemeData popupMenuTheme = const PopupMenuThemeData(
      color: secondary,
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));

  InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
      border: InputBorder.none,
      labelStyle: TextStyle(color: Color.fromARGB(195, 255, 255, 255)),
      hintStyle: TextStyle(color: Color.fromARGB(195, 255, 255, 255)));

  ListTileThemeData listTileThemedata =
      const ListTileThemeData(style: ListTileStyle.drawer);

  return ThemeData(
      primaryColor: secondary,
      appBarTheme: appBarTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      inputDecorationTheme: inputDecorationTheme,
      listTileTheme: listTileThemedata,
      popupMenuTheme: popupMenuTheme,
      useMaterial3: true,
      textTheme: textTheme);
}
