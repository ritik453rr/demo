import 'package:demo/drag_sheet/drag_sheet_page.dart';
import 'package:demo/expension_tile/expension_tile_page.dart';
import 'package:demo/progress_bar/smooth_progress_bar.dart';
import 'package:demo/progress_bar/step_progress_bar.dart';
import 'package:flutter/material.dart';

import 'circle_progress/circle_step_indicator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:DragSheetPage()
    );
  }
}
