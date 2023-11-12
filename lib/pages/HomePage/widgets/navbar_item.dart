import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
   NavBarItem({Key? key,this.icon,this.label}) : super(key: key);

   Widget ?icon;
   Widget ?label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon!,
        label!
      ],
    );
  }
}
