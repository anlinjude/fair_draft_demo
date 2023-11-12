import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingPages/models/date.dart';
import 'package:fairdraft/pages/BookingPages/controller/booking_controller.dart';
import 'package:fairdraft/widgets/custom_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class DateSheet extends StatelessWidget {
   DateSheet({Key? key,required this.date}) : super(key: key){
     date.disabledDates?.forEach((date) {
       blockedDates.add(DateTime.parse(date));
     });
   }

   Date date;
   List<DateTime> blockedDates = [];

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
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
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
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text(
                    'Set Date',
                    style: Theme.of(context).textTheme.headline4,
                  ).textColor(Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text(
                    'Pick preferred date for booking',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: SizedBox(
                    width: 90.w,
                    child: SfDateRangePicker(
                      headerStyle: DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          backgroundColor: AppColor().primaryColor,
                      ),
                      selectionRadius: 30,
                      enablePastDates: false,
                      showActionButtons: true,
                      minDate: DateTime.now(),
                      maxDate: DateTime.now().add(Duration(days: date.visible_days!)),
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 40,
                        blackoutDates: blockedDates,
                        dayFormat: 'EEE',
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        blackoutDatesDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        blackoutDateTextStyle: TextStyle(
                          color: Color(0xffbdbdbd),
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                        )
                      ),
                      initialDisplayDate: vc.initialDisplayDate(),
                      initialSelectedDate: date.selectedDate,
                      onSelectionChanged: (details) {
                        vc.updateDate(details);
                        vc.closeSheet();
                      },
                      onSubmit: (details) {
                        vc.closeSheet();
                      },
                      onCancel: () {
                        vc.closeSheet();
                      },
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
