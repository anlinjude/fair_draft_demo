import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fairdraft/pages/BookingHistory/Models/booking_history_model.dart';
import 'package:fairdraft/requests/user_requests.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookingHistoryController extends GetxController{

  RefreshController refreshController = RefreshController();

  RxList<BookingData> bookingData = <BookingData>[].obs;
  int pageNumber = 1;
  RxBool internetError = false.obs;
  RxBool busy = false.obs;

  getBookingList({bool initialLoad = false}) async{

    clearErrors();
    if(initialLoad){
      pageNumber = 1;
    }
    else{
      pageNumber++;
    }
    busy.value = true;
    try{
      var result = await UserRequests().bookingHistoryRequest(page: pageNumber);
      if(result is List<BookingData>){
         if(initialLoad){
           bookingData.value = result;
         }
         else{
           bookingData.addAll(result);
         }
      }
      else if(result is SocketException){
        internetError.value = true;
      }
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      busy.value = false;
    }
    catch (e){
       refreshController.refreshCompleted();
       refreshController.loadComplete();
       busy.value = false;
       print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBookingList(initialLoad: true);
  }

  clearErrors(){
    internetError.value = false;
  }
}