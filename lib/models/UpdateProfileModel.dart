class UpdateProfileModel {
  bool? status;
  Data? data;
  String? message;

  UpdateProfileModel({this.status, this.data, this.message});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? profileImg;

  Data({this.profileImg});

  Data.fromJson(Map<String, dynamic> json) {
    profileImg = json['profile_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_img'] = this.profileImg;
    return data;
  }
}
