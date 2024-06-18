class HomePageDataModel {
  bool? status;
  List<Listing>? listing;
  List<ListingNew>? listingNew;
  UserData? userData;
  int? todayWorkCount;
  int? hotListedCount;
  List<HotListedProperty>? hotListedProperty;
  int? totalCount;
  String? message;

  HomePageDataModel(
      {this.status,
        this.listing,
        this.listingNew,
        this.userData,
        this.todayWorkCount,
        this.hotListedCount,
        this.hotListedProperty,
        this.totalCount,
        this.message});

  HomePageDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['listing'] != null) {
      listing = <Listing>[];
      json['listing'].forEach((v) {
        listing!.add(new Listing.fromJson(v));
      });
    }
    if (json['listing_new'] != null) {
      listingNew = <ListingNew>[];
      json['listing_new'].forEach((v) {
        listingNew!.add(new ListingNew.fromJson(v));
      });
    }
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    todayWorkCount = json['today_work_count'];
    hotListedCount = json['hot_listed_count'];
    if (json['hot_listed_property'] != null) {
      hotListedProperty = <HotListedProperty>[];
      json['hot_listed_property'].forEach((v) {
        hotListedProperty!.add(new HotListedProperty.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.listing != null) {
      data['listing'] = this.listing!.map((v) => v.toJson()).toList();
    }
    if (this.listingNew != null) {
      data['listing_new'] = this.listingNew!.map((v) => v.toJson()).toList();
    }
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['today_work_count'] = this.todayWorkCount;
    data['hot_listed_count'] = this.hotListedCount;
    if (this.hotListedProperty != null) {
      data['hot_listed_property'] =
          this.hotListedProperty!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    data['message'] = this.message;
    return data;
  }
}

class Listing {
  String? id;
  String? propertyTitle;
  String? about;
  String? detail;
  String? location;
  String? images;
  String? image;
  String? insertTime;
  String? status;

  Listing(
      {this.id,
        this.propertyTitle,
        this.about,
        this.detail,
        this.location,
        this.images,
        this.image,
        this.insertTime,
        this.status});

  Listing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyTitle = json['property_title'];
    about = json['about'];
    detail = json['detail'];
    location = json['location'];
    images = json['images'];
    image = json['image'];
    insertTime = json['insert_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_title'] = this.propertyTitle;
    data['about'] = this.about;
    data['detail'] = this.detail;
    data['location'] = this.location;
    data['images'] = this.images;
    data['image'] = this.image;
    data['insert_time'] = this.insertTime;
    data['status'] = this.status;
    return data;
  }
}

class ListingNew {
  String? id;
  String? heading;
  String? userId;
  String? budget;
  String? plotSize;
  String? propertyStatus;
  String? location;
  String? registrationNumber;
  String? singleImage;
  List<String>? multipleImage;
  List<String>? amenities;
  String? loanOffer;
  String? about;
  String? builderName;
  List<String>? certificateUpload;
  String? username;

  ListingNew(
      {this.id,
        this.heading,
        this.userId,
        this.budget,
        this.plotSize,
        this.propertyStatus,
        this.location,
        this.registrationNumber,
        this.singleImage,
        this.multipleImage,
        this.amenities,
        this.loanOffer,
        this.about,
        this.builderName,
        this.certificateUpload,
        this.username});

  ListingNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    userId = json['user_id'];
    budget = json['budget'];
    plotSize = json['plot_size'];
    propertyStatus = json['property_status'];
    location = json['location'];
    registrationNumber = json['registration_number'];
    singleImage = json['single_image'];
    multipleImage = json['multiple_image']?.cast<String>() ?? [];
    amenities = json['amenities']?.cast<String>() ?? [];
    loanOffer = json['loan_offer'];
    about = json['about'];
    builderName = json['builder_name'];
    certificateUpload = json['certificate_upload']?.cast<String>() ?? [];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['heading'] = this.heading;
    data['user_id'] = this.userId;
    data['budget'] = this.budget;
    data['plot_size'] = this.plotSize;
    data['property_status'] = this.propertyStatus;
    data['location'] = this.location;
    data['registration_number'] = this.registrationNumber;
    data['single_image'] = this.singleImage;
    data['multiple_image'] = this.multipleImage;
    data['amenities'] = this.amenities;
    data['loan_offer'] = this.loanOffer;
    data['about'] = this.about;
    data['builder_name'] = this.builderName;
    data['certificate_upload'] = this.certificateUpload;
    data['username'] = this.username;
    return data;
  }
}

class UserData {
  String? profileImg;

  UserData({this.profileImg});

  UserData.fromJson(Map<String, dynamic> json) {
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_img'] = this.profileImg;
    return data;
  }
}

class HotListedProperty {
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

  HotListedProperty(
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

  HotListedProperty.fromJson(Map<String, dynamic> json) {
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
