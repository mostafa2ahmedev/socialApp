import 'package:flutter/material.dart';

class LoginComponent extends StatelessWidget {
  const LoginComponent(
      {super.key, required this.iconData, this.color, required this.ontap});
  final IconData iconData;
  final Color? color;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CircleAvatar(
        backgroundColor: color,
        radius: 22,
        child: Icon(iconData),
      ),
    );
  }
}
