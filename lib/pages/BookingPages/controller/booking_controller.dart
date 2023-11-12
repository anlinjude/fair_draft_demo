import 'dart:io';

import 'package:fairdraft/base_controller.dart';
import 'package:fairdraft/pages/BookingPages/date_selection_page.dart';
import 'package:fairdraft/pages/BookingPages/models/booking_info.dart';
import 'package:fairdraft/pages/BookingPages/models/sub_service.dart';
import 'package:fairdraft/pages/HomePage/home_page.dart';
import 'package:fairdraft/pages/SuccessPage/booking_success.dart';
import 'package:fairdraft/requests/service_request.dart';
import 'package:fairdraft/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../models/date.dart';
import '../models/options.dart';
import '/pages/BookingPages/models/services.dart';
import '../form_page.dart';

class BookingController extends GetxController with GetSingleTickerProviderStateMixin{

  //ui handlers
  RxBool internetError = false.obs;//for showing retry button
  AnimationController ?animationController;
  AnimationController ?dateSheetAnimationController;
  AnimationController ?timeSheetAnimationController;

  //service selection page--------------------------------------------------------------------------------------------------------------------------

  RxList<Services> serviceList = <Services>[].obs;//service list api data--> main data

  Services currentService = Services();//service sheet-->keep track of selected service

  RxList<Option> selectedOptions = <Option>[].obs;//selected options-->core data

  RxMap<int, List<Option>> group = <int, List<Option>>{}.obs;//seperate options by group

  RxSet<int> selectedServices =  <int>{}.obs;//delete button

  RxDouble price = 0.00.obs;

  RxMap<int,Option> radioMap = <int,Option>{}.obs;//service sheet-->keep track of selected radio options

  TextEditingController tattooTEC = TextEditingController();


  //date selection------------------------------------------------------------------------------------------------------------------------------
  RxInt currentGroup = 0.obs;

  RxList<Date> dates = <Date>[].obs;//dates api data-->main data

  RxMap<int,Date> dateMap = <int,Date>{}.obs;//keep track of selected dates for ui handling

  RxBool proceed = false.obs;//determines if user can go to final page of registration

  //form handlers-->final form page------------------------------------------------------------------------------------------------------------
  RxInt isWhatsApp = 1.obs;
  RxInt sex = 2.obs;
  BookingInfo bookingInfo = BookingInfo();
  GlobalKey<FormState> finalFormKey = GlobalKey();

  //service list api
  getServices() async {
    try {
      var result = await ServiceRequests().getServices();
      if (result is List<Services>) {
        serviceList.value = result;
      } else {
        if (kDebugMode) {
          print('socket error');
        }
        internetError.value = true;
      }
    } catch (e) {}
  }

  //dates api
  getServiceDates() async {
    internetError.value = false;
    if (dates.isEmpty) {
      try {
        var result = await ServiceRequests().getDates(group.keys.toList());
        if (result is List<Date>) {
          dates.value = result;
        } else {
          print('socket error');
          internetError.value = true;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  //
  serviceSelection(Services service) {
    currentService = service;
  }

  //
  chooseOptions(bool value, Option option, SubService subService,
      {String? radioValue}) {

    //for service bottom sheet
    if (subService.type == "multiple") {
      if (value == false) {
        selectedOptions.removeWhere((e) => e == option);
      } else {
        selectedOptions.add(option);
      }
    } else if (subService.type == "single") {
      if (value == false) {
        selectedOptions.removeWhere((e) => e == option);
      } else {
        //remove previously selected option
        selectedOptions.removeWhere((e) => e.service_id == currentService.id && e.sub_service_id == subService.id);
        selectedOptions.add(option);
      }
    }
    filterSelectedServices();
    calculatePrice();
  }

  //
  radioButtonPressed(SubService subservice, Option value) {

    if(radioMap.containsKey(subservice.id)){
      radioMap[subservice.id!] = value;
    }
    else{
      radioMap.putIfAbsent(subservice.id!, () => value);
    }
    selectedOptions.removeWhere((option) => option.service_id == currentService.id && option.sub_service_id == subservice.id);
    selectedOptions.add(value);
    //
    filterSelectedServices();
    calculatePrice();
  }

  String tattooText = '';
  //
  addTattooText(String input,SubService subService){
    if(input.isEmpty){
      selectedOptions.removeWhere((e) => e.service_id==currentService.id && e.sub_service_id==subService.id);
      group[currentService.group]!.removeWhere((e) => e.service_id==currentService.id && e.sub_service_id==subService.id);
      return;
    }

    if(selectedOptions.isNotEmpty && selectedOptions.firstWhereOrNull((e) => e.service_id==currentService.id && e.sub_service_id==subService.id)!=null) {

      selectedOptions[selectedOptions.indexWhere((e) => e.service_id==currentService.id && e.sub_service_id==subService.id)]
                    = Option(service_id: currentService.id,sub_service_id: subService.id,value: input);
    }
    else{
      selectedOptions.add( Option(service_id: currentService.id,sub_service_id: subService.id,value: input));
    }
    filterSelectedServices();
  }

  //
  bool serviceSelectionCheck(int currentServiceId){
    bool value = false;
    selectedOptions.map((option) {
      if(option.service_id == currentServiceId){
        value = true;
        return;
      }
    }).toList();
    return value;
  }

  //
  filterSelectedServices(){
    selectedServices.clear();
    for (var element in selectedOptions) {
      selectedServices.add(element.service_id!);
    }
  }

  //clear button pressed-->clear all selections from service
  clearService(int serviceId){

    selectedServices.remove(serviceId);//removes tick in particular service

    selectedOptions.removeWhere((option) => option.service_id==serviceId);//removes selected options from this service

    //removes options from group map

    for (var element in serviceList) {
      if(element.id==serviceId){
        element.subServices!.forEach((element) {
           if(radioMap.containsKey(element.id)){
             radioMap.update(element.id!, (value) => Option());
           }
        });
      }
    }//clear radio values

    tattooTEC.text='';//clear tattoo textfield
    calculatePrice();
  }

  //
  calculatePrice(){
    price.value = 0;
    for (var element in selectedOptions) {
      price.value+=double.parse(element.amount.toString());
    }
  }

  //
  retry() async {
    internetError.value = false;
    await getServices();
  }

  //updateDate
  updateDate(DateRangePickerSelectionChangedArgs details) {
    for (var date in dates) {
      if (date.id == currentGroup.value) {
        date.selectedDate = details.value;
        date.selectedDate = DateUtils.dateOnly(date.selectedDate!);
        date.availableDates?.forEach((element) {
          if(DateTime.parse(element.date!)==date.selectedDate){
            date.timingList = element.timeSlots;
          }
        });
        date.selectedTime='';
        dateMap[currentGroup.value] = date;
        if (kDebugMode) {
          print('group-->${currentGroup.value}-->'+'${date.selectedDate}');
        }
      }
    }
    print(dateMap.values);
    validateDates();
  }

  //updateTime
  updateTime(String time) {
    for (var date in dates) {
       if(date.id==currentGroup.value){
         date.selectedTime = time;
         dateMap[currentGroup.value] = date;
       }
    }
    print(dateMap.values);
    validateDates();
  }

  //verifydates-->show selected in ui-->tick
  bool verifyDate(int group) {
    bool value = false;
    for (var date in dates) {
      if(date.id==group){
        if(date.selectedDate!=null){
          value = true;
        }
      }
    }
    return value;
  }

  //verifytime-->show selected in ui-->tick
  bool verifyTime(int group) {
    bool value = false;
    for (var date in dates) {
      if(date.id==group){
        if(date.selectedTime.isNotEmpty){
          value = true;
        }
      }
    }
    return value;
  }

  //
  DateTime initialDisplayDate() {
    DateTime ?dateTime;
    for (var date in dates) {
      if(date.id==currentGroup.value && date.selectedDate!=null){
        dateTime = date.selectedDate;
      }
    }
    return dateTime ?? DateTime.now();
  }

  //
   validateDates(){
    for (var groupid in group.keys) {

      if(verifyDate(groupid) && verifyTime(groupid)){
        proceed.value = true;
      }
      else{
        proceed.value = false;
        return;
      }
    }
  }

  //navigation
  toDatePage() async {

    group.clear();
    //add values to group map for use in date page
    for (var service in serviceList) {
      for (var element in selectedOptions) {
        if(element.service_id==service.id){
          if(group.containsKey(service.group)){
            group[service.group]!.add(element);
            print(service.group);
          }
          else{
            group.putIfAbsent(service.group!, () => [element]);
            print(service.group);
          }
        }
      }
    }
    //clear selected values from date page
    serviceGroupMap.clear();
    dateMap.clear();
    dates.clear();
    proceed.value=false;
    //
    for (var element in serviceList) {
      for (var option in selectedOptions) {
        if(option.service_id==element.id){
          if(serviceGroupMap.containsKey(element.group)){
            serviceGroupMap[element.group]?.add(element.title!);
          }
          else{
            serviceGroupMap.putIfAbsent(element.group!, () => [element.title!]);
          }
        }
      }
    }
    print(serviceGroupMap);
    Get.to(() => DateSelectionPage());
    if(dates.isEmpty){
      getServiceDates();
    }
  }

  Map<int,List<String>> serviceGroupMap = {};

  //
  List<Map<String, dynamic>> postData = [];
  toFormPage() {
    postData.clear();
    for (var element in dates) {
      group.forEach((key, value) {
        if (key == element.id) {
          element.options = value;
          postData.add(element.toJson());
        }
      });
    }
    print(postData);
    //ServiceRequests().bookService({'data': postData});
    sex.value = 2;
    Get.to(() => FormPage());
  }

  //
  RxBool isBusy = false.obs;

  book() async{
    if(finalFormKey.currentState!.validate()){
        isBusy.value = true;
        internetError.value = false;
        finalFormKey.currentState!.save();
        if(isWhatsApp.value==1){
          bookingInfo.whatsapp = bookingInfo.mobile;
        }
        //
        try{
          var result = await ServiceRequests().bookService(
              { 'booking_info': postData,
                'customer_info': bookingInfo.toJson()
              });
          if(result is Map){
            Get.offUntil(GetPageRoute(page: () => HomePage()),(route) => false);
            Get.to(()=> BookingSuccess());
          }
         else if(result is SocketException){
            internetError.value = true;
            CustomSnackbar(
              message: 'No or slow internet.Please try again.',
              color: Colors.red,
            ).getxSnackbar();
          }
          isBusy.value = false;
        }
        catch (e){
          isBusy.value = false;
          CustomSnackbar(
            message: e as String,
            color: Colors.red,
          ).getxSnackbar();
          print('booking error ==> $e');
        }
    }
  }

  //
  closeSheet() {
    Get.back();
  }

  //
  showSnackBar({String message='Select atleast one service to continue'}) {
    Get.showSnackbar(
        CustomSnackbar(
            message: message,
            color: const Color(0xff003366)
        ).getxSnackbar()
    );
  }

  //

  AnimationStatusListener ?animationStatusListener;

  initializeAnimation(){
      animationStatusListener = (status){
      if(status == AnimationStatus.completed){
        animationController!.animateTo(0.7,duration: const Duration(milliseconds: 300));
        animationController!.removeStatusListener(animationStatusListener!);
      }
    };
    animationController!.addStatusListener(animationStatusListener!);
  }

  BaseController bc = BaseController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  //
  @override
  void onInit() {
    bc = Get.find<BaseController>();
    nameController.text = bc.baseUser.value.name!;
    phoneController.text = bc.baseUser.value.mobile!;
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    getServices();
    super.onInit();
  }

  @override
  void dispose() {
    tattooTEC.dispose();
    animationController!.dispose();
    dateSheetAnimationController!.dispose();
    timeSheetAnimationController!.dispose();
    super.dispose();
  }
}