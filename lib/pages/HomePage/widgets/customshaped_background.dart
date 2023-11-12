import 'package:fairdraft/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomShapedBackground extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColor().primaryColor
      /*..shader = ui.Gradient.linear(
        const Offset(0,0),
        Offset(size.width,0),
        [
          const Color(0xffDD9737),
          const Color(0xffefd871),
        ],
      )*/
      ..strokeWidth = 20;

    var path1 = Path()
      ..moveTo(0,0)
      ..lineTo(0,size.height*0.63)
      ..quadraticBezierTo(10,size.height*0.98,size.width*0.19,size.height*1.02)
      ..lineTo(size.width-75,size.height*1.02)
      ..quadraticBezierTo(size.width*0.96,size.height*0.98,size.width,size.height*0.63)
      ..lineTo(size.width,0)
      ..lineTo(0,0);

   /* var path2 = Path()
      ..moveTo(0,0)
      ..lineTo(0,130)
      ..quadraticBezierTo(10,200,75,210)
      ..lineTo(size.width-75,210)
      ..quadraticBezierTo(size.width-10,200,size.width,130)
      ..lineTo(size.width,0)
      ..lineTo(0,0);*/

    canvas.drawPath(path1, paint);
    canvas.drawColor(Colors.white,BlendMode.colorBurn);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
