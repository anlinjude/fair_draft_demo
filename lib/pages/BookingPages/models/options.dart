class Option {
  int ?id;
  int ?sortOrder;
  String ?title;
  double ?amount;
  int ?service_id;
  int ?sub_service_id;
  String ?serviceName;
  String ?value;

  Option({this.id, this.sortOrder, this.title, this.amount,this.service_id,this.sub_service_id,this.serviceName,this.value});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '' ;
    sortOrder = json['sort_order'];
    title = json['title'] ?? '';
    amount = json["amount"]!=null?double.parse(json['amount'].toString()):0;
    service_id = json["service_id"];
    sub_service_id = json["sub_service_id"];
    value = '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['sort_order'] = sortOrder;
    data['name'] = title;
    data['amount'] = amount;
    data['service_id'] = service_id;
    data['sub_service_id'] = sub_service_id;
    data['value'] = value;
    return data;
  }
}