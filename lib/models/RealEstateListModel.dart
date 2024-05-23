class RealEstateListModel {
  bool? status;
  Data? data;
  String? message;

  RealEstateListModel({this.status, this.data, this.message});

  RealEstateListModel.fromJson(Map<String, dynamic> json) {
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
  int? recordsTotal;
  int? recordsFiltered;
  List<Listing>? listing;

  Data({this.recordsTotal, this.recordsFiltered, this.listing});

  Data.fromJson(Map<String, dynamic> json) {
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
    if (json['listing'] != null) {
      listing = <Listing>[];
      json['listing'].forEach((v) {
        listing!.add(new Listing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordsTotal'] = this.recordsTotal;
    data['recordsFiltered'] = this.recordsFiltered;
    if (this.listing != null) {
      data['listing'] = this.listing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listing {
  int? no;
  String? id;
  String? name;
  String? type;
  String? contact;
  String? contact2;
  String? date;
  String? leadSources;
  String? locationName;
  String? location;
  String? budget;
  String? isHot;
  String? propertySize;
  LastFollowup? lastFollowup;
  String? townshipName;
  String? plotNo;
  String? plotSize;
  String? bookingAmt;
  String? priceInSqft;
  String? bookingDate;
  String? remark;
  String? registeredName;
  String? registeredNumber;
  String? dateOfRegistration;

  Listing(
      {this.no,
        this.id,
        this.name,
        this.type,
        this.contact,
        this.contact2,
        this.date,
        this.leadSources,
        this.locationName,
        this.location,
        this.budget,
        this.isHot,
        this.propertySize,
        this.lastFollowup,
        this.townshipName,
        this.plotNo,
        this.plotSize,
        this.bookingAmt,
        this.priceInSqft,
        this.bookingDate,
        this.remark,
        this.registeredName,
        this.registeredNumber,
        this.dateOfRegistration});

  Listing.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    contact = json['contact'];
    contact2 = json['contact2'];
    date = json['date'];
    leadSources = json['lead_sources'];
    locationName = json['location_name'];
    location = json['location'];
    budget = json['budget'];
    isHot = json['is_hot'];
    propertySize = json['property_size'];
    lastFollowup = json['last_followup'] != null
        ? new LastFollowup.fromJson(json['last_followup'])
        : null;
    townshipName = json['township_name'];
    plotNo = json['plot_no'];
    plotSize = json['plot_size'];
    bookingAmt = json['booking_amt'];
    priceInSqft = json['price_in_sqft'];
    bookingDate = json['booking_date'];
    remark = json['remark'];
    registeredName = json['registered_name'];
    registeredNumber = json['registered_number'];
    dateOfRegistration = json['date_of_registration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['contact'] = this.contact;
    data['contact2'] = this.contact2;
    data['date'] = this.date;
    data['lead_sources'] = this.leadSources;
    data['location_name'] = this.locationName;
    data['location'] = this.location;
    data['budget'] = this.budget;
    data['is_hot'] = this.isHot;
    data['property_size'] = this.propertySize;
    if (this.lastFollowup != null) {
      data['last_followup'] = this.lastFollowup!.toJson();
    }
    data['township_name'] = this.townshipName;
    data['plot_no'] = this.plotNo;
    data['plot_size'] = this.plotSize;
    data['booking_amt'] = this.bookingAmt;
    data['price_in_sqft'] = this.priceInSqft;
    data['booking_date'] = this.bookingDate;
    data['remark'] = this.remark;
    data['registered_name'] = this.registeredName;
    data['registered_number'] = this.registeredNumber;
    data['date_of_registration'] = this.dateOfRegistration;
    return data;
  }
}

class LastFollowup {
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

  LastFollowup(
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

  LastFollowup.fromJson(Map<String, dynamic> json) {
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
