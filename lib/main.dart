import 'dart:async';
import 'package:demo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'circle_progress/circle_step_indicator_page.dart';

void main() {
  /// Runs the app inside a guarded zone to catch all uncaught async errors.
  runZonedGuarded(() async {

    /// Ensures Flutter engine and binding are initialized before app starts.
    WidgetsFlutterBinding.ensureInitialized();

    /// Initializes Firebase with platform-specific configuration.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Crashlytics is not supported on Flutter Web.
    if (!kIsWeb) {

      /// Enables Crashlytics crash data collection.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);

      /// Captures Flutter framework fatal errors automatically.
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      /// Captures platform, isolate, and async uncaught errors.
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        );
        return true;
      };
    }

    /// Starts the Flutter application.
    runApp(const MyApp());

  }, (error, stack) {

    /// Records all uncaught zone-level errors into Crashlytics.
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
    }
  });
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    /// Main application configuration.
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CircleStepIndicatorPage(), // Replace with your desired home page widget
    );
  }
}