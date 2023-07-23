import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width * 0.4, size.height, size.width * .6, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.7, size.height * .35,
        size.width * 0.9, size.height * 0.33);
    path.quadraticBezierTo(size.width * 0.98, size.height * .3,
        size.width * 0.94, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.91, size.height * .15,
        size.width * 0.85, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * .22, size.width * 0.58, 0);
    // path.quadraticBezierTo(size.width * 0.88, size.height * .25,
    //     size.width * 0.78, size.height * 0.15);
    // path.quadraticBezierTo(
    //     size.width * 0.6, size.height * .2, size.width * 0.5, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
