import 'package:flutter/material.dart';

class region_screen extends StatefulWidget {
  const region_screen({super.key});

  @override
  State<region_screen> createState() => _region_screenState();
}

class _region_screenState extends State<region_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Select Your Region"),
      ),
    );
  }
}
