import 'package:flutter/material.dart';

class news_language_screen extends StatefulWidget {
  const news_language_screen({super.key});

  @override
  State<news_language_screen> createState() => _news_language_screenState();
}

class _news_language_screenState extends State<news_language_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Select Your Language"),
      ),
    );
  }
}
