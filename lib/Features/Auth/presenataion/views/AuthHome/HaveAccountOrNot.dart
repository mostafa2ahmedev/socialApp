import 'package:firebasepro/core/globalMethods.dart';
import 'package:flutter/material.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot(
      {super.key,
      required this.text,
      required this.textButton,
      required this.widget});
  final String text;
  final String textButton;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextButton(
          onPressed: () {
            GlobalMethod.navigatoReb(context, view: widget);
          },
          child: Text(
            textButton,
            style: const TextStyle(
                fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
