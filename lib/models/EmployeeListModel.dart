class EmployeeListModel {
  bool? status;
  List<Data>? data;
  String? message;

  EmployeeListModel({this.status, this.data, this.message});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? empId;
  String? mobile;
  String? profileImg;
  String? registerDateTime;
  String? role;
  int? totalLeads;

  Data(
      {this.userId,
        this.name,
        this.empId,
        this.mobile,
        this.profileImg,
        this.registerDateTime,
        this.role,
        this.totalLeads});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    empId = json['emp_id'];
    mobile = json['mobile'];
    profileImg = json['profile_img'];
    registerDateTime = json['register_date_time'];
    role = json['role'];
    totalLeads = json['total_leads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['emp_id'] = this.empId;
    data['mobile'] = this.mobile;
    data['profile_img'] = this.profileImg;
    data['register_date_time'] = this.registerDateTime;
    data['role'] = this.role;
    data['total_leads'] = this.totalLeads;
    return data;
  }
}
