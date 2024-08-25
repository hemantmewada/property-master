import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/utilities/API.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:propertymaster/views/resale-deal/SearchProperty.dart';
import 'package:propertymaster/models/PostPropertyList.dart' as PostPropertyList;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


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

List<String> list = ['Select Status','Sold By Owner','Sold From Any Other Sources','Plan Changed','Any Other Reason'];

Container propertyContainer(BuildContext context, PostPropertyList.Listing property, String userId, String role, String propertyType, [bool isMine = false]){
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
  String reason = "";
  showAlertDialogForMyProperty(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed:  () {
        if(reason.isEmpty){
          Utilities().toast(AppStrings.reasonToast);
          return;
        }else{
          switchSoldAPI(context, property.id!, reason);
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10.0,),
              title: const Text("Plot for other"),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text("Select Reason",style: TextStyle(fontSize: 16.0,),),
                    const SizedBox(height: 5.0,),
                    Container(
                      height: 40.0,
                      margin: const EdgeInsets.only(bottom: 10.0,),
                      width: MediaQuery.of(context).size.width * 1,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid,),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButtonExample(
                              reason: reason,
                              onChange: (newValue){
                                // print("newValue-----$newValue");
                                setState((){
                                  if(newValue == "Select Status"){
                                    reason = "";
                                  }else{
                                    reason = newValue;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [cancelButton,continueButton,],
            );
          }
        );
      },
    );
  }
  String message1 = "*Project Name:* ${property.calonyName!}\n"
      "*Property ID:* ${property.propertyId!}\n"
      "*Property Date:* ${Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!)}\n"
      "*Location:* ${property.location!}\n"
      // "*Price:* ₹ ${formatNumber(property.expectedPrice!)}\n"
      "*Property Type:* ${property.typeOfProperty!}\n"
      "*Buildup Area:* ${property.buildupArea!}\n"
      "*Transaction Type:* ${property.transactionType!}\n"
      "*Facing:* ${property.facing!}\n"
      "*Possession Status:* ${property.possessionStatus!}\n"
      "*Plot No.:* ${property.numberId!}\n"
      "*Price/SqFt:* ${property.pricePerSquare!}\n"
      "*Open Side:* ${property.openSide!}";
  // print(message1);

  String message2 = "*Project Name:* ${property.calonyName!}\n"
      "*Property ID:* ${property.propertyId!}\n"
      "*Property Date:* ${Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!)}\n"
      "*Location:* ${property.location!}\n"
      // "*Price:* ₹ ${formatNumber(property.expectedPrice!)}\n"
      "*Property Type:* ${property.typeOfProperty!}\n"
      "*Total Area:* ${property.totalarea!}\n"
      "*Dimension:* ${property.width} X ${property.length}\n"
      "*Transaction Type:* ${property.transactionType!}\n"
      "*Facing:* ${property.facing!}\n"
      "*Possession Status:* ${property.possessionStatus!}\n"
      "*Plot No.:* ${property.numberId!}\n"
      "*Price/SqFt:* ${property.pricePerSquare!}\n"
      "*Open Side:* ${property.openSide!}";
  // print(message2);
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: propertyType == "sold-property" ? Colors.red[400] : propertyType == "my-property" ? Colors.green[600] : AppColors.white,
      // image: property.propertyStatus == "Complete Post" ? const DecorationImage(
      //   scale: 5.0,
      //   image: AssetImage("assets/images/verified-bg.png"),
      //   alignment: Alignment.center,
      //   opacity: 0.5,
      // ) : null,
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
              // child: Wrap(
              //   children: [
              //     Text(property.calonyName!,style: const TextStyle(fontWeight: FontWeight.w600,),),
              //     if(property.propertyStatus == "Complete Post")
              //       Padding(padding: const EdgeInsets.only(left: 5.0,),child: Image.asset("assets/icons/verified.png",width: 20.0,),),
              //   ],
              // ),
              child:
              property.statusComplete == "1" ?
              Text(property.calonyName!,style: TextStyle(fontWeight: FontWeight.w600,color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),) :
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: property.calonyName!,style: TextStyle(fontWeight: FontWeight.w600,color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black,fontFamily: "Poppins"),),
                      WidgetSpan(child: Padding(padding: const EdgeInsets.only(left: 2.0,),child: Image.asset("assets/icons/verified.png",width: 20.0,),),),
                    ]
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.propertyId!,
                style: TextStyle(fontWeight: FontWeight.w600,color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!),
                style: TextStyle(fontWeight: FontWeight.w600,color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
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
              child: Text(property.location!, style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "₹ ${formatNumber(property.expectedPrice!)}",
                textAlign: TextAlign.center,
                style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${property.pricePerSquare!}/SqFt",
                textAlign: TextAlign.end,
                style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                role == "Sr Business Manager" || role == "Manager" ? property.numberId! : "",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.totalarea == "" ? "" : "${property.width} X ${property.length}",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.totalarea == "" ? property.buildupArea! : "${property.totalarea!} Sqft",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
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
              child: Text(
                property.transactionType!,
                style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.facing!,
                style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.openSide!,
                style: TextStyle(color: propertyType == "sold-property" || propertyType == "my-property" ? AppColors.white : AppColors.black),
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
              child: Text(
                property.typeOfProperty!,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.possessionStatus!,
                textAlign: TextAlign.end,
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
                onTap: () => showAlertDialog(context),
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
                  child: const Center(child: Text(AppStrings.callback,style: TextStyle(color: AppColors.white,),),),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if(property.totalarea == ""){
                    sendMessage(message1);
                  }else{
                    sendMessage(message2);
                  }
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share, size: 16.0, color: AppColors.white,),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        const Text(AppStrings.share,style: TextStyle(color: AppColors.white,),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if(isMine){
                    showAlertDialogForMyProperty(context);
                  }else{
                    _makePhoneCall("8819888835");
                  }
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
                  child: Center(
                    child: Text(isMine ? AppStrings.sold : AppStrings.callNow,style: const TextStyle(color: AppColors.white,),),
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

Container propertyContainerHotListed(BuildContext context, HotListedProperty property, String userId, String role){
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
  String message1 = "*Project Name:* ${property.calonyName!}\n"
      "*Property ID:* ${property.propertyId!}\n"
      "*Property Date:* ${Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!)}\n"
      "*Location:* ${property.location!}\n"
      // "*Price:* ₹ ${formatNumber(property.expectedPrice!)}\n"
      "*Property Type:* ${property.typeOfProperty!}\n"
      "*Buildup Area:* ${property.buildupArea!}\n"
      "*Transaction Type:* ${property.transactionType!}\n"
      "*Facing:* ${property.facing!}\n"
      "*Possession Status:* ${property.possessionStatus!}\n"
      "${role == "Sr Business Manager" || role == "Manager" ? "*Plot No.:* ${property.numberId!}\n" : "" }"
      "*Price/SqFt:* ${property.pricePerSquare!}\n"
      "*Open Side:* ${property.openSide!}";
  // print(message1);

  String message2 = "*Project Name:* ${property.calonyName!}\n"
      "*Property ID:* ${property.propertyId!}\n"
      "*Property Date:* ${Utilities().DatefomatToOnlyDate("yyyy-MM-dd",property.insertDate!)}\n"
      "*Location:* ${property.location!}\n"
      // "*Price:* ₹ ${formatNumber(property.expectedPrice!)}\n"
      "*Property Type:* ${property.typeOfProperty!}\n"
      "*Total Area:* ${property.totalarea!}\n"
      "*Dimension:* ${property.width} X ${property.length}\n"
      "*Transaction Type:* ${property.transactionType!}\n"
      "*Facing:* ${property.facing!}\n"
      "*Possession Status:* ${property.possessionStatus!}\n"
      "${role == "Sr Business Manager" || role == "Manager" ? "*Plot No.:* ${property.numberId!}\n" : "" }"
      "*Price/SqFt:* ${property.pricePerSquare!}\n"
      "*Open Side:* ${property.openSide!}";
  // print(message2);
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              // child: Wrap(
              //   children: [
              //     Text(property.calonyName!,style: const TextStyle(fontWeight: FontWeight.w600,),),
              //     if(property.propertyStatus == "Complete Post")
              //       Padding(padding: const EdgeInsets.only(left: 5.0,),child: Image.asset("assets/icons/verified.png",width: 20.0,),),
              //   ],
              // ),
              child:
              property.statusComplete == "1" ?
              Text(property.calonyName!,style: const TextStyle(fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,),) :
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: property.calonyName!,style: const TextStyle(fontWeight: FontWeight.w600,color: AppColors.black,fontFamily: "Poppins",),),
                      WidgetSpan(child: Padding(padding: const EdgeInsets.only(left: 2.0,),child: Image.asset("assets/icons/verified.png",width: 20.0,),),),
                    ]
                ),
                // overflow: TextOverflow.ellipsis,
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
                "₹ ${formatNumber(property.expectedPrice!)}",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "${property.pricePerSquare!}/SqFt",
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
              child: Text(
                role == "Sr Business Manager" || role == "Manager" ? property.numberId! : "",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.totalarea == "" ? "" : "${property.width} X ${property.length}",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.totalarea == "" ? property.buildupArea! : "${property.totalarea!} Sqft",
                style: const TextStyle(color: AppColors.colorSecondaryDark,),
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
              child: Text(
                property.transactionType!,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.facing!,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.openSide!,
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
              child: Text(
                property.typeOfProperty!,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                property.possessionStatus!,
                textAlign: TextAlign.end,
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
                onTap: () => showAlertDialog(context),
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
                  child: const Center(child: Text(AppStrings.callback,style: TextStyle(color: AppColors.white,),),),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  if(property.totalarea == ""){
                    sendMessage(message1);
                  }else{
                    sendMessage(message2);
                  }
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.share, size: 16.0, color: AppColors.white,),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                        const Text(AppStrings.share,style: TextStyle(color: AppColors.white,),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => _makePhoneCall("8819888835"),
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

Future<void> sendMessage(String message) async {
  // await launch("https://wa.me/${phoneNumber}?text=Hello");
  String appUrl;
  if (Platform.isAndroid) {
    appUrl = "whatsapp://send?text=${Uri.encodeComponent(message)}";
  } else {
    appUrl = "https://api.whatsapp.com/send?text=${Uri.encodeComponent(message)}";
  }

  // if (await launch(appUrl)) {
  await launch(appUrl);
  // } else {
  //   throw 'Could not launch $appUrl';
  // }
}

String formatNumber(int number) {
  if (number >= 10000000) {
    return '${(number / 10000000).toStringAsFixed(2)} Crore';
  } else if (number >= 100000) {
    return '${(number / 100000).toStringAsFixed(2)} Lakh';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(2)} Thousand';
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
class SliderClass {
  final String name;
  final String image;
  const SliderClass({required this.name,required this.image,});
}
class PropertyType {
  final String value;
  final String name;
  final String icon;
  const PropertyType({required this.value, required this.name,required this.icon,});
}
const videoUrl = "http://m.propertymaster.co.in/video/";
const aboutUsUrl = "https://m.propertymaster.co.in/about-us/";
const facebookUrl = "https://www.facebook.com/PropertyMasterIndore";
const instagramUrl = "https://www.instagram.com/property_master_indore_";
const linkedinUrl = "https://www.linkedin.com/company/property-master-official";
const youtubeUrl = "https://www.youtube.com/@propertymaster6063/featured";

class DropdownButtonExample extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  DropdownButtonExample({super.key,required this.reason,required this.onChange});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}
class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      elevation: 16,
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
