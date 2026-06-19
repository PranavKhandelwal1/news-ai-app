import 'package:flutter/material.dart';

class ai_voice_screen extends StatefulWidget {
  const ai_voice_screen({super.key});

  @override
  State<ai_voice_screen> createState() => _ai_voice_screenState();
}

class _ai_voice_screenState extends State<ai_voice_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Voice"),
      ),
    );
  }
}
