import 'package:demo/core/services/app_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Provides initialization and handling of Firebase push notifications in the app.
class FirebaseServices {

  /// Initializes Firebase for the app and sets up notification handlers.
  static Future<void> init() async {
    await Firebase.initializeApp();


    /// Forground Notification....
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      AppLocalNotification.showNotification(
        notiId: DateTime.now().microsecondsSinceEpoch.remainder(100000),
        title: msg.notification?.title ?? "No Title",
        body: msg.notification?.body ?? "No Body",
      );
    });


     /// Trigger when app is in the background..
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);


    /// Trigger when user tap on notification
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print("👆 Notification tapped (background)}");


      // Handle navigation or action here
    });


    /// Terminated Notification.....
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? msg) {
      if (msg != null) {
        AppLocalNotification.showNotification(
          notiId: DateTime.now().microsecondsSinceEpoch.remainder(100000),
          title: msg.notification?.title ?? "No Title",
          body: msg.notification?.body ?? "No Body",
        );
      }
    });
  }
}

/// Handles incoming Firebase messages in the background and shows a local notification.
Future<void> backgroundHandler(RemoteMessage msg) async {
  AppLocalNotification.showNotification(
    notiId: DateTime.now().microsecondsSinceEpoch.remainder(100000),
    title: msg.notification?.title ?? "No Title",
    body: msg.notification?.body ?? "No Body",
  );
}
