import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/constants/app_theme.dart';
import 'package:fairdraft/pages/BookingHistory/booking_history.dart';
import 'package:fairdraft/pages/BookingPages/serviceselection_page.dart';
import 'package:fairdraft/pages/EditProfilePage/edit_profile_page.dart';
import 'package:fairdraft/pages/MyFriendsPage/my_friends_page.dart';
import 'package:fairdraft/pages/MyTransactionsPage/my_transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide GetStringUtils;
import 'package:sizer/sizer.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/custom_box.dart';
import '../controller/home_controller.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  HomeController vc = Get.put(HomeController());
  TextStyle? headerStyle = AppTheme()
      .appTheme()
      .textTheme
      .headline6
      ?.copyWith(color: Colors.black87);
  Color iconColor = Colors.black54;
  double imageWidth = 10.w;
  double imageHeight = 5.h;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      width: 80.w,
      child: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //
            DrawerHeader(
                margin: EdgeInsets.only(left: 5.w),
                child: Container(
                  width: 80.w,
                  height: 20.h,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [

                      //
                      CustomBox(
                        width: 15.w,
                        height: 10.h,
                        boxShape: BoxShape.circle,
                        color: AppColor().bgColor,
                        child: const Image(
                          image: AssetImage('assets/user_male.png'),
                        ),
                      ),
                      //
                      SizedBox(width: 2.w),
                      //
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          Text(
                            vc.user.value.name!,
                            style: Theme.of(context).textTheme.headline3,
                          ).textColor(Colors.black),

                          SizedBox(height: 0.5.h),

                          Text(vc.user.value.referralCode! ?? "",
                          style: const TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),)
                        ],
                      )
                    ],
                  ),
                )),

            ListTile(
                leading: Image(
                  image: const AssetImage('assets/wallet_colored.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('Wallet', style: headerStyle),
                onTap: (){
                  Get.back();
                  vc.getProfileData();
                },
            ).paddingLTRB(25,0,0,0),

            //
            ListTile(
                leading: Image(
                  image: const AssetImage('assets/barber.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('Book Now', style: headerStyle),
              onTap: (){
                Get.to(()=>ServiceSelectionPage());
              },
            ).paddingLTRB(25,0,0,0),

            //
            ListTile(
                leading: Image(
                  image: const AssetImage('assets/appointments.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('My Bookings', style: headerStyle),
              onTap: (){
                Get.to(()=>BookingHistory());
              },
            ).paddingLTRB(25,0,0,0),

            //
            ListTile(
                leading: Image(
                  image: const AssetImage('assets/friends.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('My Friends', style: headerStyle),
                onTap: (){
                  Get.to(()=> MyFriendsPage());
                }
            ).paddingLTRB(25,0,0,0),//

            ListTile(
                leading: Image(
                  image: const AssetImage('assets/cash2.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('Points', style: headerStyle),
                onTap: (){
                  Get.to(()=> MyTransactionsPage());
                }
            ).paddingLTRB(25,0,0,0),

            //
            ListTile(
                leading: Icon(Icons.edit,color: AppColor().primaryColor,),
                title: Text('Change Password', style: headerStyle),
                onTap: (){
                  Get.to(()=> EditProfilePage());
                }
            ).paddingLTRB(25,0,0,0),

            Expanded(child: SizedBox()),
            //
            ListTile(
                leading: Image(
                  image: const AssetImage('assets/logout.png'),
                  width: imageWidth,
                  height: imageHeight,
                ),
                title: Text('Log Out', style: headerStyle),
              onTap: (){
                  vc.processLogout();
              },
            ).paddingLTRB(25,0,0,25)
          ],
        ),
      ),
    );
  }
}
