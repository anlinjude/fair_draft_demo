import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/services/validator_service.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:fairdraft/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/app_colors.dart';
import 'controller/booking_controller.dart';

// ignore: must_be_immutable
class FormPage extends StatelessWidget {
   FormPage({Key? key}) : super(key: key);

  BookingController vc = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: vc.finalFormKey,
          child: SingleChildScrollView(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w, top: 3.h, right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                  ),

                  //
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.w,top:3.h),
                      child: SizedBox(
                        width: 250.w,
                        child: Text(
                          'Fill out form',
                          style: Theme.of(context).textTheme.headline3,
                        ).textColor(Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h,),

                  //
                  labelWidget('Name'),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    borderRadius: 5,
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.person_rounded),
                    hintText: 'Name',
                    fillColor: AppColor().bgColor,
                    enableLabel: false,
                    controller: vc.nameController,
                    validator: FormValidator.validateName,
                    onSaved: (name){
                      vc.bookingInfo.name = name;
                    },
                  ),

                  //
                  SizedBox(height: 2.h),
                  labelWidget('Sex'),
                  SizedBox(height: 1.h),
                  DropdownButtonFormField<int>(
                      validator: (input){
                        if(vc.sex.value==2){
                          return 'Select gender';
                        }
                        return null;
                      },
                      onSaved: (gender){
                        gender==1?vc.bookingInfo.gender="female":vc.bookingInfo.gender="male";
                      },
                      borderRadius: BorderRadius.circular(5),
                      decoration: inputDecoration(),
                      items: const [
                        DropdownMenuItem(
                          child: Text('Male'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('Female'),
                          value: 1,
                        ),
                      ],
                      onChanged: (value) {
                        vc.sex.value = value!;
                      }),
                  SizedBox(height: 2.h),

                  //
                  labelWidget('Mobile Number'),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    borderRadius: 5,
                    textInputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone_android),
                    hintText: 'mobile number',
                    fillColor: AppColor().bgColor,
                    enableLabel: false,
                    controller: vc.phoneController,
                    validator: FormValidator.validatePhone,
                    onSaved: (mobile){
                      vc.bookingInfo.mobile= mobile;
                    },
                  ),
                  SizedBox(height: 2.h),

                  //
                  labelWidget('Is it your Whatsapp number ?'),
                  SizedBox(
                    height: 6.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Obx(() {
                          return ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 25.w,height: 5.h),
                            child: RadioListTile<int>(
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                vc.isWhatsApp.value = value!;
                              },
                              groupValue: vc.isWhatsApp.value,
                              value: 1,
                              title: Transform.translate(
                                  offset: const Offset(-15,0),
                                  child: const Text('Yes')),
                            ),
                          );
                        }),
                        Obx(() {
                          return ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 25.w,height: 5.h),
                            child: RadioListTile<int>(
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) {
                                vc.isWhatsApp.value = value!;
                              },
                              groupValue: vc.isWhatsApp.value,
                              value: 0,
                              title: Transform.translate(
                                  offset: const Offset(-15,0),
                                  child: const Text('No'))
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),

                  //
                  Obx((){
                    return vc.isWhatsApp.value == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelWidget('Whatsapp number'),
                              SizedBox(height: 2.h),
                              CustomTextField(
                                borderRadius: 5,
                                textInputType: TextInputType.number,
                                prefixIcon: const Icon(Icons.phone_android),
                                hintText: 'Whatsapp number',
                                fillColor: AppColor().bgColor,
                                enableLabel: false,
                                validator: vc.isWhatsApp.value==0?FormValidator.validatePhone:null,
                                onSaved: (whatsapp) {
                                  vc.bookingInfo.whatsapp = whatsapp;
                                },
                              ),
                      ],
                    ) : const SizedBox();
                  }),
                   Obx((){
                     return vc.isWhatsApp.value==0?SizedBox(height: 2.h,):const SizedBox();
                   }),

                  //
                  /*labelWidget('Email'),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    borderRadius: 5,
                    textInputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    fillColor: AppColor().bgColor,
                    enableLabel: false,
                    validator: FormValidator.validateEmail,
                    onSaved: (email){
                      vc.bookingInfo.email= email;
                    },
                  ),*/


                ],
              ),
            ),
          )),
        ),

        //
        bottomNavigationBar: Obx((){
          return CustomButton(
              width: 100.w,
              height: 7.h,
              color: AppColor().primaryColor,
              onTap: () {
                vc.book();
              },
              highlightColor: Colors.white70,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit & Book',
                      style: Theme.of(context).textTheme.headline5,
                    ).bold().textColor(Colors.white),
                    vc.isBusy.value ? const SpinKitFadingCircle(color: Colors.white,) : const SizedBox()
                  ],
                ),
              ),
            );
          })
      ),
    );
  }

 Widget labelWidget(String label) {
    return Text.rich(TextSpan(text: label, children:  <InlineSpan>[
      TextSpan(
        text: '*',
        style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: Colors.red),
      )
    ]));
  }

  InputDecoration inputDecoration(){
    return InputDecoration(
        counter: const SizedBox(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColor().bgColor,
        filled: true,
        labelText: 'Select gender',
        labelStyle: TextStyle(
            color: const Color(0xffbdbdbd), fontSize: 11.sp),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColor().bgColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColor().primaryColor, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColor().bgColor, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: AppColor().primaryColor, width: 1)));
  }
}
