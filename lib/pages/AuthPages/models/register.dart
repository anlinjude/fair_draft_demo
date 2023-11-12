class Register {
  String ?name;
  String ?mobile;
  String ?whatsapp;
  String ?password;
  String ?referrer;
  String ?fcmToken;

  Register({this.name, this.mobile, this.whatsapp, this.password, this.referrer,this.fcmToken});

  Register.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '' ;
    mobile = json['mobile'] ?? '' ;
    whatsapp = json['whatsapp'] ?? '' ;
    password = json['password'] ?? '' ;
    referrer = json['referrer'] ?? '' ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['whatsapp'] = this.whatsapp;
    data['password'] = this.password;
    data['referrer'] = this.referrer;
    data['device_token'] = this.fcmToken;
    return data;
  }
}