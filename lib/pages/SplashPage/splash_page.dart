import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/pages/SplashPage/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class SplashPage extends StatelessWidget {
   SplashPage({Key? key}) : super(key: key);

 SplashController vc = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Obx(() {
          return Center(
            child: !vc.internetError.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      Image(
                        image: const AssetImage(
                          'assets/ic_launcher.png',
                        ),
                        width: 20.w,
                        height: 10.h,
                      ),

                      //
                      SizedBox(height: 2.h),

                      //
                      const Text('Loading please wait'),
                    ],
                  )
                : Container(
                    width: 100.w,
                    height: 50.h,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //
                        Image(
                          image: const AssetImage('assets/retry.png'),
                          width: 10.w,
                          height: 7.h,
                        ).onTap(() {
                          vc.initializeApp();
                        }),

                        //
                        Text(
                          'Check your internet connection',
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
