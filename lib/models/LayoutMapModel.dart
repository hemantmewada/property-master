class LayoutMapModel {
  bool? status;
  List<Data>? data;
  String? message;

  LayoutMapModel({this.status, this.data, this.message});

  LayoutMapModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? image;
  String? projectName;

  Data({this.image, this.projectName});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['project_name'] = this.projectName;
    return data;
  }
}
