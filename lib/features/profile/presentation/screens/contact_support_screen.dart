import 'package:flutter/material.dart';

class contact_support_screen extends StatefulWidget {
  const contact_support_screen({super.key});

  @override
  State<contact_support_screen> createState() => _contact_support_screenState();
}

class _contact_support_screenState extends State<contact_support_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Contact & Support"),
      ),
    );
  }
}
