import 'package:flutter/material.dart';

class CustomProfileOptions extends StatelessWidget {
  final String title;
  final Widget trailing;

  const CustomProfileOptions({
    super.key,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      trailing: trailing,
    );
  }
}