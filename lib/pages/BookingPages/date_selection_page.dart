import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingPages/widgets/datesheet.dart';
import 'package:fairdraft/pages/BookingPages/widgets/header_widget.dart';
import 'package:fairdraft/pages/BookingPages/widgets/time_sheet.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'controller/booking_controller.dart';
import 'package:fairdraft/widgets/custom_box.dart';

// ignore: must_be_immutable
class DateSelectionPage extends StatelessWidget {
  DateSelectionPage({Key? key}) : super(key: key);

  BookingController vc = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        vc.internetError.value = false;
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //back
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
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

              //title
              const HeaderWidget(),

              //
              Obx(() {
                return vc.dates.isNotEmpty
                    ? Column(
                        children: vc.serviceGroupMap.keys.map((groupid) {
                        return vc.serviceGroupMap[groupid]!.isNotEmpty
                            ? Column(
                                children: [
                                  CustomBox(
                                    height: 30.h,
                                    width: 90.w,
                                    borderWidth: 1,
                                    borderRadius: 20,
                                    padding: 10,
                                    borderColor: AppColor().primaryColor,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        //selected services
                                        Expanded(
                                          child: Wrap(
                                            children:
                                                 vc.serviceGroupMap[groupid]!.toSet().toList()
                                                      .map((value) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColor().primaryColor,
                                                          borderRadius: BorderRadius.circular(5)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5),
                                                                child: Text(
                                                                  value,
                                                                  style: Theme.of(context).textTheme.headline6,
                                                                ).textColor(Colors.black),
                                                              ),
                                                            ))
                                                        .toList(),

                                            direction: Axis.horizontal,
                                            runSpacing: 1.h,
                                            spacing: 0.5.w,
                                            crossAxisAlignment: WrapCrossAlignment.start,
                                            runAlignment: WrapAlignment.start,
                                            alignment: WrapAlignment.start,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),

                                        //date
                                        CustomButton(
                                          width: 85.w,
                                          height: 8.h,
                                          childPadding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          color: const Color(0xfff5f6fa),
                                          borderRadius: 15,
                                          highlightColor:
                                              AppColor().primaryColor[400],
                                          onTap: () {
                                            vc.currentGroup.value = groupid;
                                            showModalBottomSheet<dynamic>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return DateSheet(
                                                      date: vc.dates.where((date) => date.id == groupid).single);
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Obx(() {
                                                return CustomBox(
                                                  width: 10.w,
                                                  height: 3.h,
                                                  boxShape: BoxShape.circle,
                                                  child: vc.dateMap[groupid] != null && vc.dateMap[groupid]!.selectedDate != null
                                                      ? Icon(
                                                         const IconData(
                                                             0xe156,
                                                             fontFamily: 'MaterialIcons'),
                                                    color: AppColor().proceedColor,
                                                        )
                                                      : const SizedBox(),
                                                );
                                              }),
                                              SizedBox(width: 2.w),
                                              Expanded(
                                                  child: Text('Select Date',
                                                    style: Theme.of(context).textTheme.headline5,)
                                                      .textColor(Colors.black)
                                                      .fontWeight(FontWeight.w500)),

                                              //time
                                              CustomButton(
                                                width: 20.w,
                                                height: 6.h,
                                                borderRadius: 10,
                                                color:
                                                    AppColor().primaryColor[100]!,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_month_outlined,
                                                      color: AppColor().primaryColor,
                                                    ),
                                                    Text(
                                                      'DATE',
                                                      style: Theme.of(context).textTheme.headline6,
                                                    ).bold().textColor(AppColor().primaryColor)
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 2.h),

                                        CustomButton(
                                          width: 85.w,
                                          height: 8.h,
                                          childPadding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          color: const Color(0xffF5F6FA),
                                          borderRadius: 15,
                                          highlightColor:
                                              AppColor().primaryColor[400],
                                          onTap: () {
                                            vc.currentGroup.value = groupid;
                                            showModalBottomSheet<dynamic>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return TimeSheet();
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Obx(() {
                                                return CustomBox(
                                                  width: 10.w,
                                                  height: 3.h,
                                                  boxShape: BoxShape.circle,
                                                  child: vc.dateMap[groupid]!=null&&vc.dateMap[groupid]!.selectedTime.isNotEmpty
                                                      ? Icon(
                                                          const IconData(0xe156,
                                                              fontFamily:
                                                                  'MaterialIcons'),
                                                          color: AppColor()
                                                              .proceedColor,
                                                        )
                                                      : const SizedBox(),
                                                );
                                              }),
                                              SizedBox(width: 2.w),
                                              Expanded(
                                                  child: Text(
                                                'Select Time',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              )
                                                      .textColor(Colors.black)
                                                      .fontWeight(
                                                          FontWeight.w500)),
                                              CustomButton(
                                                width: 20.w,
                                                height: 6.h,
                                                borderRadius: 10,
                                                color:
                                                    AppColor().primaryColor[100]!,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      color:
                                                          AppColor().primaryColor,
                                                    ),
                                                    Text(
                                                      'TIME',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    ).bold().textColor(
                                                        AppColor().primaryColor)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3.h)
                                ],
                              )
                            : const SizedBox();
                      }).toList())
                    : Obx(() {
                        return vc.dates.isEmpty && !vc.internetError.value
                            ? Container(
                                width: 100.w,
                                height: 50.h,
                                color: Colors.transparent,
                                child: SpinKitPouringHourGlassRefined(
                                  color: AppColor().primaryColor,
                                  strokeWidth: 1,
                                ),
                              )
                            : Container(
                              width: 100.w,
                              height: 50.h,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage('assets/retry.png'),
                                    width: 10.w,
                                    height: 7.h,
                                  ).onTap(() {
                                    vc.getServiceDates();
                                  }),
                                  Text(
                                    'Check internet connection',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5,
                                  )
                                ],
                              ),
                            );
                      });
              })
            ],
          ).paddingLTRB(5.w, 2.h, 0, 0)),
          bottomNavigationBar: CustomBox(
            width: 100.w,
            height: 10.h,
            color: AppColor().primaryColor,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text('Sub Total',
                                      style: Theme.of(context).textTheme.headline5).textColor(Colors.white)),
                          Obx(() {
                            return Text('\u{20B9}${vc.price.value}')
                                .textColor(Colors.white).fontSize(15);
                          })
                        ],
                      ),
                    ),
                  ),
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
                          color: vc.proceed.value
                              ? AppColor().proceedColor
                              : AppColor().notYet,
                          onTap: () {
                            vc.proceed.value ? vc.toFormPage() : vc.showSnackBar(message: 'Select date and time for selected services');
                          },
                          child: Center(
                            child: Text(
                              'Next',style: Theme.of(context).textTheme.headline5,
                            ).bold().textColor(Colors.white)
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
