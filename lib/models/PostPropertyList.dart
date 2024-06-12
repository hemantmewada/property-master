class PostPropertyList {
  bool? status;
  Data? data;
  String? message;

  PostPropertyList({this.status, this.data, this.message});

  PostPropertyList.fromJson(Map<String, dynamic> json) {
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
  int? recordsFiltered;
  List<Listing>? listing;

  Data({this.recordsFiltered, this.listing});

  Data.fromJson(Map<String, dynamic> json) {
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
    data['recordsFiltered'] = this.recordsFiltered;
    if (this.listing != null) {
      data['listing'] = this.listing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listing {
  String? id;
  String? propertyId;
  String? associativeType;
  String? associativeName;
  String? associativeContact;
  String? numberId;
  String? calonyName;
  String? location;
  String? type;
  String? typeOfProperty;
  String? propertyType;
  String? propertyStatus;
  String? width;
  String? length;
  String? totalarea;
  String? facing;
  String? openSide;
  String? transactionType;
  String? netPricePerSquare;
  String? pricePerSquare;
  String? possessionStatus;
  String? descriptionDetails;
  String? address;
  String? numberOfFloor;
  String? plotAreaSqft;
  String? flatSize;
  String? floorNo;
  String? constructionAreaSqft;
  String? superBildupArea;
  String? yourSpaceInWhichFloor;
  String? furnishedStatus;
  String? aminities;
  int? expectedPrice;
  String? insertDate;
  String? status;
  String? buildupArea;
  String? empId;
  String? empCode;
  String? homeType;
  String? empName;
  String? soldBy;
  String? sellingRate;
  String? sellingDate;
  String? cilentName;
  String? cilentContact;
  String? verified;
  String? brokerName;
  String? brokerContact;
  String? soldEmployeeName;
  String? soldEmployeeId;
  String? soldUpdateDate;
  String? deleteStatus;
  String? statusDescription;
  String? statusDate;
  String? updatedAt;

  Listing(
      {this.id,
        this.propertyId,
        this.associativeType,
        this.associativeName,
        this.associativeContact,
        this.numberId,
        this.calonyName,
        this.location,
        this.type,
        this.typeOfProperty,
        this.propertyType,
        this.propertyStatus,
        this.width,
        this.length,
        this.totalarea,
        this.facing,
        this.openSide,
        this.transactionType,
        this.netPricePerSquare,
        this.pricePerSquare,
        this.possessionStatus,
        this.descriptionDetails,
        this.address,
        this.numberOfFloor,
        this.plotAreaSqft,
        this.flatSize,
        this.floorNo,
        this.constructionAreaSqft,
        this.superBildupArea,
        this.yourSpaceInWhichFloor,
        this.furnishedStatus,
        this.aminities,
        this.expectedPrice,
        this.insertDate,
        this.status,
        this.buildupArea,
        this.empId,
        this.empCode,
        this.homeType,
        this.empName,
        this.soldBy,
        this.sellingRate,
        this.sellingDate,
        this.cilentName,
        this.cilentContact,
        this.verified,
        this.brokerName,
        this.brokerContact,
        this.soldEmployeeName,
        this.soldEmployeeId,
        this.soldUpdateDate,
        this.deleteStatus,
        this.statusDescription,
        this.statusDate,
        this.updatedAt});

  Listing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    associativeType = json['associative_type'];
    associativeName = json['associative_name'];
    associativeContact = json['associative_contact'];
    numberId = json['number_id'];
    calonyName = json['calony_name'];
    location = json['location'];
    type = json['type'];
    typeOfProperty = json['type_of_property'];
    propertyType = json['property_type'];
    propertyStatus = json['property_status'];
    width = json['width'];
    length = json['length'];
    totalarea = json['totalarea'];
    facing = json['facing'];
    openSide = json['open_side'];
    transactionType = json['transaction_type'];
    netPricePerSquare = json['net_price_per_square'];
    pricePerSquare = json['price_per_square'];
    possessionStatus = json['possession_status'];
    descriptionDetails = json['description_details'];
    address = json['address'];
    numberOfFloor = json['number_of_floor'];
    plotAreaSqft = json['plot_area_sqft'];
    flatSize = json['flat_size'];
    floorNo = json['floor_no'];
    constructionAreaSqft = json['construction_area_sqft'];
    superBildupArea = json['super_bildup_area'];
    yourSpaceInWhichFloor = json['your_space_in_which_floor'];
    furnishedStatus = json['furnished_status'];
    aminities = json['aminities'];
    expectedPrice = json['expected_price'];
    insertDate = json['insert_date'];
    status = json['status'];
    buildupArea = json['buildup_area'];
    empId = json['emp_id'];
    empCode = json['emp_code'];
    homeType = json['home_type'];
    empName = json['emp_name'];
    soldBy = json['sold_by'];
    sellingRate = json['selling_rate'];
    sellingDate = json['selling_date'];
    cilentName = json['cilent_name'];
    cilentContact = json['cilent_contact'];
    verified = json['verified'];
    brokerName = json['broker_name'];
    brokerContact = json['broker_contact'];
    soldEmployeeName = json['sold_employee_name'];
    soldEmployeeId = json['sold_employee_id'];
    soldUpdateDate = json['sold_update_date'];
    deleteStatus = json['delete_status'];
    statusDescription = json['status_description'];
    statusDate = json['status_date'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['associative_type'] = this.associativeType;
    data['associative_name'] = this.associativeName;
    data['associative_contact'] = this.associativeContact;
    data['number_id'] = this.numberId;
    data['calony_name'] = this.calonyName;
    data['location'] = this.location;
    data['type'] = this.type;
    data['type_of_property'] = this.typeOfProperty;
    data['property_type'] = this.propertyType;
    data['property_status'] = this.propertyStatus;
    data['width'] = this.width;
    data['length'] = this.length;
    data['totalarea'] = this.totalarea;
    data['facing'] = this.facing;
    data['open_side'] = this.openSide;
    data['transaction_type'] = this.transactionType;
    data['net_price_per_square'] = this.netPricePerSquare;
    data['price_per_square'] = this.pricePerSquare;
    data['possession_status'] = this.possessionStatus;
    data['description_details'] = this.descriptionDetails;
    data['address'] = this.address;
    data['number_of_floor'] = this.numberOfFloor;
    data['plot_area_sqft'] = this.plotAreaSqft;
    data['flat_size'] = this.flatSize;
    data['floor_no'] = this.floorNo;
    data['construction_area_sqft'] = this.constructionAreaSqft;
    data['super_bildup_area'] = this.superBildupArea;
    data['your_space_in_which_floor'] = this.yourSpaceInWhichFloor;
    data['furnished_status'] = this.furnishedStatus;
    data['aminities'] = this.aminities;
    data['expected_price'] = this.expectedPrice;
    data['insert_date'] = this.insertDate;
    data['status'] = this.status;
    data['buildup_area'] = this.buildupArea;
    data['emp_id'] = this.empId;
    data['emp_code'] = this.empCode;
    data['home_type'] = this.homeType;
    data['emp_name'] = this.empName;
    data['sold_by'] = this.soldBy;
    data['selling_rate'] = this.sellingRate;
    data['selling_date'] = this.sellingDate;
    data['cilent_name'] = this.cilentName;
    data['cilent_contact'] = this.cilentContact;
    data['verified'] = this.verified;
    data['broker_name'] = this.brokerName;
    data['broker_contact'] = this.brokerContact;
    data['sold_employee_name'] = this.soldEmployeeName;
    data['sold_employee_id'] = this.soldEmployeeId;
    data['sold_update_date'] = this.soldUpdateDate;
    data['delete_status'] = this.deleteStatus;
    data['status_description'] = this.statusDescription;
    data['status_date'] = this.statusDate;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
