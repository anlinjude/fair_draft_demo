import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.color=Colors.white,
    this.width=0,
    this.height=0,
    this.borderRadius=0,
    this.child=const SizedBox(),
    this.padding=0,
    this.boxShadows,
    this.onTap,
    this.highlightColor,
    this.margin,
    this.childPadding=const EdgeInsets.all(0)
  }) : super(key: key);

  Color color;
  double borderRadius;
  double width;
  double height;
  Widget child;
  double padding;
  List<BoxShadow> ?boxShadows = [];
  void Function() ?onTap;
  Color ?highlightColor;
  EdgeInsetsGeometry childPadding;
  EdgeInsetsGeometry ?margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadows
      ),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            splashColor: highlightColor,
            child: Align(
              alignment: Alignment.center,
                child: Padding(
                    padding: childPadding,
                    child: child
                )
            ),
        ),
      ),
    );
  }
}
