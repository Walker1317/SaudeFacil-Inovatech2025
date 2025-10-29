import 'package:flutter/material.dart';

ThemeData appTheme(){

  Color baseColor = const Color(0xFF1FAE91);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: baseColor),
    appBarTheme: AppBarThemeData(
      backgroundColor: baseColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0D7B57),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20)
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.black,
      thickness: 0.5
    )
  );
}