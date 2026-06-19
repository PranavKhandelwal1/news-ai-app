import 'package:flutter/material.dart';

class CustomProfileOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const CustomProfileOptions({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: color,
      ),
      onTap: onTap,
    );
  }
}