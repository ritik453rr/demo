import 'package:flutter/material.dart';

/// A reusable button widget for the app
Widget appButton({
  required String title,
  required VoidCallback onPressed,
  Color backgroundColor = Colors.blue,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(16),
      backgroundColor: backgroundColor,
      visualDensity: VisualDensity.compact,
      minimumSize: Size(double.infinity, 50),
    ),
    onPressed: () {
      onPressed();
    }, 
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
