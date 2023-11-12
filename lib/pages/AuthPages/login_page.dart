import 'package:fairdraft/pages/AuthPages/widgets/login/login_view.dart';
import 'package:fairdraft/pages/AuthPages/widgets/login/signup_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../AuthPages/widgets/login/signup_view.dart';
import 'controller/auth_controller.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

   AuthController vc = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Column(
                children: [
                  //
                  LoginSignupHeader(),
                  SizedBox(height: 4.h),

                  //
                  Expanded(
                    child: SizedBox(
                      child: PageView(
                          controller: vc.pageController,
                          onPageChanged: (index) {
                            vc.pageIndex.value = index;
                          },
                          children: [
                            SignUpView().paddingOnly(top: 10),
                            LoginView().paddingOnly(top: 10),
                          ]),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
