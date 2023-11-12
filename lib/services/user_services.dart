import 'package:fairdraft/pages/AuthPages/login_page.dart';
import 'package:fairdraft/services/storage_services.dart';
import 'package:fairdraft/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import '../constants/app_strings.dart';
import '../main.dart';

class UserService{
  
  Future<bool> saveUser(String? token) async {
    return await StorageService.getPrefs().then((prefs) => prefs!.setString(AppStrings.userToken,token!));
  }

  Future<bool> saveUserFCMToken(String? token) async {
    return await StorageService.getPrefs().then((prefs) => prefs!.setString(AppStrings.notifToken,token!));
  }

  Future<bool> removeUser() async {
    return await StorageService.getPrefs().then((prefs) => prefs!.remove(AppStrings.userToken));
  }

  Future<bool> isLoggedIn() async {
    return await StorageService.getPrefs().then((prefs) => prefs!.containsKey(AppStrings.userToken));
  }

 Future<String?> getUserToken() async {
   return await StorageService.getPrefs().then((prefs) => prefs!.getString(AppStrings.userToken));
 }

 Future<String?> getUserFCMToken() async {
   return await StorageService.getPrefs().then((prefs) => prefs!.getString(AppStrings.notifToken));
 }

 logOut(){
    StorageService.getPrefs().then((prefs){
      prefs!.remove(AppStrings.userToken).then((value){
        Get.offAll(()=>LoginPage());
      });
    });
 }

 checkUserAuthenticity(int statusCode){
    if(statusCode == 401){
      logout();
    }
  }

  logout(){
    try{
      removeUser().then((value){
        if(value){
          Get.offAll(()=>LoginPage());
          Get.showSnackbar(
              CustomSnackbar(message: 'Please login again.',color: Colors.orange).getxSnackbar()
          );
        }
      });
    }
    catch(e){
      Get.offAll(()=>LoginPage());
    };

  }

}