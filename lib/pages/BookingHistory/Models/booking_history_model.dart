
class BookingData {
  int ?id;
  int ?userId;
  String ?subTotal;
  String ?discount;
  String ?total;
  String ?status;
  String ?name;
  String ?gender;
  String ?mobile;
  String ?whatsapp;
  List<BookedServices> bookedServices = [];

  BookingData(
      {this.id,
        this.userId,
        this.subTotal,
        this.discount,
        this.total,
        this.status,
        this.name,
        this.gender,
        this.mobile,
        this.whatsapp,
        this.bookedServices = const[]});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    total = json['total'];
    status = json['status'];
    name = json['name'];
    gender = json['gender'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    if (json['booked_services'] != null) {
      bookedServices = <BookedServices>[];
      json['booked_services'].forEach((v) {
        bookedServices.add(BookedServices.fromJson(v));
      });
    }
  }
}

class BookedServices {
  int ?id;
  int ?bookingId;
  int ?serviceId;
  List<BookedOptions> ?bookedOptions;
  Service ?service;
  BookedSlot ?bookedSlot;

  BookedServices(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.bookedOptions,
        this.service,
        this.bookedSlot});

  BookedServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    if (json['questions'] != null) {
      bookedOptions = <BookedOptions>[];
      json['questions'].forEach((v) {
        bookedOptions!.add(BookedOptions.fromJson(v));
      });
    }
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    bookedSlot = json['booked_slot'] != null
        ? BookedSlot.fromJson(json['booked_slot'])
        : null;
  }

}

class BookedOptions {
  String ?question;
  List<Options> ?options;

  BookedOptions({this.question, this.options});

  BookedOptions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answers'] != null) {
      options =  <Options>[];
      json['answers'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['question'] = question;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String ?option;
  String ?price;

  Options({this.option, this.price});

  Options.fromJson(Map<String, dynamic> json) {
    option = json['title'];
    price = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['option'] = this.option;
    data['price'] = this.price;
    return data;
  }
}

class Service {
  int ?id;
  int ?group;
  String ?title;
  String ?name;
  int ?sortOrder;
  String ?createdAt;
  String ?updatedAt;

  Service(
      {this.id,
        this.group,
        this.title,
        this.name,
        this.sortOrder,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    title = json['title'];
    name = json['name'];
    sortOrder = json['sort_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['group'] = this.group;
    data['title'] = this.title;
    data['name'] = this.name;
    data['sort_order'] = this.sortOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BookedSlot {
  int ?id;
  int ?groupId;
  int ?bookedServiceId;
  String ?bookedDate;
  String ?bookedTime;
  String ?createdAt;
  String ?updatedAt;

  BookedSlot(
      {this.id,
        this.groupId,
        this.bookedServiceId,
        this.bookedDate,
        this.bookedTime,
        this.createdAt,
        this.updatedAt});

  BookedSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    bookedServiceId = json['booked_service_id'];
    bookedDate = json['booked_date'];
    bookedTime = json['booked_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['booked_service_id'] = this.bookedServiceId;
    data['booked_date'] = this.bookedDate;
    data['booked_time'] = this.bookedTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

