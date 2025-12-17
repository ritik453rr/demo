import 'dart:math';
import 'package:demo/core/services/app_local_notifications.dart';
import 'package:demo/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          // height: double.infinity,
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text("Title")),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  30.h,
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.red,
                    child: Text("Button"),
                  ),
                  30.h,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 // ElevatedButton(
              //   onPressed: () {
              //     AppLocalNotification.showNotification(
              //       notiId: Random().nextInt(1000000),
              //       title: "Test Notification",
              //       body: "This is test notification",
              //     );
              //   },
              //   child: Text("Local Notification"),
              // ),
