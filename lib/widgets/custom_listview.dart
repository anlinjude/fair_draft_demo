import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomListView extends StatefulWidget {
   CustomListView({
     Key? key,
     required this.itemBuilder,
     required this.itemCount,
     this.scrollDirection = Axis.vertical,
     this.spacing=0,
     this.physics,
     this.padding
  }) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();

  Widget Function(BuildContext,int index) itemBuilder;
  Axis scrollDirection;
  double spacing;
  int itemCount;
  ScrollPhysics ?physics;
  EdgeInsetsGeometry ?padding;
}

class _CustomListViewState extends State<CustomListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        physics: widget.physics,
        shrinkWrap: true,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        separatorBuilder: (BuildContext context, int index) {
          return widget.scrollDirection==Axis.vertical
              ?SizedBox(height: widget.spacing)
              :SizedBox(width: widget.spacing);
        },
    );
  }
}
