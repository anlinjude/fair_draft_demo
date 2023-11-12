
import 'package:fairdraft/pages/BookingPages/models/sub_service.dart';

class Services {
  int ?id;
  String ?title;
  String ?name;
  int ?group;
  int ?sortOrder;
  List<SubService> ?subServices;

  Services(
      {this.id,
        this.title,
        this.name,
        this.group,
        this.sortOrder,
        this.subServices});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    group = json['group'];
    sortOrder = json['sort_order'];
    if (json['sub_services'] != null) {
      subServices =  <SubService>[];
      json['sub_services'].forEach((v) {
        subServices?.add(SubService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['group'] = this.group;
    data['sort_order'] = this.sortOrder;
    if (this.subServices != null) {
      data['sub_services'] = this.subServices?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}