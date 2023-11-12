import 'dart:io';

import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/constants/app_strings.dart';
import 'package:fairdraft/requests/user_requests.dart';
import 'package:fairdraft/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController{


  RxBool obscureText1 = true.obs;
  RxBool obscureText2 = true.obs;

  String password = '';
  String confirmPassword = '';

  RxBool busy = false.obs;

  GlobalKey<FormState> editProfileKey = GlobalKey();

  //manage loaders
  setBusy(bool value) {
    busy.value = value;
  }

  editProfileApi() async {
    if(editProfileKey.currentState!.validate()){
      setBusy(true);
      try{
        var result = await UserRequests().editProfileRequest({
          "password": password,
          "password_confirmation": confirmPassword
        });
        if(result is Map<String,dynamic>){
          print(result.runtimeType);
          Get.back();
          Get.showSnackbar(
            CustomSnackbar(
                message: result['message'],
              color: AppColor().proceedColor
            ).getxSnackbar()
          );
          setBusy(false);
        }
        else if(result is SocketException){
          setBusy(false);
          Get.showSnackbar(
              CustomSnackbar(
                  message: AppStrings.connection_error,
                  color: Colors.red
              ).getxSnackbar()
          );
        }
      }
      catch (e){
        setBusy(false);
        print(e);
      }
    }
  }


}