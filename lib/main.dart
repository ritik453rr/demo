import 'package:demo/app_calendar/app_calendar_one.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Main application configuration.
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppCalendarOne(),
    );
  }
}
