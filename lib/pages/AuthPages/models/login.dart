class Login {
  String mobile = '';
  String password = '';
  String deviceType = '';
  String ?deviceToken;

  Login({this.mobile = '', this.password = '',this.deviceType='',this.deviceToken});

  Map<String, dynamic> toMap() {
    return {
      "mobile": mobile,
      "password": password,
      "device_type":deviceType,
      "device_token":deviceToken
    };
  }
}
