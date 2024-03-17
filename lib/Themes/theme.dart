import 'package:flutter/material.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  hintColor: Colors.green,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue, // Define your primary color
    secondary: Colors.green, // Define your secondary color
    background: Color.fromARGB(229, 67, 67, 67), // Define your background color
    surface: Colors.white, // Define your surface color
    error: Colors.red, // Define your error color
    onPrimary: Colors.white, // Define text color on primary color
    onSecondary: Colors.black, // Define text color on secondary color
    onBackground: Colors.black, // Define text color on background color
    onSurface: Colors.black, // Define text color on surface color
    onError: Colors.white, // Define text color on error color
  ),
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color.fromARGB(255, 192, 193, 192),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  canvasColor: Colors.grey.shade400,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 239, 237, 237),
      foregroundColor: Colors.black),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue, // Define your primary color
    secondary: Colors.green, // Define your secondary color
    background:
        Color.fromARGB(228, 255, 255, 255), // Define your background color
    surface: const Color.fromARGB(255, 0, 0, 0), // Define your surface color
    error: Colors.red, // Define your error color
    onPrimary: Colors.white, // Define text color on primary color
    onSecondary: Colors.black, // Define text color on secondary color
    onBackground: Colors.black, // Define text color on background color
    onSurface: Colors.black, // Define text color on surface color
    onError: Colors.white, // Define text color on error color
  ),
  primaryColor: Colors.indigo,
  hintColor: Colors.amber,
  canvasColor: Colors.grey.shade400,
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color.fromARGB(255, 68, 68, 68),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 27, 28, 35),
      foregroundColor: Colors.white),
);
