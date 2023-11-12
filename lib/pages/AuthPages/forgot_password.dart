import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/AuthPages/controller/auth_controller.dart';
import 'package:fairdraft/services/validator_service.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:fairdraft/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatelessWidget {
   ForgotPassword({Key? key}) : super(key: key);

  AuthController vc = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

              //
              SizedBox(
                width: 15.w,
                height: 7.h,
                child: const Center(
                  child: Icon(Icons.lock,size: 60,color: Colors.black,),
                ),
              ),

             //
              SizedBox(
                 width: 30.w,
                 height: 7.h,
                 child: const Text(
                   'Forgot Password',
                   style: TextStyle(
                       color: Colors.black54,
                     fontSize: 20,
                     fontWeight: FontWeight.w600
                   ),
                   maxLines: 2,
                   textAlign: TextAlign.center,
                 )
             ),

            SizedBox(
                 width: 70.w,
                 height: 7.h,
                 child: const Text(
                   'An otp will be sent to this number.Use it to enter the app to change your password.',
                   style: TextStyle(
                       color: Color(0xffbdbdbd),
                     fontSize: 13,
                     fontWeight: FontWeight.w500
                   ),
                   maxLines: 2,
                   textAlign: TextAlign.center,
                 )
             ),

            Form(
              key: vc.forgotPasswordKey,
              child: CustomTextField(
                  textInputType: TextInputType.number,
                  validator: FormValidator.validatePhone,
                borderRadius: 5,
                hintText: 'Enter mobile number',
                fillColor: Colors.transparent,
                onSaved: (value){
                    vc.user.mobile = value;
                },
              ).paddingOnly(top: 3.h,right: 10.w,left: 10.w),
            ),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: CustomButton(
                width: 50.w,
                height: 6.h,
                color: AppColor().primaryColor,
                borderRadius: 10,
                onTap: (){
                  !vc.busy.value?vc.forgotPassword():null;
                },
                highlightColor: Colors.white54,
                child: Obx((){
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.w/2.9),
                      child: Row(
                        children: [
                          //
                          Text('Get OTP',style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)),

                          //
                          SizedBox(width: 1.w,),

                          //
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
                  );
                })
              )
            ).paddingOnly(top: 4.h),
          ],
        ),
      ),
    );
  }
}
