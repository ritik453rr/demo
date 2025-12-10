import 'package:flutter/material.dart';

custommAppBar({String title = ""}) {
  return AppBar(
    title: title.isEmpty ? null : Text(title),
  );
}
