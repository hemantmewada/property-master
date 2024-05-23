class EmployeeCountModel {
  bool? status;
  Data? data;
  String? message;

  EmployeeCountModel({this.status, this.data, this.message});

  EmployeeCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? totaluser;
  int? todayuser;
  int? businessManager;
  int? sBusinessPartner;
  int? ftBusinessPartner;
  int? ptBusinessPartner;
  int? rejectUser;
  int? pendingKycUser;
  int? completeKycUser;
  int? activeUser;
  int? ourProjects;

  Data(
      {this.totaluser,
        this.todayuser,
        this.businessManager,
        this.sBusinessPartner,
        this.ftBusinessPartner,
        this.ptBusinessPartner,
        this.rejectUser,
        this.pendingKycUser,
        this.completeKycUser,
        this.activeUser,
        this.ourProjects});

  Data.fromJson(Map<String, dynamic> json) {
    totaluser = json['totaluser'];
    todayuser = json['todayuser'];
    businessManager = json['business_manager'];
    sBusinessPartner = json['s_business_partner'];
    ftBusinessPartner = json['ft_business_partner'];
    ptBusinessPartner = json['pt_business_partner'];
    rejectUser = json['reject_user'];
    pendingKycUser = json['pending_kyc_user'];
    completeKycUser = json['complete_kyc_user'];
    activeUser = json['active_user'];
    ourProjects = json['our_projects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totaluser'] = this.totaluser;
    data['todayuser'] = this.todayuser;
    data['business_manager'] = this.businessManager;
    data['s_business_partner'] = this.sBusinessPartner;
    data['ft_business_partner'] = this.ftBusinessPartner;
    data['pt_business_partner'] = this.ptBusinessPartner;
    data['reject_user'] = this.rejectUser;
    data['pending_kyc_user'] = this.pendingKycUser;
    data['complete_kyc_user'] = this.completeKycUser;
    data['active_user'] = this.activeUser;
    data['our_projects'] = this.ourProjects;
    return data;
  }
}
