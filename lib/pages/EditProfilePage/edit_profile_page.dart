import 'package:fairdraft/pages/EditProfilePage/controller/edit_profile_controller.dart';
import 'package:fairdraft/widgets/custom_appbar.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:fairdraft/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../services/validator_service.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatelessWidget {
   EditProfilePage({Key? key}) : super(key: key);

  EditProfileController vc = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Change Password',
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: vc.editProfileKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return CustomTextField(
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                borderRadius: 5,
                outlineWidth: 1,
                hintText: 'New Password',
                obscureText: vc.obscureText1.value,
                suffixIcon: vc.obscureText1.value
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onSuffixTap: (value) {
                  vc.obscureText1.value = value;
                },
                onChanged: (input) {
                  vc.password = input;
                },
                onSaved: (value) {
                  vc.password = value!;
                },
                validator: FormValidator.validatePassword,
              );
            }),

            Obx(() {
              return CustomTextField(
                textInputType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                borderRadius: 5,
                outlineWidth: 1,
                hintText: 'Confirm Password',
                obscureText: vc.obscureText2.value,
                suffixIcon: vc.obscureText2.value
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onSuffixTap: (value) {
                  vc.obscureText2.value = value;
                },
                onChanged: (input) {
                  vc.confirmPassword = input;
                },
                onSaved: (value) {
                  vc.confirmPassword = value!;
                },
                validator: (input) {
                  return FormValidator.confirmPassword(vc.password,vc.confirmPassword);
                }
              );
            }),

            SizedBox(height: 5.h),

            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: CustomButton(
                    width: 100.w,
                    height: 6.h,
                    color: AppColor().primaryColor,
                    borderRadius: 10,
                    onTap: (){
                       vc.editProfileApi();
                    },
                    highlightColor: Colors.white54,
                    child: Obx((){
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 100.w/4),
                          child: Row(
                            children: [
                              //
                              Text('Confirm changes',style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),

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
            )
          ],
        ).paddingSymmetric(horizontal: 10.w,vertical: 5.h),
      ),
    );
  }
}
