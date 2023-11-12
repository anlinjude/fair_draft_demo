import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class DataStateWidget extends StatelessWidget {
   DataStateWidget({
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
    return Center(
        child: SizedBox(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              SizedBox(
                  height: 10.h,
                  child: stateImage
              ),
              //
              SizedBox(height: 2.h),
              //
              Text(stateMessage,style: messageStyle()),
              //
              SizedBox(height: 2.h),
              //
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: CustomButton(
                  width: 25.w,
                  height: 6.h,
                  color: buttonColor ?? AppColor().primaryColor,
                  borderRadius: 10,
                  highlightColor: Colors.black12,
                  onTap: onTap,
                  child: const Center(
                    child: Text('Try again',),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  TextStyle messageStyle(){
    return GoogleFonts.ibmPlexSans(color: const Color(0xffbdbdbd));
  }
}
