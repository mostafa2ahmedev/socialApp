import 'package:flutter/material.dart';

class GlobalMethod {
  static void navigato(BuildContext context, {required Widget view}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return view;
        },
      ),
    );
  }

  static void navigatoReb(BuildContext context, {required Widget view}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) {
          return view;
        }),
      ),
    );
  }

  static void showSnakeBar(BuildContext context,
      {required String text, required Color backGroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        backgroundColor: backGroundColor,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 310,
          left: 10,
          right: 10,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Center(child: Text(text)),
      ),
    );
  }
}
