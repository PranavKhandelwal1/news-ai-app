import 'package:flutter/material.dart';

class display_setting_screeen extends StatefulWidget {
  const display_setting_screeen({super.key});

  @override
  State<display_setting_screeen> createState() => _display_setting_screeenState();
}

class _display_setting_screeenState extends State<display_setting_screeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Display Setting"),
      ),
    );
  }
}
