import 'package:flutter/material.dart';

ThemeData lighTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        )));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff00251a),
    appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: Color(0xff00251a),
        iconTheme: IconThemeData(
          color: Colors.white,
        )));
