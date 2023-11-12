import 'package:animated_check/animated_check.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/SuccessPage/controller/success_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class BookingSuccess extends StatelessWidget {
    BookingSuccess({Key? key}) : super(key: key);

    SuccessPageController vc = Get.put(SuccessPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: 40.w,
              height: 25.h,
              decoration: BoxDecoration(
                color: AppColor().bgColor,
                shape: BoxShape.circle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //
                  Center(
                    child: AnimatedCheck(
                      progress: vc.animation,
                      size: 70,
                    ),
                  ),

                  //
                  Text('Booking Successful',
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}
