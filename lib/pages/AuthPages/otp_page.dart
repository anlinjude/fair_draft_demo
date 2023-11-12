import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth_controller.dart';

// ignore: must_be_immutable
class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);

  AuthController vc = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Image(
                image: const AssetImage('assets/otp_msg.png'),
                width: 50.w,
                height: 30.h,
              ),
              Text(
                'OTP',
                style: Theme.of(context).textTheme.headline3,
              ).textColor(Colors.black),
              Text(
                'Please enter the otp sent to your mobile number',
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                padding: EdgeInsets.all(15.w),
                child: Material(
                    color: Colors.transparent,
                    child:
                    PinCodeTextField(
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (value) {
                        vc.otp.value = value;
                      },
                      appContext: context,
                      enablePinAutofill: true,
                    )
                ),
              ),
              Obx(() {
                return CustomButton(
                  width: 50.w,
                  height: 7.h,
                  borderRadius: 3.w,
                  color: vc.otp.value.length == 6
                      ? AppColor().proceedColor
                      : AppColor().proceedColor.withOpacity(0.5),
                  onTap: (){
                    vc.verifyOtp();
                  },
                  highlightColor: Colors.white54,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: Row(
                        children: [
                          Text('Submit',style: Theme.of(context).textTheme.headline5,).textColor(Colors.white),
                          SizedBox(width: 1.w,),
                          SizedBox(
                            width: 7.w,
                            child: vc.busy.value?const SpinKitFadingCircle(
                              size: 30,
                              color: Colors.white,
                            ):const SizedBox()
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
