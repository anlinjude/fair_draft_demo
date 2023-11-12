import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fairdraft/base_controller.dart';
import 'package:fairdraft/constants/api.dart';
import 'package:fairdraft/constants/app_strings.dart';
import 'package:fairdraft/pages/AuthPages/otp_page.dart';
import 'package:fairdraft/pages/EditProfilePage/edit_profile_page.dart';
import 'package:fairdraft/pages/HomePage/home_page.dart';
import 'package:fairdraft/requests/auth_requests.dart';
import 'package:fairdraft/services/user_services.dart';
import 'package:fairdraft/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/login.dart';
import '../models/register.dart';
import '../models/user.dart';

class AuthController extends GetxController {

  //ui
  TextEditingController tEC1 = TextEditingController();
  TextEditingController tEC2 = TextEditingController();
  TextEditingController nametEC = TextEditingController();
  TextEditingController mobiletEC = TextEditingController();
  TextEditingController passwordtEC = TextEditingController();
  TextEditingController confirmPasswordtEC = TextEditingController();
  TextEditingController referralTEC = TextEditingController();

  //form validators
  final loginKey = GlobalKey<FormState>();
  final signupKey = GlobalKey<FormState>();
  final forgotPasswordKey = GlobalKey<FormState>();

  PageController pageController = PageController();
  RxBool busy = false.obs;
  RxInt pageIndex = 0.obs;
  RxBool obscureText = true.obs;
  RxBool obscureText2 = true.obs;
  RxBool hideConfirmPassword = true.obs;

  //signup
  RxInt isWhatsApp = 1.obs;
  Register register = Register();
  User user = User();

  //manage loaders
  setBusy(bool value) {
    busy.value = value;
  }

  //register
  processSignUp() async {
     otp.value = '';
     isForgotPasswordPage.value = false;
    //form validation
    if (signupKey.currentState!.validate()) {
       signupKey.currentState!.save();

      if (isWhatsApp.value == 1) {
        register.whatsapp = register.mobile;
      }

      try {
        setBusy(true);//-->start loader
        var result = await AuthRequests().register(register.toJson());

        if (result is Map<String, dynamic>) {
          user = User.fromJson(result['data']);
          setBusy(false);//-->stop loader
          Get.to(() => OtpPage());
        }
        else if (result is SocketException) {
          showErrorMessage(result);
          setBusy(false);
        }
      } catch (e) {
        showErrorMessage(e);
        setBusy(false);
      }
    }
  }

  //login
  Login login = Login();
  bool isLogin = false;


  processLogin() async {
     otp.value = '';
     isForgotPasswordPage.value = false;
    if(loginKey.currentState!.validate()) {
      loginKey.currentState!.save();
      try {
        //
        setBusy(true);
        //
        user.mobile = login.mobile;
        login.deviceType =  Platform.isAndroid?"android":"ios";
        login.deviceToken = await UserService().getUserFCMToken();
        var result = await AuthRequests().loginAuth(login.toMap());

        if (result is Map<String, dynamic>) {
          user = User.fromJson(result['data']);
          finishLogin();
        }
        else if (result is SocketException) {
          showErrorMessage(result);
          setBusy(false);
        }
      }
      catch (e) {
         if(e is http.Response){
           showErrorMessage(e);
           if(e.statusCode==403){
               verifyMobile();
           }
         }
        setBusy(false);
      }
    }
  }

  //get otp if user not verified(Login) loginpage-->otppage
  verifyMobile({bool forgotPassword = false}) async {
    otp.value = '';
    try {
      //
      setBusy(true);
      //
      var result = await AuthRequests().verifyOtp({"mobile":user.mobile},apiEndPoint: ApiEndPoint.loginOtp);

      if (result is Map<String, dynamic>) {
        if(forgotPassword){
          isForgotPasswordPage.value = true;
        }
        Get.to(()=>OtpPage());
        setBusy(false);
      }
      else if (result is SocketException) {
        showErrorMessage(result);
        setBusy(false);
      }
    }
    catch (e) {
      setBusy(false);
      showErrorMessage(e);
    }
  }

  //otp
  RxString otp = ''.obs;

  //final otp check - otppage-->homepage
  verifyOtp() async {
    if(otp.value.length!=6){
      Get.showSnackbar(
          CustomSnackbar(
              message: 'Enter a valip otp',
              color: Colors.red).getxSnackbar()
      );
      return;
    }
    try {
      //
      setBusy(true);
      //
      var result = await AuthRequests().verifyOtp({
        "mobile": user.mobile,
        "otp": otp.value,
        "device_type": Platform.isAndroid?"android":"ios",
        "device_token": "123456"
      },apiEndPoint: ApiEndPoint.verifyOtp
      );

      if (result is Map<String, dynamic>) {
        user = User.fromJson(result['data']);
        if (user.token != null) {
          finishLogin();
        }
      } else if (result is SocketException) {
        showErrorMessage(result);
        setBusy(false);
      }
    } catch (e) {
      showErrorMessage(e);
      setBusy(false);
    }
  }

  //
  finishLogin(){
    UserService().saveUser(user.token).then((saved){
      if(saved){
        setBusy(false);
        bc.baseUser.value = user;
        if(!isForgotPasswordPage.value){
          Get.offAll(() => HomePage());
        }
        else
        {
          Get.offAll(()=> HomePage());
          Get.to(()=>EditProfilePage());
        }
      }
      else{
        showErrorMessage('Something went wrong.Please try again.');
        setBusy(false);
        return;
      }
    });
  }

  RxBool isForgotPasswordPage = false.obs;

  //
  forgotPassword(){
    if(forgotPasswordKey.currentState!.validate()){
      forgotPasswordKey.currentState!.save();
      verifyMobile(forgotPassword: true);
    }
  }

  //
  showErrorMessage(dynamic e ){
    if(e is http.Response) {
      Get.showSnackbar(
          CustomSnackbar(
              message: jsonDecode(e.body)['error'],
              color: Colors.red).getxSnackbar()
      );
    }
    else if(e is SocketException){
      Get.showSnackbar(
          CustomSnackbar(
              message: AppStrings.connection_error,
              color: Colors.red
          ).getxSnackbar()
      );
    }
    else if(e is String){
      Get.showSnackbar(
          CustomSnackbar(
              message: e,
              color: Colors.red
          ).getxSnackbar()
      );
    }
  }


late BaseController bc;

  //
  @override
  Future<void> onInit() async {
    bc = Get.find<BaseController>();
    if (kDebugMode) {
      nametEC.text = 'jude' + '${Random().nextInt(500)}';
      mobiletEC.text = '${1000000000 + Random().nextInt(2000)}';
      passwordtEC.text = '123456';
      confirmPasswordtEC.text = '123456';
    }
    register.fcmToken = await UserService().getUserFCMToken();
    super.onInit();
  }
}