import 'package:flutter/material.dart';

ThemeData makeTheme2() {
  const Color color1 = Color(0xFF112626);
  const Color color2 = Color(0xFF3D7373);
  const Color color3 = Color(0xFF15403B);
  const Color color4 = Color(0xFF91D9D2);
  const Color color5 = Color(0xFF3E8C3B);

  TextTheme textTheme = const TextTheme(
      titleMedium: TextStyle(fontSize: 18),
      titleSmall: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic));

  AppBarTheme appBarTheme = const AppBarTheme(
      backgroundColor: color1,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white));

  CardTheme cardTheme =
      const CardTheme(color: color2, surfaceTintColor: Colors.white);

  DividerThemeData dividerThemeData =
      const DividerThemeData(color: Colors.white);

  PopupMenuThemeData popupMenuTheme = const PopupMenuThemeData(
      color: color2,
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));

  InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
      border: InputBorder.none,
      labelStyle: TextStyle(color: Color.fromARGB(195, 255, 255, 255)),
      hintStyle: TextStyle(color: Color.fromARGB(195, 255, 255, 255)));

  ListTileThemeData listTileThemedata =
      const ListTileThemeData(style: ListTileStyle.drawer);

  BottomSheetThemeData sheetThemeData = const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  );

  return ThemeData(
      primaryColor: color1,
      appBarTheme: appBarTheme,
      cardTheme: cardTheme,
      cardColor: color5,
      colorScheme: ColorScheme.fromSeed(seedColor: color1),
      dividerTheme: dividerThemeData,
      inputDecorationTheme: inputDecorationTheme,
      listTileTheme: listTileThemedata,
      popupMenuTheme: popupMenuTheme,
      useMaterial3: true,
      bottomSheetTheme: sheetThemeData,
      scaffoldBackgroundColor: color3,
      textTheme: textTheme);
}
