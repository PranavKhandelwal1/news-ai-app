import 'package:flutter/material.dart';

class customize_your_feed_screen  extends StatefulWidget {
  const customize_your_feed_screen ({super.key});

  @override
  State<customize_your_feed_screen> createState() => _customize_your_feed_screenState();
}

class _customize_your_feed_screenState extends State<customize_your_feed_screen > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Customize Your Feed"),
      ),
    );
  }
}
