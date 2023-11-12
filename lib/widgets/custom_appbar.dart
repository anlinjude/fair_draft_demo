import 'package:fairdraft/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
   CustomAppBar({
    Key? key,
     this.height = 60,
     this.elevation,
     this.color,
     this.automaticallyImplyLeading = true,
     this.centerTitle,
     this.actions,
     this.title = '',
     this.leading
  }) : super(key: key);

  double height;
  double ?elevation;
  Color ?color;
  bool automaticallyImplyLeading;
  Widget ?leading;
  String ?title;
  List<Widget> ?actions;
  bool ?centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: color ?? AppColor().primaryColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      title: Text(title!,style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white,fontWeight: FontWeight.w600)),
      actions: actions,
      centerTitle: centerTitle,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity,height);
}
