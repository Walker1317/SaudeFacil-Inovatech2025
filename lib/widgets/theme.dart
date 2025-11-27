import 'package:flutter/material.dart';

ThemeData appTheme(){

  Color baseColor = Colors.blue;//const Color(0xFF1FAE91);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: baseColor),
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white
    ),
    dividerTheme: DividerThemeData(
      color: Colors.black,
      thickness: 0.5
    )
  );
}