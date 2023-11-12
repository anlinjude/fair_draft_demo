import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/pages/BookingHistory/booking_history.dart';
import 'package:fairdraft/pages/BookingPages/serviceselection_page.dart';
import 'package:fairdraft/pages/HomePage/controller/home_controller.dart';
import 'package:fairdraft/pages/HomePage/widgets/customshaped_background.dart';
import 'package:fairdraft/pages/HomePage/widgets/drawer_widget.dart';
import 'package:fairdraft/pages/HomePage/widgets/navbar_item.dart';
import 'package:fairdraft/pages/HomePage/widgets/profile_photo.dart';
import 'package:fairdraft/pages/HomePage/widgets/wallet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_box.dart';
import '../../widgets/custom_button.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController vc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: vc.scaffoldKey,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 40), // change this size and style
          onPressed: () => vc.scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: DrawerWidget(),
      backgroundColor: const Color(0xffeceff1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            //
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 25.h,
                    width: 100.w,
                    child: CustomPaint(
                      painter: CustomShapedBackground(),
                    ),
                  ),
                  Positioned(top: 10.h, child: const ProfilePhoto())
                ]),

            //
            SizedBox(height: 10.h),

            //
            WalletWidget(),

            //
            SizedBox(height: 10.w),

            //new booking
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: CustomButton(
                width: 90.w,
                height: 8.h,
                color: Colors.white,
                borderRadius: 20,
                childPadding: EdgeInsets.symmetric(horizontal: 2.w),
                highlightColor: AppColor().primaryColor[300],
                onTap: () {
                  vc.newBookingPage();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.face_sharp,
                      color: Colors.black54,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                        child: Text('New booking',
                                style: Theme.of(context).textTheme.headline6).fontWeight(FontWeight.w500).textColor(Colors.black)),
                    CustomBox(
                        width: 6.w,
                        height: 3.h,
                        color: Colors.white,
                        borderRadius: 20,
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),

            //
            SizedBox(height: 2.h,),

            //previous bookings
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: CustomButton(
                width: 90.w,
                height: 8.h,
                color: Colors.white,
                borderRadius: 20,
                childPadding: EdgeInsets.symmetric(horizontal: 2.w),
                onTap: () {
                  Get.to(()=>BookingHistory());
                },
                highlightColor: AppColor().primaryColor[400],
                child: Row(
                  children: [

                    //
                    const Icon(
                      Icons.history_edu_outlined,
                      color: Colors.black54,
                      size: 20,
                    ),

                    //
                    SizedBox(width: 2.w),

                    //
                    Expanded(
                        child: Text('Booking History',
                                style: Theme.of(context).textTheme.headline6).fontWeight(FontWeight.w500).textColor(Colors.black)),

                    //
                    CustomBox(
                        width: 6.w,
                        height: 3.h,
                        color: Colors.white,
                        borderRadius: 20,
                        child: const Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                        ))


                  ],
                ),
              ),
            )
          ],
        ),
      ),

      //
      bottomNavigationBar: Container(
        width: 100.w,
        height: 7.h,
        margin: EdgeInsets.symmetric(vertical: 0.h),
        decoration: BoxDecoration(
            color: AppColor().primaryColor,
            /*borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),*/
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, offset: Offset(0,0), blurRadius: 5)
            ]),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [

            Positioned(
              bottom: 1.h,
              child: GestureDetector(
                onTap: (){
                  vc.getProfileData();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 5)
                      ]),
                  child: Container(
                    width: 20.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: AppColor().primaryColor, shape: BoxShape.circle),
                    child:
                    const Center(child: Icon(Icons.account_balance_wallet)),
                  ),
                ),
              ),
            ),

            //
            Positioned(
              left: 10.w,
              child: NavBarItem(
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: const Text('History').fontFamily('Amazon').fontSize(12).bold().textColor(Colors.white),
              ).onTap(() => Get.to(() => BookingHistory())),
            ),

            //
            Positioned(
              right: 10.w,
              child: NavBarItem(
                icon: const Icon(
                  Icons.fiber_new,
                  color: Colors.white,
                ),
                label: const Text('Booking').fontFamily('Amazon').fontSize(12).bold().textColor(Colors.white),
              ).onTap(() => Get.to(() => ServiceSelectionPage())),
            )
          ],
        ),
      ),
    );
  }
}
