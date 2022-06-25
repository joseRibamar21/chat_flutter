import 'package:flutter/material.dart';

ThemeData makeTheme2() {
  const Color color1 = Color(0xFF112626);
  const Color color2 = Color(0xFF3D7373);
  const Color color3 = Color(0xFF15403B);
  //const Color color4 = Color(0xFF91D9D2);
  const Color color5 = Color(0xFF3E8C3B);

  const Color textColor = Colors.white;
  const Color labelColor = Colors.grey;

  const Color dividerColor = Colors.white;
  const Color cardColor = Colors.white;

  TextTheme textTheme = const TextTheme(
    titleLarge:
        TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.w500),
    titleMedium:
        TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.w500),
    titleSmall:
        TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: textColor),
    bodySmall:
        TextStyle(fontSize: 12, color: labelColor, fontStyle: FontStyle.italic),
  );

  AppBarTheme appBarTheme = const AppBarTheme(
      backgroundColor: color1,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white));

  CardTheme cardTheme =
      const CardTheme(color: color2, surfaceTintColor: cardColor);

  DividerThemeData dividerThemeData =
      const DividerThemeData(color: dividerColor);

  DialogTheme dialogTheme = const DialogTheme(
    backgroundColor: color2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );

  FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData(shape: CircleBorder());

  PopupMenuThemeData popupMenuTheme = const PopupMenuThemeData(
      color: color2,
      textStyle: TextStyle(
          color: textColor, fontSize: 16, fontWeight: FontWeight.bold));

  InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    border: InputBorder.none,
    labelStyle: TextStyle(color: labelColor),
    hintStyle: TextStyle(color: labelColor),
  );

  ListTileThemeData listTileThemedata =
      const ListTileThemeData(style: ListTileStyle.drawer);

  BottomSheetThemeData sheetThemeData = const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  );

  TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: textTheme.bodyMedium));

  return ThemeData(
    appBarTheme: appBarTheme,
    bottomSheetTheme: sheetThemeData,
    cardTheme: cardTheme,
    cardColor: color5,
    colorScheme: ColorScheme.fromSeed(seedColor: color1),
    dialogTheme: dialogTheme,
    backgroundColor: Colors.amber,
    dividerTheme: dividerThemeData,
    floatingActionButtonTheme: floatingActionButtonThemeData,
    primaryColor: color1,
    inputDecorationTheme: inputDecorationTheme,
    listTileTheme: listTileThemedata,
    popupMenuTheme: popupMenuTheme,
    scaffoldBackgroundColor: color3,
    textButtonTheme: textButtonThemeData,
    textTheme: textTheme,
    useMaterial3: true,
  );
}
