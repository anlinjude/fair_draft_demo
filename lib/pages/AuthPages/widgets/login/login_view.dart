import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/pages/AuthPages/forgot_password.dart';
import 'package:fairdraft/services/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../controller/auth_controller.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
   LoginView({Key? key}) : super(key: key);

   AuthController vc = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Form(
        key: vc.loginKey,
        child: Column(
          children: [

            //phone
            CustomTextField(
              textInputType: TextInputType.phone,
              maxLength: 10,
              prefixIcon: const Icon(Icons.phone),
              borderRadius: 10,
              outlineWidth: 1,
              hintText: 'Phone number',
              validator: FormValidator.validatePhone,
              onSaved: (value) {
                vc.login.mobile = value!;
              },
            ),

            //
            SizedBox(height: 4.h),

            //password
            Obx(() {
              return CustomTextField(
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.password),
                borderRadius: 10,
                outlineWidth: 1,
                hintText: 'Password',
                obscureText: vc.obscureText2.value,
                suffixIcon: vc.obscureText2.value
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onSuffixTap: (value) {
                  vc.obscureText2.value = value;
                },
                validator: FormValidator.validatePassword,
                onSaved: (value){
                  vc.login.password = value!;
                },
              );
            }),

            //
            const SizedBox(height: 10),

            //forgot password
            Align(
              alignment: Alignment.bottomRight,
              child: const Text('Forgot password?').onTap(() => Get.to(()=>ForgotPassword())),
            ),

            //
            SizedBox(height: 10.h),

            //login button
            Obx((){
              return Center(
                child: CustomButton(
                    height: 6.h,
                    width: 83.w,
                    color: AppColor().primaryColor,
                    highlightColor: Colors.white70,
                    borderRadius: 5,
                    boxShadows: const [
                      BoxShadow(
                          color: Color(0xffffeecc),
                          blurRadius: 5,
                          offset: Offset(0, 4)),
                      BoxShadow(
                          color: Color(0xffFFF0CD),
                          blurRadius: 4,
                          offset: Offset(0, 4)),
                    ],
                    onTap: () {
                      !vc.busy.value?vc.processLogin():null;
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 36.w),
                        child: Row(
                          children: [
                            //
                            Text('Login',style: Theme.of(context).textTheme.headline5,).textColor(Colors.white),

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
                    ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
