import 'dart:convert';
import 'dart:developer';
import 'package:fairdraft/pages/BookingHistory/Models/booking_history_model.dart';
import 'package:fairdraft/pages/MyTransactionsPage/models/transaction_model.dart';
import 'package:fairdraft/requests/http_requests.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../constants/api.dart';
import '../pages/MyFriendsPage/models/my_friend_Model.dart';
import '../services/user_services.dart';

class UserRequests extends HttpService{

  Future<dynamic> profileRequest(Map<String,dynamic> postData) async{

    postData["device_token"] = await UserService().getUserFCMToken();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    postData["version"] = packageInfo.version;
    var response = await HttpService.postRequest(ApiEndPoint.profile, postData,insertHeader: true);
    if(response is Response){
      if(response.statusCode==200){
        if (kDebugMode) {
          print('profile api-->OK');
        }
        var responseData = json.decode(response.body);
        return responseData;
      }
      else{
        throw(response.body);
      }
    }
    else {
      return response;
    }
  }

  Future<dynamic> editProfileRequest(Map<String,dynamic> postData) async{

    var response = await HttpService.postRequest(ApiEndPoint.reset_password, postData,insertHeader: true);

    if(response is Response){
      if(response.statusCode==200){
        if (kDebugMode) {
          print('Edit Profile-->OK');
        }
        var responseData = json.decode(response.body);
        return responseData;
      }
      else{
        throw(response.body);
      }
    }
    else {
      return response;
    }
  }

  Future<dynamic> bookingHistoryRequest({int page = 1}) async{

    var response = await HttpService.getRequest(ApiEndPoint.book+'?page=$page',insertHeader: true);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        var result = responseData['data']['data'] as List<dynamic>;
        return result.map((element) {
           return BookingData.fromJson(element);
        }).toList();
      }
      throw(response.body);
    }
    return response;

  }

  Future<dynamic> transactionsRequest({int page = 1}) async{

    var response = await HttpService.getRequest(ApiEndPoint.transactions+'?page=$page',insertHeader: true);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        var result = responseData['data']['transactions']['data'] as List<dynamic>;
        return result.map((element) {
           return Transaction.fromJson(element);
        }).toList();
      }
      throw(response.body);
    }
    return response;

  }

  Future<dynamic> getFriendsRequest({int page = 1}) async{

    var response = await HttpService.getRequest(ApiEndPoint.getFriends+'?page=$page',insertHeader: true);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        var result = responseData['data']['data'] as List<dynamic>;
        return result.map((element) {
           return Friend.fromJson(element);
        }).toList();
      }
      throw(response.body);
    }
    return response;

  }
}