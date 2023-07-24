import 'package:flutter/material.dart';

class CustomRowInfo extends StatelessWidget {
  const CustomRowInfo({super.key, required this.text, required this.text2});
  final String text;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              text2,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
