class User {
  int ?id;
  String ?name;
  String ?email;
  String ?countryCode;
  String ?mobile;
  int ?mobileVerified;
  String ?whatsapp;
  dynamic walletPoint;
  String ?referrer;
  int ?active;
  String ?createdAt;
  String ?updatedAt;
  String ?token;
  String ?referralCode;
  dynamic lockedPoint;
  String ?shareText;

  User(
      {this.id,
        this.name,
        this.email,
        this.countryCode,
        this.mobile,
        this.mobileVerified,
        this.whatsapp,
        this.walletPoint,
        this.referrer,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.referralCode,
        this.lockedPoint,
        this.shareText
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileVerified = json['mobile_verified'];
    whatsapp = json['whatsapp'];
    walletPoint = json['wallet_point'];
    lockedPoint = json["locked_point"] ?? 0.00;
    referrer = json['referrer'].toString();
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    referralCode = json["referral_code"] ?? "";
    shareText = json["share_text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['mobile_verified'] = this.mobileVerified;
    data['whatsapp'] = this.whatsapp;
    data['wallet_point'] = this.walletPoint;
    data['referrer'] = this.referrer;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}