import 'package:firebasepro/core/Colors.dart';
import 'package:flutter/material.dart';

class Styles {
  //Dark
  static const bodyLargeStyleDark = TextStyle();
  static const bodySmallStyleDark = TextStyle();
  static const bodyMeduimStyleDark = TextStyle();
  static const titleStyleDark = TextStyle();
  //light
  static const bodyLargeStyleLight = TextStyle();
  static const bodySmallStyleLight = TextStyle();
  static final bodyMeduimStyleLight = TextStyle(
    color: ColorsApp.bodyBlackColorLight.withOpacity(0.5),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const titleStyleLight = TextStyle(
      color: ColorsApp.titleBlackColorLight,
      fontSize: 25,
      fontWeight: FontWeight.bold,
      fontFamily: 'Janna');
}
