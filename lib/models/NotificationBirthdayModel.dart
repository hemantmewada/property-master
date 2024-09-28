class NotificationBirthdayModel {
  bool? status;
  String? message;
  List<Data>? data;

  NotificationBirthdayModel({this.status, this.message, this.data});

  NotificationBirthdayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? profileImg;
  String? dob;

  Data({this.name, this.profileImg, this.dob});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImg = json['profile_img'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_img'] = this.profileImg;
    data['dob'] = this.dob;
    return data;
  }
}
