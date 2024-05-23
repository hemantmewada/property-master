class LoginModel {
  bool? status;
  Data? data;
  String? message;

  LoginModel({this.status, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? userCode;
  String? uId;
  String? empId;
  String? name;
  String? fatherName;
  String? mobile;
  String? email;
  String? password;
  String? role;
  String? status;
  String? loginStatus;
  String? blockStatus;
  String? registerDateTime;
  String? dob;
  String? doa;
  String? doj;
  String? profileImg;
  String? district;
  String? state;
  String? area;
  String? alternateMobile;
  String? token;
  String? panKyc;
  String? aadharKyc;
  String? bankingKyc;
  String? chequeKyc;
  String? kycStatus;
  String? kycApproved;
  String? byEmpId;
  String? address;
  String? mobile2;
  String? designation;
  String? companyDesignation;
  String? workNature;
  String? aadharNo;
  String? panNo;
  String? reraNo;
  String? jobType;
  String? pinCode;
  String? occupation;
  String? businessName;
  String? companyName;
  String? parentId;
  String? tree;
  String? totalExperience;
  String? natureOfWork;
  String? bankName;
  String? acNo;
  String? branchName;
  String? ifsc;
  String? aadharcardFront;
  String? aadharcardBack;
  String? pancardImg;
  String? passbookImg;
  String? cancelCheque;
  String? deleteStatus;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
        this.userCode,
        this.uId,
        this.empId,
        this.name,
        this.fatherName,
        this.mobile,
        this.email,
        this.password,
        this.role,
        this.status,
        this.loginStatus,
        this.blockStatus,
        this.registerDateTime,
        this.dob,
        this.doa,
        this.doj,
        this.profileImg,
        this.district,
        this.state,
        this.area,
        this.alternateMobile,
        this.token,
        this.panKyc,
        this.aadharKyc,
        this.bankingKyc,
        this.chequeKyc,
        this.kycStatus,
        this.kycApproved,
        this.byEmpId,
        this.address,
        this.mobile2,
        this.designation,
        this.companyDesignation,
        this.workNature,
        this.aadharNo,
        this.panNo,
        this.reraNo,
        this.jobType,
        this.pinCode,
        this.occupation,
        this.businessName,
        this.companyName,
        this.parentId,
        this.tree,
        this.totalExperience,
        this.natureOfWork,
        this.bankName,
        this.acNo,
        this.branchName,
        this.ifsc,
        this.aadharcardFront,
        this.aadharcardBack,
        this.pancardImg,
        this.passbookImg,
        this.cancelCheque,
        this.deleteStatus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userCode = json['user_code'];
    uId = json['u_id'];
    empId = json['emp_id'];
    name = json['name'];
    fatherName = json['father_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    loginStatus = json['login_status'];
    blockStatus = json['block_status'];
    registerDateTime = json['register_date_time'];
    dob = json['dob'];
    doa = json['doa'];
    doj = json['doj'];
    profileImg = json['profile_img'];
    district = json['district'];
    state = json['state'];
    area = json['area'];
    alternateMobile = json['alternate_mobile'];
    token = json['token'];
    panKyc = json['pan_kyc'];
    aadharKyc = json['aadhar_kyc'];
    bankingKyc = json['banking_kyc'];
    chequeKyc = json['cheque_kyc'];
    kycStatus = json['kyc_status'];
    kycApproved = json['kyc_approved'];
    byEmpId = json['by_emp_id'];
    address = json['address'];
    mobile2 = json['mobile2'];
    designation = json['designation'];
    companyDesignation = json['company_designation'];
    workNature = json['work_nature'];
    aadharNo = json['aadhar_no'];
    panNo = json['pan_no'];
    reraNo = json['rera_no'];
    jobType = json['job_type'];
    pinCode = json['pin_code'];
    occupation = json['occupation'];
    businessName = json['business_name'];
    companyName = json['company_name'];
    parentId = json['parent_id'];
    tree = json['tree'];
    totalExperience = json['total_experience'];
    natureOfWork = json['nature_of_work'];
    bankName = json['bank_name'];
    acNo = json['ac_no'];
    branchName = json['branch_name'];
    ifsc = json['ifsc'];
    aadharcardFront = json['aadharcard_front'];
    aadharcardBack = json['aadharcard_back'];
    pancardImg = json['pancard_img'];
    passbookImg = json['passbook_img'];
    cancelCheque = json['cancel_cheque'];
    deleteStatus = json['delete_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_code'] = this.userCode;
    data['u_id'] = this.uId;
    data['emp_id'] = this.empId;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['login_status'] = this.loginStatus;
    data['block_status'] = this.blockStatus;
    data['register_date_time'] = this.registerDateTime;
    data['dob'] = this.dob;
    data['doa'] = this.doa;
    data['doj'] = this.doj;
    data['profile_img'] = this.profileImg;
    data['district'] = this.district;
    data['state'] = this.state;
    data['area'] = this.area;
    data['alternate_mobile'] = this.alternateMobile;
    data['token'] = this.token;
    data['pan_kyc'] = this.panKyc;
    data['aadhar_kyc'] = this.aadharKyc;
    data['banking_kyc'] = this.bankingKyc;
    data['cheque_kyc'] = this.chequeKyc;
    data['kyc_status'] = this.kycStatus;
    data['kyc_approved'] = this.kycApproved;
    data['by_emp_id'] = this.byEmpId;
    data['address'] = this.address;
    data['mobile2'] = this.mobile2;
    data['designation'] = this.designation;
    data['company_designation'] = this.companyDesignation;
    data['work_nature'] = this.workNature;
    data['aadhar_no'] = this.aadharNo;
    data['pan_no'] = this.panNo;
    data['rera_no'] = this.reraNo;
    data['job_type'] = this.jobType;
    data['pin_code'] = this.pinCode;
    data['occupation'] = this.occupation;
    data['business_name'] = this.businessName;
    data['company_name'] = this.companyName;
    data['parent_id'] = this.parentId;
    data['tree'] = this.tree;
    data['total_experience'] = this.totalExperience;
    data['nature_of_work'] = this.natureOfWork;
    data['bank_name'] = this.bankName;
    data['ac_no'] = this.acNo;
    data['branch_name'] = this.branchName;
    data['ifsc'] = this.ifsc;
    data['aadharcard_front'] = this.aadharcardFront;
    data['aadharcard_back'] = this.aadharcardBack;
    data['pancard_img'] = this.pancardImg;
    data['passbook_img'] = this.passbookImg;
    data['cancel_cheque'] = this.cancelCheque;
    data['delete_status'] = this.deleteStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
