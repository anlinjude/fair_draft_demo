import 'dart:convert';

import 'package:fairdraft/constants/api.dart';
import 'package:fairdraft/requests/http_requests.dart';
import 'package:http/http.dart';

class AuthRequests extends HttpService {
  
  Future<dynamic> register(Map<String,dynamic> postData) async{
    
    var response = await HttpService.postRequest(ApiEndPoint.register, postData);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        return responseData;
      }
      else{
        throw(response);
      }
    }
    else {
      return response;
    }
  }

  Future<dynamic> verifyOtp(Map<String,dynamic> postData,{String ?apiEndPoint}) async{

    var response = await HttpService.postRequest(apiEndPoint!,postData);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        return responseData;
      }
      else{
        throw(response);
      }
    }
    else {
      return response;
    }
  }

  Future<dynamic> loginAuth(Map<String,dynamic> postData) async{

    var response = await HttpService.postRequest(ApiEndPoint.login,postData);

    if(response is Response){
      if(response.statusCode==200){
        var responseData = json.decode(response.body);
        return responseData;
      }
      else{
        throw(response);
      }
    }
    else {
      return response;
    }
  }


}