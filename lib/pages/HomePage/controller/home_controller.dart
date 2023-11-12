import 'dart:io';

import 'package:fairdraft/base_controller.dart';
import 'package:fairdraft/constants/app_strings.dart';
import 'package:fairdraft/main.dart';
import 'package:fairdraft/pages/AuthPages/login_page.dart';
import 'package:fairdraft/pages/BookingPages/serviceselection_page.dart';
import 'package:fairdraft/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../requests/user_requests.dart';
import '../../AuthPages/models/user.dart';

class HomeController extends GetxController{

  late BaseController bc ;

  //
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //profile details
  Rx<User> user = User().obs;

  //navigation
  newBookingPage(){
    Get.to(()=>ServiceSelectionPage());
  }

  @override
  void onInit() {
    bc = Get.find();
    print('usermobile-->'+bc.baseUser.value.mobile!);
    print('userwalletbalance-->'+bc.baseUser.value.walletPoint!.toString());
    user.value = bc.baseUser.value;
    user.value.name = user.value.name!.substring(0,1).capitalize!
                        + user.value.name!.substring(1,user.value.name!.length);
    super.onInit();
  }

  processLogout(){
    UserService().logOut();
  }

  getProfileData() async {
    await bc.isAuthenticated().then((value) async {
      if (value) {
        try {
          var result = await UserRequests().profileRequest({
            "device_type": "android",
            "device_token": "fgfgdfgf"
          });
          if (result is Map<String, dynamic>) {
            user.value = User.fromJson(result['data']);
            user.value.name = user.value.name!.substring(0,1).capitalize!
                + user.value.name!.substring(1,user.value.name!.length);
          } else if (result is SocketException) {
          }
        } catch (e) {
          if(e is Response){}
        }
      }
    });
  }
}