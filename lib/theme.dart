// lib/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static final Color primary = const Color(0xFF6C5CE7); // vibrant purple
  static final Color accent = const Color(0xFFFF7675); // coral

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light),
    scaffoldBackgroundColor: Colors.white,

    // <- use BottomAppBarThemeData here
    bottomAppBarTheme: const BottomAppBarThemeData(color: Colors.white),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // If you hit types issues here, replace with AppBarThemeData(...) — but usually AppBarTheme is fine.
    ),

    // <- use CardThemeData here
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
    scaffoldBackgroundColor: const Color(0xFF0F1724),

    // <- use BottomAppBarThemeData here
    bottomAppBarTheme: const BottomAppBarThemeData(color: Colors.black54),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),

    cardTheme: const CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
  );
}
