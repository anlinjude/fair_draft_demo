import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingHistory/controller/booking_history_controller.dart';
import 'package:fairdraft/pages/BookingHistory/widgets/booking_list_item.dart';
import 'package:fairdraft/widgets/custom_listview.dart';
import 'package:fairdraft/widgets/statewidgets/data_state_widget.dart';
import 'package:fairdraft/widgets/statewidgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_appbar.dart';

// ignore: must_be_immutable
class BookingHistory extends StatelessWidget {
  BookingHistory({Key? key}) : super(key: key);

  BookingHistoryController vc = Get.put(BookingHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          height: 7.h,
          centerTitle: true,
          title: 'Booking History',
        ),
        body: Obx((){
          return vc.bookingData.isNotEmpty

              ? SmartRefresher(
                  controller: vc.refreshController,
                  onLoading: vc.getBookingList,
                  enablePullUp: true,
                  onRefresh: (){
                    vc.getBookingList(initialLoad: true);
                  },
                  scrollDirection: Axis.vertical,
                  child: CustomListView(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vc.bookingData.length,
                    itemBuilder: (context,index){
                      return Padding(
                              padding: EdgeInsets.only(left: 5.w,right: 5.w,top:2.h,bottom:0),
                              child: BookingListItem(bookingData:vc.bookingData[index],firstItem: index==0,),
                            );
                    },
                  ),
                )

              : vc.internetError.value

                         ? DataStateWidget(
                             onTap: () {
                                vc.getBookingList(initialLoad: true);
                                },
                            stateMessage: 'Check your connection and try again',
                            stateImage: const Center(child: Image(image: AssetImage('assets/internet_error.png'))))

                         : !vc.busy.value
                                ? Center(
                                  child: EmptyState(
                                        stateImage: const Image(image: AssetImage('assets/empty.png'),),
                                        stateMessage: 'No Bookings Yet',
                                    ),
                                )
                                : Center(
                                       child: SpinKitPouringHourGlassRefined(
                                          color: AppColor().primaryColor,
                                          strokeWidth: 1,
                                       ),);
        })
    );
  }
}
