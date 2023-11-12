import 'package:fairdraft/pages/BookingPages/models/options.dart';
import 'package:intl/intl.dart';

class Date {
  int ?id;
  String ?name;
  String ?slotInterval;
  String ?createdAt;
  String ?updatedAt;
  List<String> ?disabledDates;
  List<AvailableDate> ?availableDates;
  DateTime ?selectedDate;
  String selectedTime ='';
  List<String> ?timingList;
  List<Option> options =[];
  int ?visible_days;

  Date(
      {this.id,
        this.name,
        this.slotInterval,
        this.createdAt,
        this.updatedAt,
        this.disabledDates,
        this.availableDates,
        this.selectedDate,
        this.selectedTime='',
        this.visible_days,
        this.timingList =const []
      });

  Date.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slotInterval = json['slot_interval'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    disabledDates = json['disabled_dates'].cast<String>();
    if (json['available_dates'] != null) {
      availableDates = <AvailableDate>[];
      json['available_dates'].forEach((v) {
        availableDates?.add(AvailableDate.fromJson(v));
      });
    }
    visible_days = json['visible_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    /*  data['created_at'] = createdAt;
      data['updated_at'] = updatedAt;
      data['disabled_dates'] = disabledDates;
      if (availableDates != null) {
        data['available_dates'] =
            availableDates?.map((v) => v.toJson()).toList();
      }*/
    data['selected_date'] = selectedDate.toString();
    data['selected_time'] = selectedTime;
    List<Map<String,dynamic>> optionsMap = [];
    for (var element in options) {
      optionsMap.add(element.toJson());
    }
    data['selected_options'] = optionsMap;

    return data;
  }
}

class AvailableDate {
  String ?date;
  List<String> ?timeSlots;

  AvailableDate({this.date, this.timeSlots});

  AvailableDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timeSlots = json['time_slots'].cast<String>();
    timeSlots?.forEach((element) {
      int ?i = timeSlots?.indexWhere((time) => time==element);
      element = DateFormat("hh:mm").parse(element).toString();
      var dateFormat = DateFormat("h:mm a");
      element =  dateFormat.format(DateTime.parse(element));
      timeSlots![i!] = element;
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time_slots'] = timeSlots;
    return data;
  }
}