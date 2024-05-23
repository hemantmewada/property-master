class LocationListPostPropertyModel {
  bool? status;
  String? message;
  List<Data>? data;

  LocationListPostPropertyModel({this.status, this.message, this.data});

  LocationListPostPropertyModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? propertyId;
  String? location;
  String? activeStatus;

  Data({this.id, this.propertyId, this.location, this.activeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    location = json['location'];
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['location'] = this.location;
    data['active_status'] = this.activeStatus;
    return data;
  }
}
