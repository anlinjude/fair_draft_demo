import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';
import '../../controller/auth_controller.dart';


// ignore: must_be_immutable
class LoginSignupHeader extends StatelessWidget {
   LoginSignupHeader({Key? key}) : super(key: key);

   AuthController vc = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
          color: AppColor().bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [

              //
              AnimatedPositioned(
                  left: vc.pageIndex.value == 0 ? 3.w : 37.w,
                  child: Container(
                    width: 30.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                        color: AppColor().primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  duration: const Duration(milliseconds: 500)),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //
                  Container(
                    width: 30.w,
                    height: 5.h,
                    color: Colors.transparent,
                    child: const Center(
                      child: Text('Sign Up'),
                    ),
                  ).onTap(() => vc.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear)),

                  //
                  Container(
                    width: 30.w,
                    height: 5.h,
                    color: Colors.transparent,
                    child: const Center(
                      child: Text('Login'),
                    ),
                  ).onTap(() => vc.pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear)),
                ],
              ),
            ],
          );
        })
      ),
    );
  }
}
