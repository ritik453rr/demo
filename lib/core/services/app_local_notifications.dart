import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// A helper class to manage local notifications, including initialization, permission requests, showing, and scheduling notifications.
class AppLocalNotification {
  //// Local Notifications Start....
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  /// Initializes the local notification plugin, requests permissions, and sets up channels.
  static Future<void> initialize() async {
    tz.initializeTimeZones();
    await requestNotificationPermissions();
    // for Android
    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    // for iOS
    const initSettingsIos = DarwinInitializationSettings();
    // for both platforms
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIos,
    );
    // initialize the plugin with the settings
    await notificationPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
    // Added notification channel creation (required for Android 8.0+)
    await createNotificationChannel();
  }

  // notification channel creation (required for Android 8.0+)
  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channelId',
      'channelName',
      description: 'description',
      importance: Importance.max,
      playSound: true, // Added sound option
    );

    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  //  Request notification permissions for iOS and Android.
  static Future<void> requestNotificationPermissions() async {
    // for iOS
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // for Android
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// Show notification with title and body
  static Future<void> showNotification({
    required int notiId,
    required String title,
    required String body,
  }) async {
    await notificationPlugin.show(notiId, title, body, notificationDetails());
  }

  /// Notification details for Android and iOS
  static NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }
}