import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/bottom_nav.dart';
import 'login_screen.dart';
import '../../../news/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  /// Decide where to navigate after splash
  void _checkAuthState() {

    Timer(
      const Duration(seconds: 2),
          () {

            print("CHECKING AUTH STATE");

            final user = FirebaseAuth.instance.currentUser;

            print("USER = ${user?.email}");

        if (!mounted) return;

        if (user != null) {
          print("GOING TO BOTTOM NAV");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const BottomNav(),
            ),
          );

        } else {
          print("GOING TO LOGIN");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                print("CREATING LOGIN SCREEN");
                return const LoginScreen();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'News Assistant',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}