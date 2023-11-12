class BookingInfo {
  String ?name;
  String ?gender;
  String ?mobile;
  String ?whatsapp;
  String ?email;

  BookingInfo({this.name, this.gender, this.mobile, this.whatsapp, this.email});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    data['mobile'] = mobile;
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    return data;
  }
}
