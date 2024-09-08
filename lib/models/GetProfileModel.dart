class GetProfileModel {
  bool? status;
  Data? data;
  String? message;

  GetProfileModel({this.status, this.data, this.message});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? fatherName;
  String? mobile;
  String? alternateMobile;
  String? email;
  String? doj;
  String? doa;
  String? dob;
  String? idNo;
  String? currentAddress;
  String? aadharNo;
  String? panNo;
  String? designation;
  String? companyName;
  String? companyDesignation;
  String? totalExperience;
  String? workNature;
  String? bankName;
  String? acNo;
  String? branchName;
  String? ifsc;
  String? aadharcardFront;
  String? aadharcardBack;
  String? pancardImg;
  String? passbookImg;
  String? cancelCheque;
  String? kycUpdatedStatus;

  Data(
      {this.name,
        this.fatherName,
        this.mobile,
        this.alternateMobile,
        this.email,
        this.doj,
        this.doa,
        this.dob,
        this.idNo,
        this.currentAddress,
        this.aadharNo,
        this.panNo,
        this.designation,
        this.companyName,
        this.companyDesignation,
        this.totalExperience,
        this.workNature,
        this.bankName,
        this.acNo,
        this.branchName,
        this.ifsc,
        this.aadharcardFront,
        this.aadharcardBack,
        this.pancardImg,
        this.passbookImg,
        this.cancelCheque,
        this.kycUpdatedStatus});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fatherName = json['father_name'];
    mobile = json['mobile'];
    alternateMobile = json['alternate_mobile'];
    email = json['email'];
    doj = json['doj'];
    doa = json['doa'];
    dob = json['dob'];
    idNo = json['id_no'];
    currentAddress = json['current_address'];
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    designation = json['designation'];
    companyName = json['company_name'];
    companyDesignation = json['company_designation'];
    totalExperience = json['total_experience'];
    workNature = json['work_nature'];
    bankName = json['bank_name'];
    acNo = json['ac_no'];
    branchName = json['branch_name'];
    ifsc = json['ifsc'];
    aadharcardFront = json['aadharcard_front'];
    aadharcardBack = json['aadharcard_back'];
    pancardImg = json['pancard_img'];
    passbookImg = json['passbook_img'];
    cancelCheque = json['cancel_cheque'];
    kycUpdatedStatus = json['kyc_updated_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mobile'] = this.mobile;
    data['alternate_mobile'] = this.alternateMobile;
    data['email'] = this.email;
    data['doj'] = this.doj;
    data['doa'] = this.doa;
    data['dob'] = this.dob;
    data['id_no'] = this.idNo;
    data['current_address'] = this.currentAddress;
    data['aadhar_no'] = this.aadharNo;
    data['pan_no'] = this.panNo;
    data['designation'] = this.designation;
    data['company_name'] = this.companyName;
    data['company_designation'] = this.companyDesignation;
    data['total_experience'] = this.totalExperience;
    data['work_nature'] = this.workNature;
    data['bank_name'] = this.bankName;
    data['ac_no'] = this.acNo;
    data['branch_name'] = this.branchName;
    data['ifsc'] = this.ifsc;
    data['aadharcard_front'] = this.aadharcardFront;
    data['aadharcard_back'] = this.aadharcardBack;
    data['pancard_img'] = this.pancardImg;
    data['passbook_img'] = this.passbookImg;
    data['cancel_cheque'] = this.cancelCheque;
    data['kyc_updated_status'] = this.kycUpdatedStatus;
    return data;
  }
}
