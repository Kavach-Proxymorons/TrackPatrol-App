class AllDuties {
  bool? success;
  int? status;
  String? message;
  Data? data;

  AllDuties({this.success, this.status, this.message, this.data});

  AllDuties.fromJson(Map<String, dynamic> json) {
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
  List<Shifts>? shifts;
  int? totalPages;
  String? currentPage;

  Data({this.shifts, this.totalPages, this.currentPage});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shifts'] != null) {
      shifts = <Shifts>[];
      json['shifts'].forEach((v) {
        shifts!.add(new Shifts.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shifts != null) {
      data['shifts'] = this.shifts!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class Shifts {
  String? sId;
  String? shiftName;
  Duty? duty;
  String? startTime;
  String? endTime;
  int? iV;

  Shifts(
      {this.sId,
      this.shiftName,
      this.duty,
      this.startTime,
      this.endTime,
      this.iV});

  Shifts.fromJson(Map<String, dynamic> json) {
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
