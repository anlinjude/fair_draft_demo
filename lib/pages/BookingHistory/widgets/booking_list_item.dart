import 'dart:ui';

import 'package:fairdraft/constants/api.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import '../Models/booking_history_model.dart';
import '../controller/booking_history_controller.dart';

// ignore: must_be_immutable
class BookingListItem extends StatelessWidget {
   BookingListItem({
     Key? key,
     required this.bookingData,
     this.firstItem = false
   }) : super(key: key);

  late BookingData bookingData;
  bool firstItem = false;

  BookingHistoryController vc = Get.find<BookingHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: const Color(0xffd6d6d6),
      color: const Color(0xffeceff1),
      child: ExpansionTile(

          initiallyExpanded: firstItem,

          backgroundColor: const Color(0xffeceff1),

          leading: bookingData.status=="Pending"
                    ? const Icon(Icons.pending_outlined,color: Colors.redAccent,)
                    : Icon(Icons.check,color: AppColor().proceedColor,),

          trailing: Text(
            '\u{20B9}${bookingData.total}',
            style: idStyle().copyWith(color: Colors.brown),
          ),

          title: Row(
            children: [
              //
              Text('# ${bookingData.id}',style: idStyle()),
              //
              SizedBox(width: 3.w),
              //
              Text(bookingData.status!,style: GoogleFonts.notoSans().copyWith(color: const Color(0xff343434)))

            ],
          ),

          children: bookingData.bookedServices.map((bookedService){
              return Column(
                children: [

                  //
                  Text(
                      bookedService.service!.title!,
                      style: idStyle().copyWith(color: const Color(0xff343434),fontSize: 13.sp),
                  ),

                  //
                  Column(
                    children: bookedService.bookedOptions!=null? bookedService.bookedOptions!.map((option){
                       return Column(
                         children: option.options!.map((e){
                           return SizedBox(
                             width: 100.w,
                             child: Column(
                               children: [

                                 //
                                 Row(
                                   children: [
                                     //
                                     Expanded(
                                         flex: 1,
                                         child: Text(e.option!,style: optionStyle(),)),
                                     //
                                     Expanded(
                                         flex: 2,
                                         child: Text('\u{20B9}${e.price}',style: optionStyle(),textAlign: TextAlign.center,)
                                     ),
                                     //
                                     Expanded(
                                         flex: 1,
                                         child: Column(
                                           children: [
                                             //
                                             Text(formatDate(bookedService.bookedSlot!.bookedDate!),
                                                  style: optionStyle(),),
                                             //
                                             SizedBox(height: 0.5.h),
                                             //
                                             Text(formatTime(bookedService.bookedSlot!.bookedTime!),
                                                  style: optionStyle().copyWith(fontSize: 9.sp),),

                                         ],
                                       ),
                                     )

                                   ],
                                 ).paddingSymmetric(horizontal: 4.w),

                                 //
                                 SizedBox(height: 1.h)
                               ],
                             ),
                           );
                         }).toList(),
                       );
                    }).toList():[],
                  ),

                  //
                  SizedBox(height: 2.h)

                ],
              );
          }).toList()
      ),
    );
  }

  TextStyle idStyle(){
    return  GoogleFonts.oswald(color: Colors.blueAccent);
  }

  TextStyle optionStyle(){
    return  TextStyle(
      color: const Color(0xff343434),
      fontSize: 10.sp,
      fontFamily: 'Amazon',
      fontWeight: FontWeight.w600
    );
  }

  String formatDate(String date){
    var day = DateTime.parse(date).day.toString();
    var month = intl.DateFormat("MMM").format(DateTime.parse(date));
    var year = DateTime.parse(date).year.toString();
    return day + " " + month + " " + year;
  }

 String formatTime(String time){
    time = intl.DateFormat("hh:mm").parse(time).toString();
    var dateFormat = intl.DateFormat("h:mm a");
    time =  dateFormat.format(DateTime.parse(time));
    return time;
  }
}
