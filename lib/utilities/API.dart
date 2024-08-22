import 'package:flutter/material.dart';
import 'package:propertymaster/models/PropertyEnquiryModel.dart';
import 'package:propertymaster/models/SwitchSoldModel.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:dio/dio.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/resale-deal/ResaleDealDashboard.dart';

Future<void> propertyEnquiryAPI(BuildContext context, String userId, String propertyId) async {
  const url = Urls.propertyEnquiryUrl;
  try {
    Loader.ProgressloadingDialog(context, true);
    var formData = FormData.fromMap({"user_id" :  userId, "property_id" :  propertyId});
    final responseDio = await Dio().post(url,data: formData,);
    Loader.ProgressloadingDialog(context, false);
    if (responseDio.statusCode == 200) {
      print(url);
      Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
      PropertyEnquiryModel response = PropertyEnquiryModel.fromJson(map);
      if (response.status == true) {
        Utilities().toast(response.message);
      }
      Navigator.of(context).pop();
    }
  } catch (e) {
    Utilities().toast('error: $e');
  }
  return;
}

Future<void> switchSoldAPI(BuildContext context, String propertyId, String reason) async {
  const url = Urls.switchSoldUrl;
  try {
    Loader.ProgressloadingDialog(context, true);
    var formData = FormData.fromMap({"property_id" :  propertyId, "property_status" :  "plot for other", 'reason': reason});
    print(formData.fields);
    final responseDio = await Dio().post(url,data: formData,);
    Loader.ProgressloadingDialog(context, false);
    if (responseDio.statusCode == 200) {
      print(url);
      Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
      SwitchSoldModel response = SwitchSoldModel.fromJson(map);
      if (response.status == true) {
        Utilities().toast(response.message);
      }
      Navigator.of(context).pop();
      navigateTo(context, ResaleDealDashboard(bottomIndex: 1,), 0);
    }
  } catch (e) {
    Utilities().toast('error: $e');
  }
  return;
}
