import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBox extends StatelessWidget {
   CustomBox({
     Key? key,
     this.color=Colors.white,
     this.width=0,
     this.height=0,
     this.borderRadius=0,
     this.child=const SizedBox(),
     this.padding=0,
     this.margin=0,
     this.boxShadow,
     this.gradient,
     this.boxShape=BoxShape.rectangle,
     this.borderWidth=0,
     this.borderColor=Colors.white,
     this.alignment
   }) : super(key: key);

   Color  color;
   Color  borderColor;
   double ?borderRadius;
   double width;
   double height;
   Widget child;
   double padding;
   double margin;
   List<BoxShadow> ?boxShadow;
   Gradient ?gradient;
   BoxShape boxShape;
   double borderWidth;
   AlignmentGeometry ?alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      alignment: alignment,
      decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          borderRadius: boxShape==BoxShape.circle?null:BorderRadius.circular(borderRadius??=borderRadius!),
          boxShadow: boxShadow,
          shape: boxShape,
        border: Border.all(
            width: borderWidth,
            color: borderColor)
      ),
      child: child,
    );
  }
}
