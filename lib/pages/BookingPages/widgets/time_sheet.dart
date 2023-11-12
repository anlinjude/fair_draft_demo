import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingPages/controller/booking_controller.dart';
import 'package:fairdraft/widgets/custom_box.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../models/date.dart';

// ignore: must_be_immutable
class TimeSheet extends StatelessWidget {
  TimeSheet({Key? key}) : super(key: key){
    if(vc.dateMap.containsKey(vc.currentGroup.value)){
      for (var date in vc.dates) {
        if(date.id==vc.currentGroup.value){
          timimgList = date.timingList!;
          this.date = date;
        }
      }
    }
  }
  Date ?date;
  List<String> timimgList = [];
  BookingController vc = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          width: 40.w,
          height: 0.5.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
        ),

        SizedBox(height: 1.h),

        CustomBox(
          width: 100.w,
          height: 70.h,
          child: Column(
            children: [

              //drag indicator
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Image(
                    image: const AssetImage("assets/clock.png"),
                    width: 40.w,
                    height: 10.h,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    'Set Time',
                    style: Theme.of(context).textTheme.headline4,
                  ).textColor(Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    'Pick preferred time for booking',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              vc.dateMap.containsKey(vc.currentGroup.value)
                  ?Expanded(
                child: SizedBox(
                  height: 35.h,
                  child: Scrollbar(
                    trackVisibility: false,
                    thumbVisibility: true,
                    thickness:3,
                    radius: const Radius.circular(20),
                    child: ListView.separated(
                      shrinkWrap: true,
                        itemBuilder: (context,index){
                           return CustomButton(
                              height: 7.h,
                              color: date?.selectedTime==timimgList[index]
                                  ? AppColor().primaryColor
                                  : Colors.white,
                              highlightColor: AppColor().primaryColor[400],
                              onTap: () {
                                vc.updateTime(timimgList[index]);
                                vc.closeSheet();
                              },
                              child: Text(
                                timimgList[index],
                                style: Theme.of(context).textTheme.headline5,
                              ));
                      },
                      itemCount: timimgList.length,
                      separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 1,
                            thickness: 1,
                            color: AppColor().bgColor,
                          );
                      },),
                  ),
                ),
              ): SizedBox(
                width: 100.w,
                height: 35.h,
                child: const Center(
                        child: Text('Please select a date first'),
                      ),
              ),
              const SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
