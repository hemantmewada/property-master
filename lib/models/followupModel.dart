class FollowupListModel {
  bool? status;
  Data? data;
  String? message;

  FollowupListModel({this.status, this.data, this.message});

  FollowupListModel.fromJson(Map<String, dynamic> json) {
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
  List<Followup>? followup;
  Leads? leads;

  Data({this.followup, this.leads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followup'] != null) {
      followup = <Followup>[];
      json['followup'].forEach((v) {
        followup!.add(new Followup.fromJson(v));
      });
    }
    leads = json['leads'] != null ? new Leads.fromJson(json['leads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followup != null) {
      data['followup'] = this.followup!.map((v) => v.toJson()).toList();
    }
    if (this.leads != null) {
      data['leads'] = this.leads!.toJson();
    }
    return data;
  }
}

class Followup {
  String? id;
  String? customerType;
  String? leadId;
  String? userId;
  String? leadType;
  String? type;
  String? visitNo;
  String? date;
  String? time;
  String? visitors;
  String? caseSummery;
  String? nextFollowupType;
  String? nextFollowupDate;
  String? nextFollowupTime;
  String? nextFollowupNote;
  String? projectId;
  String? insertDate;
  String? priceInSqft;
  String? nameOfBooking;
  String? dateOfRegistration;
  String? registeredNumber;
  String? registeredName;
  String? remark;
  String? townshipName;
  String? plotNo;
  String? plotSize;
  String? bookingDate;
  String? isHot;
  String? bookingAmt;
  String? dob;
  String? aadharCard;
  String? panCard;
  String? registryDate;
  String? residentailAddress;

  Followup(
      {this.id,
        this.customerType,
        this.leadId,
        this.userId,
        this.leadType,
        this.type,
        this.visitNo,
        this.date,
        this.time,
        this.visitors,
        this.caseSummery,
        this.nextFollowupType,
        this.nextFollowupDate,
        this.nextFollowupTime,
        this.nextFollowupNote,
        this.projectId,
        this.insertDate,
        this.priceInSqft,
        this.nameOfBooking,
        this.dateOfRegistration,
        this.registeredNumber,
        this.registeredName,
        this.remark,
        this.townshipName,
        this.plotNo,
        this.plotSize,
        this.bookingDate,
        this.isHot,
        this.bookingAmt,
        this.dob,
        this.aadharCard,
        this.panCard,
        this.registryDate,
        this.residentailAddress});

  Followup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerType = json['customer_type'];
    leadId = json['lead_id'];
    userId = json['user_id'];
    leadType = json['lead_type'];
    type = json['type'];
    visitNo = json['visit_no'];
    date = json['date'];
    time = json['time'];
    visitors = json['visitors'];
    caseSummery = json['case_summery'];
    nextFollowupType = json['next_followup_type'];
    nextFollowupDate = json['next_followup_date'];
    nextFollowupTime = json['next_followup_time'];
    nextFollowupNote = json['next_followup_note'];
    projectId = json['project_id'];
    insertDate = json['insert_date'];
    priceInSqft = json['price_in_sqft'];
    nameOfBooking = json['name_of_booking'];
    dateOfRegistration = json['date_of_registration'];
    registeredNumber = json['registered_number'];
    registeredName = json['registered_name'];
    remark = json['remark'];
    townshipName = json['township_name'];
    plotNo = json['plot_no'];
    plotSize = json['plot_size'];
    bookingDate = json['booking_date'];
    isHot = json['is_hot'];
    bookingAmt = json['booking_amt'];
    dob = json['dob'];
    aadharCard = json['aadhar_card'];
    panCard = json['pan_card'];
    registryDate = json['registry_date'];
    residentailAddress = json['residentail_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_type'] = this.customerType;
    data['lead_id'] = this.leadId;
    data['user_id'] = this.userId;
    data['lead_type'] = this.leadType;
    data['type'] = this.type;
    data['visit_no'] = this.visitNo;
    data['date'] = this.date;
    data['time'] = this.time;
    data['visitors'] = this.visitors;
    data['case_summery'] = this.caseSummery;
    data['next_followup_type'] = this.nextFollowupType;
    data['next_followup_date'] = this.nextFollowupDate;
    data['next_followup_time'] = this.nextFollowupTime;
    data['next_followup_note'] = this.nextFollowupNote;
    data['project_id'] = this.projectId;
    data['insert_date'] = this.insertDate;
    data['price_in_sqft'] = this.priceInSqft;
    data['name_of_booking'] = this.nameOfBooking;
    data['date_of_registration'] = this.dateOfRegistration;
    data['registered_number'] = this.registeredNumber;
    data['registered_name'] = this.registeredName;
    data['remark'] = this.remark;
    data['township_name'] = this.townshipName;
    data['plot_no'] = this.plotNo;
    data['plot_size'] = this.plotSize;
    data['booking_date'] = this.bookingDate;
    data['is_hot'] = this.isHot;
    data['booking_amt'] = this.bookingAmt;
    data['dob'] = this.dob;
    data['aadhar_card'] = this.aadharCard;
    data['pan_card'] = this.panCard;
    data['registry_date'] = this.registryDate;
    data['residentail_address'] = this.residentailAddress;
    return data;
  }
}

class Leads {
  String? id;
  String? bpId;
  String? bmId;
  String? counselorId;
  String? empId;
  String? role;
  String? userId;
  String? leadSource;
  String? userEmpId;
  String? name;
  String? contact1;
  String? contact2;
  String? ocupation;
  String? businessName;
  String? businessAddress;
  String? state;
  String? city;
  String? requirement;
  String? propertyType;
  String? preferedLocation;
  String? location;
  String? budget;
  String? purpose;
  String? propertySize;
  String? scope;
  String? leadQuality;
  String? timeOfCall;
  String? constructionArea;
  String? caseSummary;
  String? bookedProject;
  String? bookedPlotNo;
  String? bookedSize;
  String? bookedAmount;
  String? bookedCheckNo;
  String? plotNo;
  String? plotSize;
  String? bookingDate;
  String? bookingAmt;
  String? dob;
  String? aadharCard;
  String? panCard;
  String? registryDate;
  String? residentailAddress;
  String? townshipName;
  String? remark;
  String? registeredNumber;
  String? dateOfRegistration;
  String? registeredName;
  String? priceInSqft;
  String? nameOfBooking;
  String? date;
  String? time;
  String? type;
  String? nextFollowupDate;
  String? nextFollowupTime;
  String? caseSummery;
  String? status;
  String? created;
  String? updated;
  String? deleteStatus;
  String? isHot;

  Leads(
      {this.id,
        this.bpId,
        this.bmId,
        this.counselorId,
        this.empId,
        this.role,
        this.userId,
        this.leadSource,
        this.userEmpId,
        this.name,
        this.contact1,
        this.contact2,
        this.ocupation,
        this.businessName,
        this.businessAddress,
        this.state,
        this.city,
        this.requirement,
        this.propertyType,
        this.preferedLocation,
        this.location,
        this.budget,
        this.purpose,
        this.propertySize,
        this.scope,
        this.leadQuality,
        this.timeOfCall,
        this.constructionArea,
        this.caseSummary,
        this.bookedProject,
        this.bookedPlotNo,
        this.bookedSize,
        this.bookedAmount,
        this.bookedCheckNo,
        this.plotNo,
        this.plotSize,
        this.bookingDate,
        this.bookingAmt,
        this.dob,
        this.aadharCard,
        this.panCard,
        this.registryDate,
        this.residentailAddress,
        this.townshipName,
        this.remark,
        this.registeredNumber,
        this.dateOfRegistration,
        this.registeredName,
        this.priceInSqft,
        this.nameOfBooking,
        this.date,
        this.time,
        this.type,
        this.nextFollowupDate,
        this.nextFollowupTime,
        this.caseSummery,
        this.status,
        this.created,
        this.updated,
        this.deleteStatus,
        this.isHot});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bpId = json['bp_id'];
    bmId = json['bm_id'];
    counselorId = json['counselor_id'];
    empId = json['emp_id'];
    role = json['role'];
    userId = json['user_id'];
    leadSource = json['lead_source'];
    userEmpId = json['user_emp_id'];
    name = json['name'];
    contact1 = json['contact1'];
    contact2 = json['contact2'];
    ocupation = json['ocupation'];
    businessName = json['business_name'];
    businessAddress = json['business_address'];
    state = json['state'];
    city = json['city'];
    requirement = json['requirement'];
    propertyType = json['property_type'];
    preferedLocation = json['prefered_location'];
    location = json['location'];
    budget = json['budget'];
    purpose = json['purpose'];
    propertySize = json['property_size'];
    scope = json['scope'];
    leadQuality = json['lead_quality'];
    timeOfCall = json['time_of_call'];
    constructionArea = json['construction_area'];
    caseSummary = json['case_summary'];
    bookedProject = json['booked_project'];
    bookedPlotNo = json['booked_plot_no'];
    bookedSize = json['booked_size'];
    bookedAmount = json['booked_amount'];
    bookedCheckNo = json['booked_check_no'];
    plotNo = json['plot_no'];
    plotSize = json['plot_size'];
    bookingDate = json['booking_date'];
    bookingAmt = json['booking_amt'];
    dob = json['dob'];
    aadharCard = json['aadhar_card'];
    panCard = json['pan_card'];
    registryDate = json['registry_date'];
    residentailAddress = json['residentail_address'];
    townshipName = json['township_name'];
    remark = json['remark'];
    registeredNumber = json['registered_number'];
    dateOfRegistration = json['date_of_registration'];
    registeredName = json['registered_name'];
    priceInSqft = json['price_in_sqft'];
    nameOfBooking = json['name_of_booking'];
    date = json['date'];
    time = json['time'];
    type = json['type'];
    nextFollowupDate = json['next_followup_date'];
    nextFollowupTime = json['next_followup_time'];
    caseSummery = json['case_summery'];
    status = json['status'];
    created = json['created'];
    updated = json['updated'];
    deleteStatus = json['delete_status'];
    isHot = json['is_hot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bp_id'] = this.bpId;
    data['bm_id'] = this.bmId;
    data['counselor_id'] = this.counselorId;
    data['emp_id'] = this.empId;
    data['role'] = this.role;
    data['user_id'] = this.userId;
    data['lead_source'] = this.leadSource;
    data['user_emp_id'] = this.userEmpId;
    data['name'] = this.name;
    data['contact1'] = this.contact1;
    data['contact2'] = this.contact2;
    data['ocupation'] = this.ocupation;
    data['business_name'] = this.businessName;
    data['business_address'] = this.businessAddress;
    data['state'] = this.state;
    data['city'] = this.city;
    data['requirement'] = this.requirement;
    data['property_type'] = this.propertyType;
    data['prefered_location'] = this.preferedLocation;
    data['location'] = this.location;
    data['budget'] = this.budget;
    data['purpose'] = this.purpose;
    data['property_size'] = this.propertySize;
    data['scope'] = this.scope;
    data['lead_quality'] = this.leadQuality;
    data['time_of_call'] = this.timeOfCall;
    data['construction_area'] = this.constructionArea;
    data['case_summary'] = this.caseSummary;
    data['booked_project'] = this.bookedProject;
    data['booked_plot_no'] = this.bookedPlotNo;
    data['booked_size'] = this.bookedSize;
    data['booked_amount'] = this.bookedAmount;
    data['booked_check_no'] = this.bookedCheckNo;
    data['plot_no'] = this.plotNo;
    data['plot_size'] = this.plotSize;
    data['booking_date'] = this.bookingDate;
    data['booking_amt'] = this.bookingAmt;
    data['dob'] = this.dob;
    data['aadhar_card'] = this.aadharCard;
    data['pan_card'] = this.panCard;
    data['registry_date'] = this.registryDate;
    data['residentail_address'] = this.residentailAddress;
    data['township_name'] = this.townshipName;
    data['remark'] = this.remark;
    data['registered_number'] = this.registeredNumber;
    data['date_of_registration'] = this.dateOfRegistration;
    data['registered_name'] = this.registeredName;
    data['price_in_sqft'] = this.priceInSqft;
    data['name_of_booking'] = this.nameOfBooking;
    data['date'] = this.date;
    data['time'] = this.time;
    data['type'] = this.type;
    data['next_followup_date'] = this.nextFollowupDate;
    data['next_followup_time'] = this.nextFollowupTime;
    data['case_summery'] = this.caseSummery;
    data['status'] = this.status;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['delete_status'] = this.deleteStatus;
    data['is_hot'] = this.isHot;
    return data;
  }
}
