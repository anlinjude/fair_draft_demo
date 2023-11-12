import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 20.h,
      padding: EdgeInsets.all(1.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
       // borderRadius: BorderRadius.circular(60),
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          /*gradient:  const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xffa7eac5),
                Color(0xffffe68f)
              ]

          ),*/
         // borderRadius: BorderRadius.circular(60),
        ),
        child: const Center(
          child: Image(image: AssetImage("assets/ic_launcher.png")),
        )
      ),
    );
  }
}
