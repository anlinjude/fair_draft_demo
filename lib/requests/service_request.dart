import 'dart:convert';
import 'package:fairdraft/constants/api.dart';
import 'package:flutter/foundation.dart';
import '../pages/BookingPages/models/date.dart';
import '../pages/BookingPages/models/services.dart';
import 'http_requests.dart';
import 'package:http/http.dart';

class ServiceRequests{

  Future<dynamic> getServices() async {
    List<Services> service = [];

    var response = (await HttpService.getRequest(ApiEndPoint.services));

    if (response is Response) {
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        var serviceResponse = responseData["data"]["services"];
        serviceResponse.map((serviceData) {
          return service.add(Services.fromJson(serviceData));
        }).toList();
      } else {
        throw (responseData['message']);
      }
      return service;
    } else {
      return response;
    }
  }

  Future<dynamic> getDates(List<int> groupIds) async {
    List<Date> dates = [];

    var response = (await HttpService.getRequest(ApiEndPoint.groups));
    if (response is Response) {
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        var serviceResponse = responseData["data"];
        serviceResponse.map((serviceData) {
          return dates.add(Date.fromJson(serviceData));
        }).toList();
      } else {
        throw (responseData['message']);
      }
      return dates;
    } else {
      return response;
    }
  }

  bookService(Map<String,dynamic> postData) async {
   print(postData);
    var response = (await HttpService.postRequest(ApiEndPoint.book,postData,insertHeader: true));
    if (response is Response) {
       print(response.statusCode);
      var responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw (responseData['message']);
      }
    } else {
      return response;
    }
  }
}