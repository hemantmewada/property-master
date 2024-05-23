class LeadSourceListModel {
  bool? status;
  List<String>? data;
  String? message;

  LeadSourceListModel({this.status, this.data, this.message});

  LeadSourceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
