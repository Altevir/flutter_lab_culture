import 'package:flutter/material.dart';

class CustomClipperBackground extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();
    //(0,0) POINT 1
    path.lineTo(0, h); //1 > 2

    path.quadraticBezierTo(w * 0.5, h - 105, w, h);

    path.lineTo(w, h); //2 > 4
    path.lineTo(w, 0); //4 > 5
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
