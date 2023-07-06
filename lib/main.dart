import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foyer/model/DeviceProfileModel.dart';
import 'package:foyer/Screens/homescreen/homescreen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Default theme
      darkTheme: ThemeData.dark(), // Optional: Add dark theme
      home: HomeScreen(),
    );
  }
}
