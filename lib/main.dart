import 'package:demo/core/app_constants.dart';
import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/core/services/app_local_notifications.dart';
import 'package:demo/core/services/firebase_services.dart';
import 'package:demo/features/home/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocalNotification.initialize();
  AppConstants.setSafeArea(isDark: false);
  await FirebaseServices.init();
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {AppRoutes.home: (context) => HomeView()},
    );
  }
}
