import 'package:flutter/material.dart';

class AppTheme {
  static const Color purple = Color(0xFFB891F9); // utama
  static const Color purpleDark = Color(0xFF6C3FB8);
  static const Color bgColor = Color(0xFFF7F2FD);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgColor,
      primaryColor: purple,
      appBarTheme: const AppBarTheme(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: purple),
    );
  }
}
