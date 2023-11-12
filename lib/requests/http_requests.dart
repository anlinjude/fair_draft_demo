import 'dart:convert';
import 'dart:io';
import 'package:fairdraft/constants/api.dart';
import 'package:fairdraft/services/user_services.dart';
import 'package:http/http.dart';

class HttpService {

  // ignore: non_constant_identifier_names
  static String BASE_URL = Api.base_url;

  //
  static Future<dynamic> postRequest(String apiEndPoint,Map<String,dynamic> postData,{bool insertHeader = false})async{

    Uri uri = Uri.parse(BASE_URL+apiEndPoint);
    var client =  Client();
    try{
      var response = await client.post(
        uri,
        headers: insertHeader?
        {'content-type': 'application/json',
          'accept':'application/json',
          'authorization': 'Bearer'+' ' +'${ await UserService().getUserToken()}'
        }
        :{'content-type': 'application/json'},
        body: json.encode(postData),
      );
      UserService().checkUserAuthenticity(response.statusCode);
      return response;
    }
    on SocketException catch (e) {
      return e;
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    }
  }

  //
  static Future<dynamic> getRequest(String apiEndPoint,{bool insertHeader=false}) async {
    var response;
    Uri uri = Uri.parse(BASE_URL + apiEndPoint);
    var client = Client();
    try {
      response = await client.get(
          uri,
          headers: insertHeader
              ? {'content-type': 'application/json',
                 'accept':'application/json',
                 'authorization': 'Bearer'+' ' +'${await UserService().getUserToken()}'}
              : {'content-type': 'application/json'}
      ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
               return Response('Timeout', 408);
                 });
      UserService().checkUserAuthenticity(response.statusCode);
      return response;
    } on SocketException catch (e) {
      return e;
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    }
  }
}

class NoInternetException {
  String message;
  NoInternetException(this.message);
}

class NoServiceFoundException {
  String message;
  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  String message;
  InvalidFormatException(this.message);
}

class UnknownException {
  String message;
  UnknownException(this.message);
}