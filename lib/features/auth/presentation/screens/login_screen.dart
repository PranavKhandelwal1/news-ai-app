import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_assistant/App_colors.dart';
import 'package:news_assistant/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:news_assistant/features/auth/presentation/screens/signup_screen.dart';
import 'package:news_assistant/features/auth/providers/auth_provider.dart';
import 'package:news_assistant/shared/widgets/custom_text_field.dart';
import 'package:news_assistant/shared/widgets/primary_button.dart';
import 'package:news_assistant/shared/widgets/social_button.dart';

import '../../../../shared/widgets/bottom_nav.dart';
import '../../../news/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  // Controllers used to read and manage the text entered
  // in the email and password fields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the screen is removed
    // from the widget tree to prevent memory leaks.
    emailController.dispose();
    passwordController.dispose();

    // Always call super.dispose() last.
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      await ref.read(authServiceProvider).signIn(
        email: emailController.text,
        password: passwordController.text,
      );

      // The widget might have been disposed while waiting
      // for the Firebase request to complete.
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );

      // TODO:
      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const BottomNav(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Prevent using context if the widget has already
      // been removed from the widget tree.
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login Failed')),
      );
    }
  }

  void _googleSignIn() {
    // TODO: Google Sign In
  }

  void _appleSignIn() {
    // TODO: Apple Sign In
  }

  @override
  Widget build(BuildContext context) {
    print("LOGIN SCREEN BUILD START");
    try{
      return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  const Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      "Sign in to continue",
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 2),

                  CustomTextField(
                    hintText: "Enter your email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 2),

                  CustomTextField(
                    hintText: "Enter your password",
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  // const SizedBox(height: 0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  PrimaryButton(text: "Sign In", onPressed: _login),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          //this will avoid screen stack
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Or continue with"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SocialButton(
                    text: "Continue with Apple",
                    icon: const Icon(Icons.apple, color: Colors.black),
                    onPressed: _appleSignIn,
                  ),

                  const SizedBox(height: 15),

                  SocialButton(
                    text: "Continue with Google",
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 30,
                      color: Colors.red,
                    ),
                    onPressed: _googleSignIn,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }catch (e, st) {
      print("LOGIN BUILD ERROR: $e");
      print(st);

      return const Scaffold(
        body: Center(
          child: Text("Login Build Error"),
        ),
      );
    }
  }
}
