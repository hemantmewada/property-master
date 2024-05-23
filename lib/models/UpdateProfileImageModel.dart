class UpdateProfileImageModel {
  bool? status;
  UserData? userData;
  String? message;

  UpdateProfileImageModel({this.status, this.userData, this.message});

  UpdateProfileImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['message'] = this.message;
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
