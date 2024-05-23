import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:intl/intl.dart';

class Utilities{

  toast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.colorSecondary,
      textColor: Colors.white,
      // fontSize: 16.0
    );
  }

  static const String xApiKey = 'PROMAST@123';

  String DatefomatToReferDate(String formatGiven, String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.yMMMMd(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToReferDateWithTime(String formatGiven, String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat("MMMM d, y hh:mm a"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToOnlyDate(String formatGiven, String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat("MMMM d, y"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToDateAndTime(String formatGiven, String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat("MMMM d, y hh:mm a"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToOnlyTime(String formatGiven, String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat("hh:mm a"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  // String DatefomatToYmd(String formatGiven, String bigTime) {
  //   // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
  //   DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
  //   // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
  //   var dateFormat = DateFormat.yMd(); // you can change the format here
  //   var utcDate = dateFormat.format(tempDate); // pass the UTC time here
  //   var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
  //   String createdDate = dateFormat.format(DateTime.parse(localDate));
  //   // print("formated date is------------$createdDate");
  //   return createdDate;
  // }
  // String DatefomatToReferDateTime(String bigTime) {
  //   DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
  //   // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
  //   var dateFormat = DateFormat.Hm(); // you can change the format here
  //   var utcDate = dateFormat.format(tempDate); // pass the UTC time here
  //   var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
  //   String createdDate = dateFormat.format(DateTime.parse(localDate));
  //   // print("formated date is------------$createdDate");
  //   return createdDate;
  // }
  String DatefomatToMonth(String formatGiven, String bigTime) {
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.M(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToYear(String formatGiven, String bigTime) {
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.y(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToDate(String formatGiven, String bigTime) {
    DateTime tempDate = DateFormat(formatGiven).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.d(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  // String DatefomatToTime24(String bigTime) {
  //   DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
  //   // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
  //   var dateFormat = DateFormat.Hm(); // you can change the format here
  //   var utcDate = dateFormat.format(tempDate); // pass the UTC time here
  //   var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
  //   String createdDate = dateFormat.format(DateTime.parse(localDate));
  //   // print("formated date is------------$createdDate");
  //   return createdDate;
  // }
  String DatefomatToTime12HoursFormat(String formatGive, String bigTime) {
    DateTime tempDate = DateFormat(formatGive).parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.jm(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  void navigateTo(BuildContext context,Widget pageLink){
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 750),
          isIos: true,
          child: pageLink,
        )
    );
  }
}