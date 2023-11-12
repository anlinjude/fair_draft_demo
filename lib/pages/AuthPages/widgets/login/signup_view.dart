import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';
import '../../../../services/validator_service.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../controller/auth_controller.dart';


// ignore: must_be_immutable
class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  AuthController vc = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: vc.signupKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  controller: vc.nametEC,
                  textInputType: TextInputType.text,
                  maxLength: 10,
                  prefixIcon: const Icon(Icons.person_rounded),
                  borderRadius: 5,
                  outlineWidth: 1,
                  hintText: 'Name',
                  onSaved: (value) {
                    vc.register.name = value;
                  },
                  validator: FormValidator.validateName),
              SizedBox(height: 1.h),

              //phone
              CustomTextField(
                  controller: vc.mobiletEC,
                  textInputType: TextInputType.phone,
                  maxLength: 10,
                  prefixIcon: const Icon(Icons.phone),
                  borderRadius: 5,
                  outlineWidth: 1,
                  hintText: 'Phone number',
                  onSaved: (value) {
                    vc.register.mobile = value;
                  },
                  validator: FormValidator.validatePhone),

              //
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Text.rich(TextSpan(
                    text: 'Is it your Whatsapp Number? ',
                    style: Theme.of(context).textTheme.headline6)),
              ),

              //
              SizedBox(
                height: 5.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Obx(() {
                      return ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 25.w, height: 5.h),
                        child: RadioListTile<int>(
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            vc.isWhatsApp.value = value!;
                          },
                          groupValue: vc.isWhatsApp.value,
                          value: 1,
                          title: Transform.translate(
                              offset: const Offset(-15, 0),
                              child: Text('Yes',
                                  style:
                                      Theme.of(context).textTheme.headline5)),
                        ),
                      );
                    }),
                    Obx(() {
                      return ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 25.w, height: 5.h),
                        child: RadioListTile<int>(
                            contentPadding: EdgeInsets.zero,
                            onChanged: (value) {
                              vc.isWhatsApp.value = value!;
                            },
                            groupValue: vc.isWhatsApp.value,
                            value: 0,
                            title: Transform.translate(
                                offset: const Offset(-15, 0),
                                child: Text('No',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5))),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              //
              Obx(() {
                return vc.isWhatsApp.value == 0
                    ? Column(
                        children: [
                          CustomTextField(
                            textInputType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(Icons.chat_bubble_outlined,color: Colors.green),
                            borderRadius: 5,
                            outlineWidth: 1,
                            hintText: 'Enter whatsapp number',
                            onSaved: (value) {
                              vc.register.whatsapp = value;
                            },
                            validator: vc.isWhatsApp.value == 0
                                ? FormValidator.validatePhone
                                : (input) {
                                    return '';
                                  },
                          ),
                          SizedBox(height: 1.h),
                        ],
                      )
                    : const SizedBox();
              }),

              //password
              Obx(() {
                return CustomTextField(
                  controller: vc.passwordtEC,
                  textInputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                  borderRadius: 5,
                  outlineWidth: 1,
                  hintText: 'Password',
                  obscureText: vc.obscureText.value,
                  suffixIcon: vc.obscureText.value
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onSuffixTap: (value) {
                    vc.obscureText.value = value;
                  },
                  onChanged: (input) {
                    vc.register.password = input;
                  },
                  onSaved: (value) {
                    vc.register.password = value;
                  },
                  validator: FormValidator.validatePassword,
                );
              }),
              SizedBox(height: 1.h),

              //CONFIRM PASSWORD
              Obx(() {
                return CustomTextField(
                    controller: vc.confirmPasswordtEC,
                    textInputType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock),
                    borderRadius: 5,
                    outlineWidth: 1,
                    hintText: 'Confirm password',
                    obscureText: vc.hideConfirmPassword.value,
                    suffixIcon: vc.hideConfirmPassword.value
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onSuffixTap: (value) {
                      vc.hideConfirmPassword.value = value;
                    },
                    validator: (input) {
                      return FormValidator.confirmPassword(vc.register.password, input);
                    },
                  onSaved: (value) {
                  },
                );
              }),
              SizedBox(height: 1.h),

              //
              CustomTextField(
                controller: vc.referralTEC,
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.numbers),
                borderRadius: 5,
                outlineWidth: 1,
                hintText: 'Referral code',
                onChanged: (v){
                  final text = vc.referralTEC.text;
                  vc.referralTEC.text = text.toUpperCase();
                  vc.referralTEC.selection = TextSelection.fromPosition(TextPosition(offset: vc.referralTEC.text.length));

                },
                onSaved: (v){
                  vc.register.referrer = v;
                },
              ),
              SizedBox(height: 4.h),

              //singup button
              Obx(() {
                return Center(
                  child: CustomButton(
                      height: 6.h,
                      width: 83.w,
                      margin: EdgeInsets.only(bottom: 3.h),
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
                        !vc.busy.value ? vc.processSignUp() : null;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Center(child: const Text('SignUp').textColor(Colors.white)),
                          SizedBox(width: 1.w),
                          vc.busy.value
                              ? const SpinKitFadingCircle(
                                  size: 30,
                                  color: Colors.white,
                                )
                              : const SizedBox()
                        ],
                      )),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
