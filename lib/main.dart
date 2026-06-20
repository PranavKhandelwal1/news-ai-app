import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/auth/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
void main() async {
  // Ensure Flutter is Initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      print("BEFORE FIREBASE");
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("AFTER FIREBASE");
    }
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint("FLUTTER ERROR:");
    debugPrint(details.exceptionAsString());
  };

  runApp(
    // Riverpod requires a root ProviderScope.
    const ProviderScope(
      child: NewsAssistant(),
    ),
  );
}

/// Root widget of the application
class NewsAssistant extends StatelessWidget {
  const NewsAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App name shown by the operating system
      title: 'News Assistant',

      // Removes debug banner from top-right corner
      debugShowCheckedModeBanner: false,

      // Global application theme
      theme: AppTheme.lightTheme,

      // First screen displayed when app launches
      home: const SplashScreen(),
    );
  }
}
