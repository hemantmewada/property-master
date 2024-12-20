class GuidlineAndSaudaChitthiModel {
  bool? status;
  String? message;
  Data? data;

  GuidlineAndSaudaChitthiModel({this.status, this.message, this.data});

  GuidlineAndSaudaChitthiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? guildline;
  String? saudaChitthi;

  Data({this.guildline, this.saudaChitthi});

  Data.fromJson(Map<String, dynamic> json) {
    guildline = json['guildline'];
    saudaChitthi = json['sauda-chitthi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guildline'] = this.guildline;
    data['sauda-chitthi'] = this.saudaChitthi;
    return data;
  }
}
