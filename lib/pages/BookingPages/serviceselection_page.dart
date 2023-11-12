import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingPages/controller/booking_controller.dart';
import 'package:fairdraft/pages/BookingPages/date_selection_page.dart';
import 'package:fairdraft/pages/BookingPages/widgets/service_sheet.dart';
import 'package:fairdraft/widgets/custom_box.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ServiceSelectionPage extends StatelessWidget {
  ServiceSelectionPage({Key? key}) : super(key: key);

  BookingController vc = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.closeAllSnackbars();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //back arrow
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 5.w),
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

                    //heading
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, top: 1.h),
                        child: SizedBox(
                          width: 250.w,
                          child: Text(
                            'Select services',
                            style: Theme.of(context).textTheme.headline3,
                          ).textColor(Colors.black),
                        ),
                      ),
                    ),

                    //
                    SizedBox(height: 5.h),

                    //services list
                    Obx(() {
                      return Center(
                          child: SizedBox(
                              width: 100.w,
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: vc.serviceList.length,
                                itemBuilder: (context, index) {

                                  //service list item
                                  return Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: CustomButton(
                                      width: 80.w,
                                      height: 7.h,
                                      color: AppColor().bgColor,
                                      borderRadius: 10,
                                      onTap: () {
                                        //
                                        vc.serviceSelection(vc.serviceList[index]);
                                        //
                                        vc.initializeAnimation();
                                        //
                                        showModalBottomSheet<dynamic>(
                                            isScrollControlled: true,
                                            context: context,
                                            transitionAnimationController: vc.animationController,
                                            builder: (BuildContext context) {
                                              return Container(
                                                  height: 70.h,
                                                  color: Colors.white,
                                                  child: ServiceSheet(vc.serviceList[index].subServices!));
                                            }).then((value) {
                                              vc.animationController!.removeStatusListener(vc.animationStatusListener!);
                                        });
                                      },
                                      highlightColor: AppColor().primaryColor,
                                      //
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          //show tick
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Container(
                                                width: 7.w,
                                                height: 4.h,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Obx(() {
                                                  return Center(
                                                    child:
                                                        vc.serviceSelectionCheck(vc.serviceList[index].id!)
                                                            ? Icon(Icons.check, color: AppColor().proceedColor,)
                                                            : const SizedBox(),
                                                  );
                                                })),
                                          ),

                                          //service name
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 10.w),
                                              child: Text(
                                                vc.serviceList[index].title!,
                                                style: Theme.of(context).textTheme.headline6,
                                              )   .textColor(Colors.black)
                                                  .fontFamily('Amazon')
                                                  .bold(),
                                            ),
                                          ),

                                          //tap icon to clear selections
                                          Obx(() {
                                            return vc.selectedServices.isNotEmpty &&
                                                    vc.selectedServices.contains(vc.serviceList[index].id)
                                                ? Container(
                                                    width: 15.w,
                                                    height: 7.h,
                                                    color: AppColor().bgColor,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ).onTap(() {
                                                    vc.clearService(vc.serviceList[index].id!);
                                                  })
                                                : const SizedBox();
                                          })


                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 2.h,
                                  );
                                },
                              )));
                    }),
                        SizedBox(height: 2.h)
                  ])),

              //loading list-->api call
              Obx(() {
                return vc.serviceList.isEmpty && !vc.internetError.value
                    ? Container(
                        width: 100.w,
                        height: 100.h -
                            WidgetsBinding.instance.window.viewPadding.top,
                        color: Colors.transparent,
                        child: Center(
                          child: SpinKitPouringHourGlassRefined(
                            color: AppColor().primaryColor,
                            strokeWidth: 1,
                          ),
                        ),
                      )

                    //internet error
                    : vc.internetError.value
                        ? Container(
                            width: 100.w,
                            height: 100.h -
                                WidgetsBinding.instance.window.viewPadding.top,
                            color: Colors.transparent,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage('assets/retry.png'),
                                    width: 10.w,
                                    height: 7.h,
                                  ).onTap(() {
                                    vc.retry();
                                  }),
                                  Text(
                                    'Check internet connection',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox();
              })
            ],
          ),
          bottomNavigationBar: CustomBox(
            width: 100.w,
            height: 10.h,
            color: AppColor().primaryColor,
            child: Center(
              child: Row(
                children: [

                  //total price of selected services
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text('Sub Total',style: Theme.of(context).textTheme.headline5).textColor(Colors.white)),
                          Obx(() {
                            return Text('\u{20B9}${vc.price.value}').fontSize(15).textColor(Colors.white);
                          })
                        ],
                      ),
                    ),
                  ),

                  //next button
                  Obx(() {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: CustomButton(
                          width: 40.w,
                          height: 6.h,
                          borderRadius: 10,
                          highlightColor: Colors.black12,
                          color: vc.selectedOptions.isNotEmpty
                              ? AppColor().proceedColor
                              : AppColor().notYet,
                          onTap: () {
                            vc.selectedOptions.isNotEmpty
                                ? vc.toDatePage()
                                : vc.showSnackBar();
                          },
                          child: Center(
                            child: Text(
                              'Next',
                              style: Theme.of(context).textTheme.headline5,
                            ).bold().textColor(Colors.white),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
