import 'package:flutter/material.dart';

class LoginComponent extends StatelessWidget {
  const LoginComponent({super.key, required this.iconData, this.color});
  final IconData iconData;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      child: Icon(iconData),
    );
  }
}
