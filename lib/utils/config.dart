import 'package:flutter/material.dart';final ThemeData darkTheme = ThemeData.dark().copyWith(    inputDecorationTheme:        InputDecorationTheme(focusedBorder: OutlineInputBorder()),    colorScheme: ColorScheme.dark(        secondary: Colors.brown.shade300,        secondaryVariant: Colors.brown.shade700));final ThemeData lightTheme = ThemeData.light().copyWith(  inputDecorationTheme: InputDecorationTheme(    hintStyle: TextStyle(color: Colors.white60),  ),  colorScheme: ColorScheme.light(    primary: Colors.indigo,    secondary: Colors.tealAccent,  ),);