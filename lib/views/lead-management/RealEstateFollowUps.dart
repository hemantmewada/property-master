import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/models/AddContactModel.dart';
import 'package:propertymaster/models/addFollowupModel.dart';
import 'package:propertymaster/models/followupModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:url_launcher/url_launcher.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class RealEstateFollowUps extends StatefulWidget {
  String userID;
  String? page;
  String? leadId;
  String? name;
  String? contact;
  String? date;
  String? locationName;
  String? leadSource;
  String? budget;
  String? leadSources;
  String? contact2;
  String? location;
  String? id;
  String? lastFollowup;
  RealEstateFollowUps({super.key,required this.userID,required this.leadId,required this.name,required this.date,required this.budget, required this.locationName, required this.contact,required this.leadSource,required this.page, required this.leadSources,required this.contact2, required this.location, required this.id,this.lastFollowup});

  @override
  State<RealEstateFollowUps> createState() => _RealEstateFollowUpsState();
}
List<String> list = [];

class _RealEstateFollowUpsState extends State<RealEstateFollowUps> {
  String loggedInUserId = '';
  var reasonController = TextEditingController();
  var remarkController = TextEditingController();
  var plotNoController = TextEditingController();
  var plotSizeController = TextEditingController();
  var bookingAmountController = TextEditingController();
  var nameOfBookingController = TextEditingController();
  var townshipColonyController = TextEditingController();
  var registeredNumberController = TextEditingController();
  var phoneNumberController = TextEditingController();
  String reasonPlaceholder = "";
  DateTime selectedDate = DateTime.now();
  DateTime selectedBookingDate = DateTime.now();
  DateTime selectedDateOfRegistration = DateTime.now();
  DateTime selectedDOBDate = DateTime.now();
  List<Followup>? followupList = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  String lastFollowupType = '';

  Future<void> _selectBookingDate(BuildContext context, {required Null Function(dynamic newValue) onChange4}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedBookingDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 20)), // prev 20 years
        lastDate: DateTime.now().add(const Duration(days: 365 * 200)), // Add 200 years
    );
    if (picked != null && picked != selectedBookingDate) {
      setState(() {
        selectedBookingDate = picked;
        onChange4(picked);
      });
    }
  }
  Future<void> _selectDateOfRegistration(BuildContext context, {required Null Function(dynamic newValue) onChange6}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateOfRegistration,
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 200)), // Substract 200 years
        lastDate: DateTime.now().add(const Duration(days: 365 * 200)), // Add 200 years
    );
    if (picked != null && picked != selectedDateOfRegistration) {
      setState(() {
        selectedDateOfRegistration = picked;
        onChange6(picked);
      });
    }
  }
  Future<void> _selectDOBDate(BuildContext context, {required Null Function(dynamic newValue) onChange5}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDOBDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 200)), // Substract 200 years
        lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDOBDate) {
      setState(() {
        selectedDOBDate = picked;
        onChange5(picked);
      });
    }
  }
  Future<void> _selectTime(BuildContext context, {required Null Function(dynamic newValue) onChange3}) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );});
    if (picked_s != null && picked_s != selectedTime ) {
      setState(() {
        selectedTime = picked_s;
        onChange3(picked_s);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedInUserId = prefs.getString("userID") ?? '';
    print("loggedInUserId --------$loggedInUserId");
    print("widget.userID --------${widget.userID}");
    print("widget.page --------${widget.page}");
    print("widget.lastFollowup --------${widget.lastFollowup}");
    addListAccordingToCondition();
    followUpAPI(context,true);
    setState(() {});
  }
  addListAccordingToCondition(){
    list.clear();
    if(widget.page == 'totalleads' || widget.page == 'totaltodayleads' || widget.page == 'totalhotlisted'){
      List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
      list.addAll(leadslist);
    }else if(widget.page == 'totaltodaywork'){
      if(widget.lastFollowup == "Reject before visit") {
        List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Hold'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Hot listed"){
        List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Upcoming visit"){
        List<String> leadslist = ['Select Status','Call','Visit done','Hold before visit','Reject before visit'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Hold before visit"){
        List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Reject before visit'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Reject before visit"){
        List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Hold'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Visit done"){
        List<String> leadslist = ['Select Status','Call','Booked','Hold','Reject'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Booked"){
        List<String> leadslist = ['Select Status','Call','Registered','Hold','Reject'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Hold" || widget.lastFollowup == "Reject"){
        List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
        list.addAll(leadslist);
      }else if(widget.lastFollowup == "Registered"){
        List<String> leadslist = ['Select Status','Call'];
        list.addAll(leadslist);
      }else {
        List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
        list.addAll(leadslist);
      }
    }else if(widget.page == 'totalupcomingvisits'){
      List<String> leadslist = ['Select Status','Call','Visit done','Hold before visit','Reject before visit'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalholdbeforevisit'){
      List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Reject before visit'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalrejectbeforevisit'){
      List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Hold'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalvisitdone'){
      List<String> leadslist = ['Select Status','Call','Booked','Hold','Reject'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalbooked'){
      List<String> leadslist = ['Select Status','Call','Registered','Hold','Reject'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalhold' || widget.page == 'totalreject'){
      List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
      list.addAll(leadslist);
    }else if(widget.page == 'totalregistered'){
      List<String> leadslist = ['Select Status','Call'];
      list.addAll(leadslist);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.realEstateFollowUps,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              // margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
              margin: const EdgeInsets.only(bottom: 8.0,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.name!,
                          style: const TextStyle(fontSize: 16.0,),
                        ),
                      ),
                      Row(
                        children: [
                          Text(widget.contact!),
                          const SizedBox(width: 5.0,),
                          InkWell(
                            onTap: () => _makePhoneCall(widget.contact!),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5.0,),
                              child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              sendMessage('+91${widget.contact!}','Hi, How can i help you.');
                            },
                            child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                          ),
                        ],
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
                        child: Text(widget.leadSources == null ? "" : widget.leadSources!),
                      ),
                      (widget.contact2 == null || widget.contact2!.isEmpty || widget.contact2 == '0' || widget.contact2 == "0")
                          ? InkWell(
                              onTap: () => addContactNumberModal(widget.id),
                              child: SvgPicture.asset('assets/icons/phone-plus.svg',color: AppColors.green,height: 24.0,width: 24.0,),
                            )
                          : Row(
                              children: [
                                Text(widget.contact2!),
                                const SizedBox(width: 5.0,),
                                InkWell(
                                  onTap: () => _makePhoneCall(widget.contact2!),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5.0,),
                                    child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    sendMessage('+91${widget.contact2!}','Hi, How can i help you.');
                                  },
                                  child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                                ),
                              ],
                            ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.locationName == null ? "" : widget.locationName!,
                          style: const TextStyle(fontSize: 16.0,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.location == null ? "" : widget.location!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 16.0,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w600),
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
                        child: Text(
                          widget.budget == null ? "" : widget.budget!,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Utilities().DatefomatToReferDate("dd-MM-yyyy hh:mm a",widget.date!),
                            ),
                            Text(
                              Utilities().DatefomatToTime12HoursFormat("MM-dd-yyyy hh:mm a",widget.date!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: followupList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (followupList != null && followupList!.isNotEmpty) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(bottom: 10.0,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                followupList![index].type == null ? "" : followupList![index].type == "" ? "Call" : followupList![index].type!,
                                style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                Utilities().DatefomatToReferDateWithTime("yyyy-MM-dd HH:mm:ss",followupList![index].insertDate!),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        if (followupList![index].type == 'Booked') Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (followupList![index].nameOfBooking == null)
                                    ? Container()
                                    : Text("Name Of Booking : ${followupList![index].nameOfBooking!}"),
                                (followupList![index].nameOfBooking == null)
                                    ? Container()
                                    : const SizedBox(height: 5.0,),
                                // Text( followupList![index].dob == null ? "Date Of Birth : " : "Date Of Birth : ${followupList![index].dob!}",),
                                Text( followupList![index].dob != "0000-00-00" ? "Date Of Birth : ${followupList![index].dob!}" : "Date Of Birth : NA",),
                                const SizedBox(height: 5.0,),
                                Text(followupList![index].townshipName == null ? "Project/Colony Name : " : "Project/Colony Name : ${followupList![index].townshipName!}",),
                                const SizedBox(height: 5.0,),
                                Text(followupList![index].plotSize == null ? "Plot No. : " : "Plot No. : ${followupList![index].plotNo!}",),
                                const SizedBox(height: 5.0,),
                                Text(followupList![index].plotSize == null ? "Plot Size. : " : "Plot Size. : ${followupList![index].plotSize!}",),
                                const SizedBox(height: 5.0,),
                                Text( followupList![index].bookingAmt == null ? "Booking Amount : " : "Booking Amount : ${followupList![index].bookingAmt!}",),
                                const SizedBox(height: 5.0,),
                                Text( followupList![index].bookingDate != "0000-00-00" ? "Booking Date : ${followupList![index].bookingDate!}" : "Booking Date : ",),
                                const SizedBox(height: 5.0,),
                                Text( followupList![index].remark == null ? "Booking Remark : " : "Booking Remark : ${followupList![index].remark!}",),
                                const SizedBox(height: 5.0,),
                              ],
                        ) else if (followupList![index].type == 'Registered') Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(followupList![index].registeredName == null ? "Registered Name : " : "Registered Name : ${followupList![index].registeredName!}",),
                              const SizedBox(height: 5.0,),
                              Text(followupList![index].registeredNumber == null ? "Registered Number : " : "Registered Number : ${followupList![index].registeredNumber!}",),
                              const SizedBox(height: 5.0,),
                              Text(followupList![index].dateOfRegistration == null ? "Date of Registration : " : "Date of Registration : ${followupList![index].dateOfRegistration!}",),
                              const SizedBox(height: 5.0,),
                              Text(followupList![index].remark == null ? "Registered Remark : " : "Registered Remark : ${followupList![index].remark!}",),
                              const SizedBox(height: 5.0,),
                            ],
                        ) else Container(),
                        if(followupList![index].type != 'Booked' && followupList![index].type != 'Registered')
                        // Text("Summary : ${followupList![index].caseSummery!}",) else Container(),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Summary : ',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xE0000000),
                                ),
                              ),
                              TextSpan(
                                text: followupList![index].caseSummery!,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xE0000000),
                                ),
                              ),
                            ],
                          ),
                        ) else Container(),
                        const SizedBox(height: 5.0,),
                      ],
                    ),
                );
                }else{
                  return Container();
                }
              },
            ),
            const SizedBox(height: 10.0,),
            widget.userID == loggedInUserId && widget.page != 'all'
                ? InkWell(
                    onTap: () => addFollowUpModal(reasonPlaceholder, selectedDate,selectedDate, selectedTime, selectedBookingDate, selectedDateOfRegistration),
                    // onTap: () => print(selectedDate),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondary,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,color: AppColors.white),
                          SizedBox(width: 10.0),
                          Text(
                            AppStrings.addFollowUp,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
  // addFollowUp API start
  Future<void> addFollowUpAPI(BuildContext context, String type,String reason, DateTime? date, TimeOfDay? time, DateTime? bookingDate, DateTime? dob, String plotNo, String plotSize, String bookingAmount, String townshipColony, String remark, DateTime? dateOfRegistration, String registeredNumber, String registeredNameTextValues, String nameOfBooking) async {
    String onlyDate = "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}";
    String? onlyBookingDate;
    if(bookingDate != null){
      onlyBookingDate = "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}";
    }else{
      onlyBookingDate = "";
    }
    String? onlyDob;
    if(dob != null){
      onlyDob = "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}";
    }else{
      onlyDob = "";
    }
    String? onlyDateOfRegistration;
    if(dateOfRegistration != null){
      onlyDateOfRegistration = "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}";
    }else{
      onlyDateOfRegistration = "";
    }
    String onlyTime = "${time!.hour}:${time!.minute}:00";
    if(type != "Registered"){
      onlyDateOfRegistration = '';
    }
    if(type == "Booked" || type == "Registered"){
      onlyDate = '';
      onlyTime = '';
    }
    if(type == "Call"){
      if(lastFollowupType == '' || lastFollowupType == null || lastFollowupType == 'null'){
        lastFollowupType = type;
        type = '';
        // print(lastFollowupType);
        // return;
      }else{
        lastFollowupType = lastFollowupType;
      }
    }else{
      lastFollowupType = type;
    }
    // print(type);
    // print(lastFollowupType);
    // return;
    Loader.ProgressloadingDialog(context, true);
    try {

      const url = Urls.addFollowupUrl;
      var formData = FormData.fromMap({
          'user_id': widget.userID,
          'lead_id': widget.leadId!,
          'next_followup_time': onlyTime,
          'next_followup_date': onlyDate,
          'case_summery': reason,
          'type': type,
          'lead_type': lastFollowupType,
          'plot_no': plotNo,
          'plot_size': plotSize,
          'booking_amt': bookingAmount,
          'name_of_booking': nameOfBooking,
          'booking_date': onlyBookingDate,
          'dob':onlyDob,
          'township_name': townshipColony,
          'remark': remark,
          'registered_number': registeredNumber,
          'date_of_registration': onlyDateOfRegistration,
          'registered_name': registeredNameTextValues,
      });
      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(Urls.addFollowupUrl);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        AddFollowupModel response = AddFollowupModel.fromJson(map);

        Utilities().toast(response.message);
        if(response.status == true){
          Navigator.of(context).pop();
          reasonController.clear();
          plotNoController.clear();
          plotSizeController.clear();
          bookingAmountController.clear();
          followUpAPI(context,false);
          setState(() {});
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  // addFollowUp API end
  // followUp API start
  Future<void> followUpAPI(BuildContext context, bool isLoad) async {
    if(isLoad){
      Loader.ProgressloadingDialog(context, true);
    }
    try {
      const url = Urls.followupListUrl;
      var formData = FormData.fromMap({
        "lead_id" : widget.leadId!,
      });
      final responseDio = await Dio().post(url,data: formData,);

      if(isLoad){
        Loader.ProgressloadingDialog(context, false);
      }
      if (responseDio.statusCode == 200) {
        print(Urls.followupListUrl);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        FollowupListModel response = FollowupListModel.fromJson(map);

        if(response.status == true){
          followupList!.clear();
          followupList = response.data!.followup!;
          lastFollowupType = response.data!.leads!.type.toString();
          setState(() {});
        }else{
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // followUp API end
  // addFollowUp Modal start
  Future addFollowUpModal(String str, DateTime? date, DateTime firstDate, TimeOfDay? time, DateTime? bookingDate, DateTime? dateOfRegistration) {
    print(widget.page);
    print(widget.lastFollowup);
    if(widget.page == 'totaltodaywork'){
      String? lastFollowup = "";
      String? secondLastFollowup = "";
      for (var i = 0; i < followupList!.length; i++) {
        lastFollowup = followupList![followupList!.length - 1].type;
        secondLastFollowup = followupList!.length > 2 ? followupList![followupList!.length - 2].type : "";
      }
      if(lastFollowup == "Call" || lastFollowup == "Hot listed"){
        if(secondLastFollowup == "Reject before visit") {
          list.clear();
          List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Hold'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Hot listed"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Upcoming visit"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Visit done','Hold before visit','Reject before visit'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Hold before visit"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Reject before visit'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Reject before visit"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Upcoming visit','Visit done','Hold'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Visit done"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Booked','Hold','Reject'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Booked"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Registered','Hold','Reject'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Hold" || secondLastFollowup == "Reject"){
          list.clear();
          List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
          list.addAll(leadslist);
        }else if(secondLastFollowup == "Registered"){
          list.clear();
          List<String> leadslist = ['Select Status','Call'];
          list.addAll(leadslist);
        }else {
          list.clear();
          List<String> leadslist = ['Select Status','Call','Hot listed','Upcoming visit','Hold before visit','Reject before visit'];
          list.addAll(leadslist);
        }
      }
    }
    String updatedReasonPlaceholder = str; // Create a local variable to hold updated value
    DateTime? dob;
    List<TextEditingController> registeredNameController = [TextEditingController()];
    DateTime updatedFirstDate = firstDate;
    Future<void> _selectDate(BuildContext context, {required Null Function(dynamic newValue) onChange2}) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: updatedFirstDate,
        lastDate: DateTime.now().add(const Duration(days: 365 * 200)), // Add 200 years
      );
      if (picked != null && picked != updatedFirstDate) {
        setState(() {
          updatedFirstDate = picked;
          onChange2(picked);
        });
      }
    }
    return showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState){
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10.0),
              contentPadding: const EdgeInsets.all(20.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      margin: const EdgeInsets.only(bottom: 10.0,),
                      width: MediaQuery.of(context).size.width * 1,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.colorSecondary,
                            width: 1.0,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        // color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButtonExample(
                              reason: str,
                              onChange: (newValue){
                                setState((){
                                  if(newValue == "Select Status"){
                                    updatedReasonPlaceholder = "";
                                  }else{
                                    updatedReasonPlaceholder = newValue;
                                  }
                                  if(newValue == "Reject before visit" || newValue == "Reject"){
                                    updatedFirstDate = DateTime.now().subtract(const Duration(days: 365 * 20)); // prev 20 years
                                  }else{
                                    updatedFirstDate = DateTime.now();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    updatedReasonPlaceholder != "Booked" && updatedReasonPlaceholder != "Registered"
                        ? Column(
                          children: [
                            Container(
                              // height: 50.0,
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.colorSecondary,
                                    width: 1.0,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                // color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      controller: reasonController,
                                      maxLines: 2,
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        fontSize: 14.0, color: AppColors.black,
                                      ),
                                      cursorColor: AppColors.textColorGrey,
                                      decoration: InputDecoration(
                                        hintText: '$updatedReasonPlaceholder ${AppStrings.reason}',
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
                            ),
                            const SizedBox(height: 10.0,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(AppStrings.nextFollowUpDate),
                                      const SizedBox(height: 5.0,),
                                      Container(
                                        height: 37.0,
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.colorSecondary,
                                              width: 1.0,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _selectDate(
                                              context,
                                              onChange2: (newValue){
                                                setState((){
                                                  date = newValue;
                                                });
                                              },
                                            );
                                          },
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              date == null ? AppStrings.date : "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",date!.toLocal().toString())}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10.0,),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(AppStrings.nextFollowUpTime),
                                      const SizedBox(height: 5.0,),
                                      Container(
                                        height: 37.0,
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.colorSecondary,
                                              width: 1.0,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _selectTime(
                                              context,
                                              onChange3: (newValue){
                                                setState((){
                                                  time = newValue;
                                                });
                                              },
                                            );
                                          },
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              time == null ? AppStrings.time : "${time!.hour}:${time!.minute}:00",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0,),
                          ],
                        )
                        : Container(),
                    // other form fields
                    updatedReasonPlaceholder == 'Booked'
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.nameOfBooking),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          // height: 37.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: TextFormField(
                                            controller: nameOfBookingController,
                                            keyboardType: TextInputType.name,
                                            style: const TextStyle(
                                              fontSize: 14.0, color: AppColors.black,
                                            ),
                                            cursorColor: AppColors.textColorGrey,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              hintText: AppStrings.nameOfBooking,
                                              hintStyle: TextStyle(
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
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.dob),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          height: 40.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              _selectDOBDate(
                                                context,
                                                onChange5: (newValue){
                                                  setState((){
                                                    dob = newValue;
                                                  });
                                                },
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                dob == null ? AppStrings.selectDOB : "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",dob!.toLocal().toString())}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                // height: 40.0,
                                margin: const EdgeInsets.only(bottom: 10.0,),
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.colorSecondary,
                                      width: 1.0,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  // color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: townshipColonyController,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontSize: 14.0, color: AppColors.black,
                                        ),
                                        cursorColor: AppColors.textColorGrey,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: AppStrings.townshipColonyName,
                                          hintStyle: TextStyle(
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
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      // height: 37.0,
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorSecondary,
                                            width: 1.0,
                                            style: BorderStyle.solid
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        controller: plotNoController,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontSize: 14.0, color: AppColors.black,
                                        ),
                                        cursorColor: AppColors.textColorGrey,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: AppStrings.plotNo,
                                          hintStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColors.textColorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      // height: 37.0,
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.colorSecondary,
                                            width: 1.0,
                                            style: BorderStyle.solid
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        controller: plotSizeController,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontSize: 14.0, color: AppColors.black,
                                        ),
                                        cursorColor: AppColors.textColorGrey,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          hintText: AppStrings.plotSize,
                                          hintStyle: TextStyle(
                                            fontSize: 14.0,
                                            color: AppColors.textColorGrey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.bookingAmount),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          // height: 37.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: TextFormField(
                                            controller: bookingAmountController,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                              fontSize: 14.0, color: AppColors.black,
                                            ),
                                            cursorColor: AppColors.textColorGrey,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              hintText: AppStrings.bookingAmount,
                                              hintStyle: TextStyle(
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
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.bookingDate),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          height: 40.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              _selectBookingDate(
                                                context,
                                                onChange4: (newValue){
                                                  setState((){
                                                    bookingDate = newValue;
                                                  });
                                                },
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                bookingDate == null ? AppStrings.bookingDate : "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",bookingDate!.toLocal().toString())}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                            ],
                          )
                        : Container(),
                    // other form fields
                    // only for registered form
                    updatedReasonPlaceholder == 'Registered'
                        ? Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: registeredNameController.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // height: 40.0,
                                            margin: const EdgeInsets.only(bottom: 10.0,),
                                            width: MediaQuery.of(context).size.width * 1,
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.colorSecondary,
                                                  width: 1.0,
                                                  style: BorderStyle.solid
                                              ),
                                              borderRadius: BorderRadius.circular(5.0),
                                              // color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: TextFormField(
                                                    controller: registeredNameController[index],
                                                    keyboardType: TextInputType.text,
                                                    style: const TextStyle(
                                                      fontSize: 14.0, color: AppColors.black,
                                                    ),
                                                    cursorColor: AppColors.textColorGrey,
                                                    decoration: const InputDecoration(
                                                      isDense: true,
                                                      hintText: AppStrings.registeredName,
                                                      hintStyle: TextStyle(
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
                                          ),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        index != 0
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    registeredNameController[index].clear();
                                                    registeredNameController[index].dispose();
                                                    registeredNameController.removeAt(index);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: AppColors.colorSecondary,
                                                  size: 40,
                                                ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 5.0,),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    registeredNameController.add(TextEditingController());
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.colorSecondary,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Text(
                                      AppStrings.addMore,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.registeredNumber),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          // height: 37.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: TextFormField(
                                            controller: registeredNumberController,
                                            keyboardType: TextInputType.text,
                                            textCapitalization: TextCapitalization.characters,
                                            style: const TextStyle(
                                              fontSize: 14.0, color: AppColors.black,
                                            ),
                                            cursorColor: AppColors.textColorGrey,
                                            decoration: const InputDecoration(
                                              isDense: true,
                                              hintText: AppStrings.registeredNumber,
                                              hintStyle: TextStyle(
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
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(AppStrings.dateOfRegistration),
                                        const SizedBox(height: 5.0,),
                                        Container(
                                          height: 40.0,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorSecondary,
                                                width: 1.0,
                                                style: BorderStyle.solid
                                            ),
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              _selectDateOfRegistration(
                                                context,
                                                onChange6: (newValue){
                                                  setState((){
                                                    dateOfRegistration = newValue;
                                                  });
                                                },
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                dateOfRegistration == null ? AppStrings.dateOfRegistration : "${Utilities().DatefomatToYear("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}-${Utilities().DatefomatToMonth("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}-${Utilities().DatefomatToDate("yyyy-MM-dd' 'HH:mm:ss",dateOfRegistration!.toLocal().toString())}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                            ],
                          )
                        : Container(),
                    updatedReasonPlaceholder == "Booked" || updatedReasonPlaceholder == "Registered"
                        ? Column(
                            children: [
                              Container(
                                // height: 50.0,
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.colorSecondary,
                                      width: 1.0,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  // color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        controller: remarkController,
                                        maxLines: 2,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontSize: 14.0, color: AppColors.black,
                                        ),
                                        cursorColor: AppColors.textColorGrey,
                                        decoration: InputDecoration(
                                          hintText: '$updatedReasonPlaceholder ${AppStrings.remark}',
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
                              ),
                              const SizedBox(height: 10.0,),
                            ],
                          )
                        : Container(),
                    InkWell(
                      onTap: () {
                        String reason = reasonController.text;
                        String plotNo = plotNoController.text;
                        String plotSize = plotSizeController.text;
                        String bookingAmount = bookingAmountController.text;
                        String townshipColony = townshipColonyController.text;
                        String remark = remarkController.text;
                        String registeredNumber = registeredNumberController.text;
                        String registeredNameTextValues = '';
                        String nameOfBooking = nameOfBookingController.text;
                        if(updatedReasonPlaceholder.isEmpty || updatedReasonPlaceholder == "Select Status") {
                          Utilities().toast(AppStrings.statusToast);
                        }else{
                          if(updatedReasonPlaceholder == "Booked"){
                            if(townshipColony.isEmpty){
                              Utilities().toast(AppStrings.townshipColonyToast);
                            }else if(plotNo.isEmpty){
                              Utilities().toast(AppStrings.plotNoToast);
                            }else if(plotSize.isEmpty){
                              Utilities().toast(AppStrings.plotSizeToast);
                            }else if(bookingAmount.isEmpty){
                              Utilities().toast(AppStrings.bookingAmountToast);
                            }else if(nameOfBooking.isEmpty){
                              Utilities().toast(AppStrings.nameOfBookingToast);
                            } else if(bookingDate == null){
                              Utilities().toast(AppStrings.bookingDate);
                            // } else if(dob == null){
                            //   Utilities().toast(AppStrings.dobToast);
                            } else if(remark.isEmpty){
                              Utilities().toast(AppStrings.remarkToast);
                            }else{
                              addFollowUpAPI(context, updatedReasonPlaceholder, reason, date, time, bookingDate, dob, plotNo, plotSize, bookingAmount, townshipColony, remark, dateOfRegistration, registeredNumber, registeredNameTextValues, nameOfBooking);
                            }
                          }else if(updatedReasonPlaceholder == "Registered"){

                            // only for registered names
                            bool anyEmpty = false;
                            for (TextEditingController controller in registeredNameController) {
                              if (controller.text.isEmpty) {
                                anyEmpty = true;
                                break;
                              }
                            }
                            // only for registered names

                            if(registeredNumber.isEmpty){
                              Utilities().toast(AppStrings.registeredNumberToast);
                            }else if(anyEmpty){
                              Utilities().toast(AppStrings.registeredNameToast);
                            } else if(remark.isEmpty){
                              Utilities().toast(AppStrings.remarkToast);
                            }else{
                              registeredNameTextValues = registeredNameController.map((controller) => controller.text).join(', ');
                              addFollowUpAPI(context, updatedReasonPlaceholder, reason, date, time, bookingDate, dob, plotNo, plotSize, bookingAmount, townshipColony, remark, dateOfRegistration, registeredNumber, registeredNameTextValues, nameOfBooking);
                            }

                          } else if(reason.isEmpty){
                            Utilities().toast(AppStrings.reasonToast);
                          } else if(date == null){
                            Utilities().toast(AppStrings.dateToast);
                          } else if(time == null){
                            Utilities().toast(AppStrings.timeToast);
                          }else{
                            addFollowUpAPI(context, updatedReasonPlaceholder, reason, date, time, bookingDate, dob, plotNo, plotSize, bookingAmount, townshipColony, remark, dateOfRegistration, registeredNumber, registeredNameTextValues, nameOfBooking);
                          }
                        }
                      },
                      child: Container(
                        height: 50.0,
                        margin: const EdgeInsets.only(top: 10.0,),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: const BoxDecoration(
                          color: AppColors.colorSecondary,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.addFollowUp,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }
  // addFollowUp Modal end
  Future<void> _makePhoneCall(String phoneNumber) async {
    print('phoneNumber is ------------------------$phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> sendMessage(String phoneNumber,String message) async {
    String appUrl;
    if (Platform.isAndroid) {
      appUrl = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
    } else {
      appUrl = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.parse(message)}";
    }

    // if (await launch(appUrl)) {
      await launch(appUrl);
    // } else {
    //   throw 'Could not launch $appUrl';
    // }
  }
  // addContactNumberModal dialog
  Future addContactNumberModal(String? leadId) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0,),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          height: 220.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.addContactNumber,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset('assets/icons/cross.svg',width: 20.0,),
                  )
                ],
              ),
              Container(
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
                        'assets/icons/phone.svg',
                        width: 23.0,
                        color: AppColors.colorSecondary,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 14.0, color: AppColors.black,
                        ),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          hintText: AppStrings.addContactNumber,
                          hintStyle: TextStyle(
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
              ),
              InkWell(
                onTap: () {
                  String phone = phoneNumberController.text;
                  if(phone.isEmpty){
                    Utilities().toast(AppStrings.phoneToast);
                  }else if(phone.length < 10 || phone.length > 10) {
                    Utilities().toast(AppStrings.phoneValidToast);
                  }else{
                    addContactAPI(context,leadId);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  //height: MediaQuery.of(context).size.height * 0.06,
                  height: 50.0,
                  // width: 343.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Text(
                    AppStrings.add,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // addContactNumberModal dialog
  // real estate api
  Future<void> addContactAPI(BuildContext context, String? leadId) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.addContact2Url;
      var formData = FormData.fromMap({
        "lead_id" :  leadId!,
        "contact" :  phoneNumberController.text,
      });
      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      Navigator.of(context).pop();
      if (responseDio.statusCode == 200) {
        print(Urls.addContact2Url);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        AddContactModel response = AddContactModel.fromJson(map);

        if(response.status == true) {
          Utilities().toast(response.message);
          setState(() {});
        }else{
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  // real estate api
}
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
