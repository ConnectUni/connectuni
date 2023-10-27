import 'package:flutter/material.dart';
class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black12,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );
}