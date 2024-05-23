class RealEstateModel {
  bool? status;
  Data? data;
  String? message;

  RealEstateModel({this.status, this.data, this.message});

  RealEstateModel.fromJson(Map<String, dynamic> json) {
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
  int? ourlead;
  int? totallead;
  int? todaylead;
  int? todaywork;
  Otherlead? otherlead;
  int? subadmin;
  int? shareholders;
  int? srcounsellor;
  int? counsellor;
  int? srbm;
  int? manager;
  int? srbp;
  int? ftbp;
  int? ptbp;
  int? employee;

  Data(
      {this.ourlead,
        this.totallead,
        this.todaylead,
        this.todaywork,
        this.otherlead,
        this.subadmin,
        this.shareholders,
        this.srcounsellor,
        this.counsellor,
        this.srbm,
        this.manager,
        this.srbp,
        this.ftbp,
        this.ptbp,
        this.employee});

  Data.fromJson(Map<String, dynamic> json) {
    ourlead = json['ourlead'];
    totallead = json['totallead'];
    todaylead = json['todaylead'];
    todaywork = json['todaywork'];
    otherlead = json['otherlead'] != null
        ? new Otherlead.fromJson(json['otherlead'])
        : null;
    subadmin = json['subadmin'];
    shareholders = json['shareholders'];
    srcounsellor = json['srcounsellor'];
    counsellor = json['counsellor'];
    srbm = json['srbm'];
    manager = json['manager'];
    srbp = json['srbp'];
    ftbp = json['ftbp'];
    ptbp = json['ptbp'];
    employee = json['employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ourlead'] = this.ourlead;
    data['totallead'] = this.totallead;
    data['todaylead'] = this.todaylead;
    data['todaywork'] = this.todaywork;
    if (this.otherlead != null) {
      data['otherlead'] = this.otherlead!.toJson();
    }
    data['subadmin'] = this.subadmin;
    data['shareholders'] = this.shareholders;
    data['srcounsellor'] = this.srcounsellor;
    data['counsellor'] = this.counsellor;
    data['srbm'] = this.srbm;
    data['manager'] = this.manager;
    data['srbp'] = this.srbp;
    data['ftbp'] = this.ftbp;
    data['ptbp'] = this.ptbp;
    data['employee'] = this.employee;
    return data;
  }
}

class Otherlead {
  int? hotlisted;
  int? upcomingVisits;
  int? holdBeforeVisit;
  int? rejectBeforeVisit;
  int? visitDone;
  int? booked;
  int? monthlyvisit;
  int? monthlybooked;
  int? hold;
  int? reject;
  int? registered;
  int? skippedfollowup;
  int? pendingleads;
  int? pending;

  Otherlead(
      {this.hotlisted,
        this.upcomingVisits,
        this.holdBeforeVisit,
        this.rejectBeforeVisit,
        this.visitDone,
        this.booked,
        this.monthlyvisit,
        this.monthlybooked,
        this.hold,
        this.reject,
        this.registered,
        this.skippedfollowup,
        this.pendingleads,
        this.pending,
      });

  Otherlead.fromJson(Map<String, dynamic> json) {
    hotlisted = json['hotlisted'];
    upcomingVisits = json['upcomingVisits'];
    holdBeforeVisit = json['holdBeforeVisit'];
    rejectBeforeVisit = json['rejectBeforeVisit'];
    visitDone = json['visitDone'];
    booked = json['booked'];
    monthlyvisit = json['monthlyvisit'];
    monthlybooked = json['monthlybooked'];
    hold = json['hold'];
    reject = json['reject'];
    registered = json['registered'];
    skippedfollowup = json['skippedfollowup'];
    pendingleads = json['pendingleads'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotlisted'] = this.hotlisted;
    data['upcomingVisits'] = this.upcomingVisits;
    data['holdBeforeVisit'] = this.holdBeforeVisit;
    data['rejectBeforeVisit'] = this.rejectBeforeVisit;
    data['visitDone'] = this.visitDone;
    data['booked'] = this.booked;
    data['monthlyvisit'] = this.monthlyvisit;
    data['monthlybooked'] = this.monthlybooked;
    data['hold'] = this.hold;
    data['reject'] = this.reject;
    data['registered'] = this.registered;
    data['skippedfollowup'] = this.skippedfollowup;
    data['pendingleads'] = this.pendingleads;
    data['pending'] = this.pending;
    return data;
  }
}
