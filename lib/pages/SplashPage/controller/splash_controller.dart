import 'dart:io';
import 'package:fairdraft/base_controller.dart';
import 'package:fairdraft/pages/AuthPages/login_page.dart';
import 'package:fairdraft/pages/HomePage/home_page.dart';
import 'package:fairdraft/requests/user_requests.dart';
import 'package:get/get.dart';
import '../../AuthPages/models/user.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SplashController extends GetxController {

  //
  late BaseController bc;

  //
  RxBool internetError = false.obs;

  initializeApp() async {
    getProfileData();
  }

  getProfileData() async {
    await bc.isAuthenticated().then((value) async {
      if (value) {
        internetError.value = false;
        try {
          var result = await UserRequests().profileRequest({
            "device_type": "android",
            "device_token": "fgfgdfgf"
          });

          if (result is Map<String, dynamic>) {
            bc.baseUser.value = User.fromJson(result['data']);
            Get.off(() => HomePage());
          } else if (result is SocketException) {
            internetError.value = true;
          }
        } catch (e) {
          if(e is Response){}
        }
      }
      else{
        Get.off(()=>LoginPage());
      }
    });
  }

  getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
     if(Platform.isIOS){
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 1000),(){
      bc = Get.find<BaseController>();
    });
   // getDeviceDetails();
    initializeApp();
  }
}