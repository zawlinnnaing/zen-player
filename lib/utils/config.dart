import 'dart:developer';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black87,
  backgroundColor: Colors.black54,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.black54,
      iconTheme: IconThemeData(color: Colors.white)),
  inputDecorationTheme:
      InputDecorationTheme(focusedBorder: OutlineInputBorder()),
  dividerColor: Colors.grey.shade200,
  textTheme: TextTheme(
      subtitle2: TextStyle(fontSize: 12, color: Colors.white38),
      subtitle1: TextStyle(fontSize: 14, color: Colors.white54),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white)),
  colorScheme: ColorScheme.dark(
      secondary: Colors.grey.shade200, secondaryVariant: Colors.white),
);
final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.black,
  backgroundColor: Colors.white,
  // inputDecorationTheme: , appBarTheme:
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black)),
  iconTheme: IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    subtitle2: TextStyle(fontSize: 12, color: Colors.black38),
    subtitle1: TextStyle(fontSize: 14, color: Colors.black45),
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    bodyText1: TextStyle(fontSize: 14, color: Colors.black),
    bodyText2: TextStyle(fontSize: 14, color: Colors.black87),
  ),
  dividerColor: Colors.black87,
  colorScheme: ColorScheme.light(
      secondary: Colors.black87,
      secondaryVariant: Colors.black,
      onSurface: Colors.black87,
      onBackground: Colors.black87),
);
const Color accentColor = Color(0xFF9B51E0);
final Color warningColor = Colors.amberAccent;
const double appbarHeight = 48;
