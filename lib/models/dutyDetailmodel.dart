class DutyDetailsForDutyID {
  bool? success;
  int? status;
  String? message;
  Data? data;

  DutyDetailsForDutyID({this.success, this.status, this.message, this.data});

  DutyDetailsForDutyID.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? shiftName;
  Duty? duty;
  String? startTime;
  String? endTime;
  int? iV;

  Data(
      {this.sId,
      this.shiftName,
      this.duty,
      this.startTime,
      this.endTime,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shiftName = json['shift_name'];
    duty = json['duty'] != null ? new Duty.fromJson(json['duty']) : null;
    startTime = json['start_time'];
    endTime = json['end_time'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shift_name'] = this.shiftName;
    if (this.duty != null) {
      data['duty'] = this.duty!.toJson();
    }
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['__v'] = this.iV;
    return data;
  }
}

class Duty {
  String? sId;
  String? title;
  String? description;
  String? venue;
  String? location;
  String? note;

  Duty(
      {this.sId,
      this.title,
      this.description,
      this.venue,
      this.location,
      this.note});

  Duty.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    venue = json['venue'];
    location = json['location'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['venue'] = this.venue;
    data['location'] = this.location;
    data['note'] = this.note;
    return data;
  }
}
