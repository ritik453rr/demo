import 'package:flutter/material.dart';

class ProgressBarPage extends StatefulWidget {
  const ProgressBarPage({super.key});

  @override
  State<ProgressBarPage> createState() => _ProgressBarPageState();
}

class _ProgressBarPageState extends State<ProgressBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Progress bar")));
  }
}
