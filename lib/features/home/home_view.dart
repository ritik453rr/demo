import 'dart:math';
import 'package:demo/core/common/app_button.dart';
import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/core/services/app_local_notifications.dart';
import 'package:demo/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Home View")),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appButton(
                title: "Share View",
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.share);
                },
              ),
              10.h,
              appButton(title: "Message View", onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.chat);
              })
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
