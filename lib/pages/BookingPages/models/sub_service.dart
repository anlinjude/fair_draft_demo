import 'options.dart';

class SubService {
  int ?id;
  String ?type;
  String ?title;
  String ?name;
  int ?sortOrder;
  List<Option> ?options;

  SubService(
      {this.id,
        this.type,
        this.title,
        this.name,
        this.sortOrder,
        this.options});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    name = json['name'];
    sortOrder = json['sort_order'];
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options?.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['name'] = this.name;
    data['sort_order'] = this.sortOrder;
    if (this.options != null) {
      data['options'] = this.options?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}