import 'package:demo/core/app_constants.dart';
import 'package:demo/core/routes/app_routes.dart';
import 'package:demo/core/services/app_local_notifications.dart';
import 'package:demo/core/services/firebase_services.dart';
import 'package:demo/core/theme/app_colors.dart';
import 'package:demo/core/theme/app_theme.dart';
import 'package:demo/features/auth/view/login/login_view.dart';
import 'package:demo/features/messages/view/chat_view.dart';
import 'package:demo/features/home/home_view.dart';
import 'package:demo/features/share/share_view.dart';
import 'package:demo/storage/app_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocalNotification.initialize();
  await AppStorage.init();
  AppConstants.setSafeArea(isDark: false);
  await FirebaseServices.init();
  // var fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  build(BuildContext context) async {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          AppStorage.getLoginStatus() ? AppRoutes.home : AppRoutes.login,
      theme: AppTheme.lightTheme(),
      routes: {
        AppRoutes.login: (context) => LoginView(),
        AppRoutes.home: (context) => HomeView(),
        AppRoutes.chat: (context) => ChatView(),
        AppRoutes.share: (context) => ShareView(),
      },
    );
  }
}
