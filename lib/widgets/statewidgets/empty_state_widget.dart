import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class EmptyState extends StatelessWidget {
   EmptyState({
     Key? key,
     this.stateImage = const SizedBox(),
     this.stateMessage='',
     this.buttonColor,
     this.onTap
   }) : super(key: key);

  Widget stateImage;
  String stateMessage;
  Color ?buttonColor;
  Function() ?onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            height: 30.h,
            width: 50.w,
            child: stateImage
        ),
        //
        SizedBox(height: 2.h),
        //
        Text(stateMessage,style: messageStyle()),
        //
        SizedBox(height: 2.h),
      ],
    );
  }
   TextStyle messageStyle(){
     return GoogleFonts.ibmPlexSans(color: const Color(0xffbdbdbd),fontSize: 15.sp);
   }
}
