import 'package:flutter/material.dart';
import 'colors.dart';

var lightTheme = ThemeData(
  brightness: Brightness.light,
);
var darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: dContainerColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: dOnBackgroundColor),
    ),
    colorScheme: const ColorScheme.dark(
        primary: dPrimaryColor,
        onPrimary: dOnBackgroundColor,
        error: dErrorColor,
        onError: dOnBackgroundColor,
        surface: dBackgroundColor,
        onSurface: dOnBackgroundColor,
        primaryContainer: dContainerColor,
        onPrimaryContainer: donContainerColor),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 32,
          color: dPrimaryColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w800),
      headlineMedium: TextStyle(
          fontSize: 30,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          fontSize: 20,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600),
      labelLarge: TextStyle(
          fontSize: 15,
          color: donContainerColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400),
      labelMedium: TextStyle(
          fontSize: 12,
          color: donContainerColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400),
      labelSmall: TextStyle(
          fontSize: 10,
          color: donContainerColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w300),
      bodyLarge: TextStyle(
          fontSize: 18,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          fontSize: 15,
          color: dOnBackgroundColor,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: dBackgroundColor,
      filled: true,
    ));
