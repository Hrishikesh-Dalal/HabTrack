import 'package:flutter/material.dart';
import 'package:habits/Pages/Choose_Habit.dart';
import 'package:habits/Pages/HomePage.dart';
import 'package:habits/Pages/WeatherPage.dart';
// import 'package:habits/Themes/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Import the theme file

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
