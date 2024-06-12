import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/API.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:propertymaster/views/resale-deal/SearchProperty.dart';
import 'package:propertymaster/models/PostPropertyList.dart' as PostPropertyList;
import 'package:url_launcher/url_launcher.dart';

import 'AppStrings.dart';

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
}
void navigateTo(BuildContext context,Widget pageLink, [int duration = 750]){
  Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        alignment: Alignment.topCenter,
        duration: Duration(milliseconds: duration),
        isIos: true,
        child: pageLink,
      )
  );
}
Container propertyContainer(BuildContext context, PostPropertyList.Listing property, String userId){
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed:  () => propertyEnquiryAPI(context, userId, property.id!),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(10.0,),
      title: const Text("Request confirm"),
      content: const Text("Are you sure do you want to request for a call?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
    // margin: const EdgeInsets.only(bottom: 8.0,),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: AppColors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                property.calonyName!,
                style: const TextStyle(fontWeight: FontWeight.w600,),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.propertyId!,
                style: const TextStyle(fontWeight: FontWeight.w600,),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!),
                style: const TextStyle(fontWeight: FontWeight.w600,),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(property.location!,),
            ),
            Expanded(
              flex: 1,
              child: Text(
                formatNumber(property.expectedPrice!),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.typeOfProperty!,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.totalarea == "" ? "" : "${property.width} X ${property.length}",
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    property.transactionType!,
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    property.totalarea == "" ? property.buildupArea! : property.totalarea!,
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    property.facing!,
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    property.possessionStatus!,
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    property.openSide!,
                    style: const TextStyle(color: AppColors.textColorGrey,),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.colorSecondary,
                        width: 1.0,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.transparent,
                  ),
                  child: const Center(child: Text(AppStrings.requestACallback),),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _makePhoneCall("8819888835");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.colorSecondary,
                        width: 1.0,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.colorSecondary,
                  ),
                  child: const Center(
                    child: Text(AppStrings.callNow,style: TextStyle(color: AppColors.white,)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
      ],
    ),
  );
}

String formatNumber(int number) {
  if (number >= 10000000) {
    return '${(number / 10000000).toStringAsFixed(1)} Crore';
  } else if (number >= 100000) {
    return '${(number / 100000).toStringAsFixed(1)} Lakh';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)} Thousand';
  } else {
    return number.toString();
  }
}
PreferredSizeWidget appBarPostPropertyList(BuildContext context, int totalPropertyCount, TextEditingController searchController, final Function(String) onChange){
  return AppBar(
    toolbarHeight: 140.0,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => navigateTo(context, Dashboard(bottomIndex: 0),),
                child: const Icon(Icons.arrow_back,color: AppColors.white,),
              ),
              const SizedBox(width: 10.0,),
              const Text(AppStrings.resaleDeal,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
            ],
          ),
          const SizedBox(height: 20.0,),
          searchContainer(context, totalPropertyCount, searchController, (searchValue) => onChange(searchValue)),
        ],
      ),
    ),
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.colorSecondaryLight,
  );
}
Widget searchContainer(BuildContext context, int totalPropertyCount, TextEditingController searchController, final Function(String) onChange, [bool isHome = false]){
  return Container(
    height: 50.0,
    width: MediaQuery.of(context).size.width * 1,
    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
    decoration: BoxDecoration(
      border: Border.all(
          color: AppColors.colorSecondary,
          width: 1.0,
          style: BorderStyle.solid
      ),
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10.0),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            width: 23.0,
            color: AppColors.colorSecondary,
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            onTap: () {
              if(isHome){
                navigateTo(context, const SearchProperty(), 0);
              }
            },
            readOnly: isHome ? true : false,
            onChanged: (value) => onChange(value),
            controller: searchController,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
            cursorColor: AppColors.textColorGrey,
            decoration: InputDecoration(
              hintText: "${totalPropertyCount > 0 ? totalPropertyCount : ""} ${AppStrings.searchProperties}",
              hintStyle: const TextStyle(
                fontSize: 14.0,
                color: AppColors.textColorGrey,
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

// real estate api
Future<void> _makePhoneCall(String phoneNumber) async {
  print('phoneNumber is ------------------------$phoneNumber');
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Decoration containerDecoration = BoxDecoration(
  border: Border.all(
      color: AppColors.colorSecondary,
      width: 1.0,
      style: BorderStyle.solid
  ),
  borderRadius: BorderRadius.circular(5.0),
  color: Colors.white,
);
InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    isDense: true,
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: 14.0,color: AppColors.textColorGrey,fontWeight: FontWeight.w500,),
    border: InputBorder.none,
  );
}
class KeyValueClass {
  final String value;
  final String name;
  const KeyValueClass({required this.value, required this.name,});
}
class PropertyType {
  final String value;
  final String name;
  final String icon;
  const PropertyType({required this.value, required this.name,required this.icon,});
}