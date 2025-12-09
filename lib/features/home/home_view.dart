import 'dart:math';
import 'package:demo/core/services/app_local_notifications.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  AppLocalNotification.showNotification(
                    notiId: Random().nextInt(1000000),
                    title: "Test Notification",
                    body: "This is test notification",
                  );
                },
                child: Text("Local Notification"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
