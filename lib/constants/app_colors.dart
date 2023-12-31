import 'package:flutter/material.dart';

class AppColor{

  MaterialColor get primaryColor => MaterialColor(0xffffbd31, color);

  Color get bgColor => const Color(0xffeceff1);

  Color proceedColor = Colors.green;

  Color notYet = Colors.green[200]!;

  Map<int, Color> color =
  {
    50: const Color.fromRGBO(255,189,49, .1),
    100:const Color.fromRGBO(255,189,49, .2),
    200:const Color.fromRGBO(255,189,49, .3),
    300:const Color.fromRGBO(255,189,49, .4),
    400:const Color.fromRGBO(255,189,49, .5),
    500:const Color.fromRGBO(255,189,49, .6),
    600:const Color.fromRGBO(255,189,49, .7),
    700:const Color.fromRGBO(255,189,49, .8),
    800:const Color.fromRGBO(255,189,49, .9),
    900:const Color.fromRGBO(255,189,49,  1),
  };

}