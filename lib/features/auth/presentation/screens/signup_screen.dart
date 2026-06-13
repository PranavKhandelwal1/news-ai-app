import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_assistant/App_colors.dart';
import 'package:news_assistant/features/auth/presentation/screens/login_screen.dart';
import 'package:news_assistant/features/auth/providers/auth_provider.dart';

import 'package:news_assistant/shared/widgets/custom_text_field.dart';
import 'package:news_assistant/shared/widgets/primary_button.dart';
import 'package:news_assistant/shared/widgets/social_button.dart';

import '../../../../shared/widgets/bottom_nav.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  Future<void> _signUp() async {

    print("SIGNUP BUTTON CLICKED");

    if (!_formKey.currentState!.validate()) {
      print("FORM VALIDATION FAILED");
      return;
    }
    print("FORM VALIDATION PASSED");

    if (passwordController.text !=
        confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      print("CALLING AUTH SERVICE");
      await ref.read(authServiceProvider).signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print("AUTH SERVICE COMPLETED");
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created Successfully"),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const BottomNav(),
        ),
            (route) => false,
      );
    } catch (e, stackTrace) {

      debugPrint("SIGNUP ERROR:");
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _googleSignUp() {}

  void _appleSignIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 120),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Join News Assistant today",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  hintText: "Full Name",
                  controller: nameController,
                  validator: (value) {
                    print("NAME: '$value'");

                    if (value == null || value.trim().isEmpty) {
                      return "Name is required";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  hintText: "Email",
                  controller: emailController,
                  keyboardType:
                  TextInputType.emailAddress,
                  validator: (value) {
                    print("EMAIL: '$value'");

                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    }

                    if (!value.contains('@')) {
                      return "Enter valid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    print("PASSWORD: '$value'");

                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }

                    if (value.length < 6) {
                      return "Minimum 6 characters";
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                        !_obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  hintText: "Confirm Password",
                  controller:
                  confirmPasswordController,
                  obscureText:
                  _obscureConfirmPassword,
                  validator: (value) {
                    print("CONFIRM VALIDATOR: $value");

                    if (value == null || value.isEmpty) {
                      return "Confirm password required";
                    }

                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword =
                        !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 25),

                _isLoading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(
                  text: "Create Account",
                  onPressed: _signUp,
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SocialButton(
                  text: "Continue with Google",
                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: _googleSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}