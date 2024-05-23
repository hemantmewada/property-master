// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/LeadSourceListModel.dart';
import 'package:propertymaster/models/addLeadModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propertymaster/models/locationListModel.dart';
import 'package:dio/dio.dart';
// apis

class BusinessPartnerRegistration extends StatefulWidget {
  String userID;
  String role;
  List<String> jobTypeList;
  BusinessPartnerRegistration({super.key,required this.userID,required this.role,required this.jobTypeList});

  @override
  State<BusinessPartnerRegistration> createState() => _BusinessPartnerRegistrationState();
}
const List<String> occupationList = <String>[
  'Select Occupation',
  'Self Employed',
  'Professional',
];
class _BusinessPartnerRegistrationState extends State<BusinessPartnerRegistration> {
  var searchController = TextEditingController();
  var fullNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var businessNameController = TextEditingController();
  var natureOfWorkController = TextEditingController();
  var emailController = TextEditingController();
  var pincodeController = TextEditingController();
  var panCardNoController = TextEditingController();
  var aadharCardNoController = TextEditingController();
  String occupation = occupationList.first;
  String jobType = "Select Job Type";
  String budgetSellTitle = AppStrings.budgetInLakh;
  List<String> leadSourceList = [];
  RegExp regExpPAN = new RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  RegExp regExpAadhar = new RegExp("[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}");

  String selectedState = "Madhya Pradesh";
  String selectedCity = "Indore";
  List<String> cities = ["Indore", "Bhopal", "Ujjain", "Khandwa", "Ratlam", "Dewas", "Jabalpur", "Rewa", "Gwalior", "Khargone"];
  Map<String, List<String>> cityData = {
    "Madhya Pradesh": ["Indore", "Bhopal", "Ujjain", "Khandwa", "Ratlam", "Dewas", "Jabalpur", "Rewa", "Gwalior", "Khargone"],
    "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi", "Prayagraj", "Noida", "Agra", "Ghaziabad", "Aligarh", "Meerut", "Mathura", "Jhansi", "Goprakhpur"],
    "Maharashtra": ["Mumbai", "Pune", "New Bombay", "Nasik", "Nagpur", "Thane"],
    "Gujarat": ["Surat", "Ahamdabad", "Vadodara", "Rajkot", "Jamnagar", "Gandhinagar"],
    "Rajsthan": ["Jaipur", "Kota", "Jodhpur", "Bikaner"],
    "Punjab": ["Chandigarh", "Mohali", "Ludhiana", "Amritsar", "Patiala", "Jalandhar"],
    "Delhi": ["Gurgaon", "Faridabad", "New Delhi", "Greater Noida", "NCR"],
    "Bihar": ["Patna", "Nalanda", "Mujjaffarpur	"],
    "Chhattisgarh": ["Raipur", "Raigarh", "Bhilai", "Bilaspur"],
    "Haryana": ["Karnal", "Panchkula", "Gurgaon", "Faridabad", "Panipat", "Sonipat", "Ambala"],
    "West Bengal": ["Kolkata", "Siliguri","Asansol","Durgapur","Bardhman"],
    "Karnataka": ["Bengaluru","Mysore"],
    "Tamilnadu": ["Chennai","Coimbatore","Madurai"],
    "Goa": ["Panaji"],
    "Odisa": ["Bhubaneswar","Cuttack","Brahmapur"],
    "Himanchal Pradesh": ["Shimala","Dharamasala","Mandi","Manali"],
    "Uttarakhand": ["Nainital","Haridwar","Dehradoon","Rishikesh","Mussoorie","Haldwani"],
    "Aandhra Pradesh": ["Visakhapatnam","Vijayawada","Tirupati"],
    "Assam": ["Guwahati","Dibrugarh","Jorhat"],
    "Jammu Kashmir": ["Jammu","Shrinagar","Pahalgam","Anantnag"],
    "Kerala": ["Kozhikode","Thiruvananthapuram","Kochi","Kannur"],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      // print("widget.userID------------ ${widget.userID}");
      // print("widget.role------------ ${widget.role}");
      // print("widget.jobTypeList------------ ${widget.jobTypeList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset('assets/icons/back2.svg',color: AppColors.white,width: 25.0,height: 25.0,),
                  ),
                  const SizedBox(width: 10.0,),
                  const Text(AppStrings.businessPartnerRegistration,style: TextStyle(fontSize: 20.0,color: AppColors.white,overflow: TextOverflow.ellipsis),),
                ],
              ),
              const SizedBox(height: 20.0,),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorSecondaryLight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // full name row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
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
                      child: TextFormField(
                        autofocus: false,
                        controller: fullNameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: AppStrings.fullName,
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
              const SizedBox(height: 15.0,),
              // contact 1 & 2 row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
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
                      child: TextFormField(
                        controller: contact1Controller,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        // maxLength: 10,
                        decoration: const InputDecoration(
                          // counterText: "",
                          isDense: true,
                          hintText: AppStrings.contact1,
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
                      child: TextFormField(
                        controller: contact2Controller,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        // maxLength: 10,
                        decoration: const InputDecoration(
                          // counterText: "",
                          isDense: true,
                          hintText: AppStrings.contact2,
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
              const SizedBox(height: 15.0,),
              // address row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
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
                      child: TextFormField(
                        controller: addressController,
                        textCapitalization: TextCapitalization.words,
                        maxLines: 2,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: AppStrings.residentialAddress,
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
              const SizedBox(height: 15.0,),
              // occupation and nature of work
              Row(
                children: [
                  // occupation
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.occupation),
                        const SizedBox(height: 5.0,),
                        Container(
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
                          child: OccupationListDropdown(
                            title: occupation,
                            onChange: (newValue){
                              setState((){
                                occupation = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  // nature of work
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.natureOfWork),
                        const SizedBox(height: 5.0,),
                        Container(
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
                          child: TextFormField(
                            controller: natureOfWorkController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            // maxLength: 10,
                            decoration: const InputDecoration(
                              // counterText: "",
                              isDense: true,
                              hintText: AppStrings.natureOfWork,
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
                ],
              ),
              const SizedBox(height: 15.0,),
              // business name
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 35.0,
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
                      child: TextFormField(
                        controller: businessNameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: AppStrings.businessName,
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
              const SizedBox(height: 15.0,),
              // email & pin code
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
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
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        // maxLength: 10,
                        decoration: const InputDecoration(
                          // counterText: "",
                          isDense: true,
                          hintText: AppStrings.email,
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
                      child: TextFormField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          counterText: "",
                          isDense: true,
                          hintText: AppStrings.pincode,
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
              const SizedBox(height: 15.0,),
              // state city row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.state),
                        const SizedBox(height: 5.0,),
                        Container(
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
                          child: DropdownButton<String>(
                            isDense: true,
                            padding: const EdgeInsets.symmetric(vertical: 5.0,),
                            isExpanded: true,
                            style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
                            elevation: 16,
                            underline: Container(color: AppColors.transparent,),
                            value: selectedState,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedState = newValue!;
                                cities = cityData[newValue]!;
                                selectedCity = cities.first;
                              });
                            },
                            items: cityData.keys.map((String state) {
                              return DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
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
                        const Text(AppStrings.city),
                        const SizedBox(height: 5.0,),
                        Container(
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
                          child: DropdownButton<String>(
                            isDense: true,
                            padding: const EdgeInsets.symmetric(vertical: 5.0,),
                            isExpanded: true,
                            style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
                            elevation: 16,
                            underline: Container(color: AppColors.transparent,),
                            value: selectedCity,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue!;
                              });
                            },
                            items: cities.map((String city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              // pan card number & aadhar card number
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
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
                      child: TextFormField(
                        controller: panCardNoController,
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: "",
                          isDense: true,
                          hintText: AppStrings.panCardNo,
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
                      child: TextFormField(
                        controller: aadharCardNoController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        maxLength: 14,
                        onChanged: (value){
                          setState((){
                            aadharCardNoController.text = _formatAadharNumber(value);
                          });
                        },
                        decoration: const InputDecoration(
                          counterText: "",
                          isDense: true,
                          hintText: AppStrings.aadharCardNo,
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
              const SizedBox(height: 15.0,),
              // job type
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.jobType),
                        const SizedBox(height: 5.0,),
                        Container(
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
                          child: JobTypeListDropdown(
                            list: widget.jobTypeList,
                            title: jobType,
                            onChange: (newValue){
                              setState((){
                                jobType = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              InkWell(
                onTap: () {
                  String fullName = fullNameController.text;
                  String contact1 = contact1Controller.text;
                  String businessName = businessNameController.text;
                  String natureOfWork = natureOfWorkController.text;
                  String email = emailController.text;
                  String contact2 = contact2Controller.text;
                  String address = addressController.text;
                  String pincode = pincodeController.text;
                  String pan = panCardNoController.text;
                  String aadhar = aadharCardNoController.text;
                  if(fullName.isEmpty){
                    Utilities().toast(AppStrings.fullNameToast);
                  }else if(contact1.isEmpty){
                    Utilities().toast(AppStrings.contact1Toast);
                  }else if(contact1.length < 10 || contact1.length > 10){
                    Utilities().toast(AppStrings.contact1ValidToast);
                  }else if(occupation == "Select Occupation"){
                    Utilities().toast(AppStrings.occupationToast);
                  }else if(businessName.isEmpty){
                    Utilities().toast(AppStrings.businessNameToast);
                  }else if(natureOfWork.isEmpty){
                    Utilities().toast(AppStrings.natureOfWorkToast);
                  }else if(email.isEmpty){
                    Utilities().toast(AppStrings.natureOfWorkToast);
                  }else if(!email.contains("@gmail.com")){
                    Utilities().toast(AppStrings.emailValidToast);
                  }else if(pincode.isEmpty){
                    Utilities().toast(AppStrings.pincodeToast);
                  }else if(pincode.length < 6 || pincode.length > 6){
                    Utilities().toast(AppStrings.pincodeValidToast);
                  }else if(pan.isEmpty){
                    Utilities().toast(AppStrings.panCardNoToast);
                  }else if(!regExpPAN.hasMatch(pan)){
                    Utilities().toast(AppStrings.panCardNoValidToast);
                  }else if(aadhar.isEmpty){
                    Utilities().toast(AppStrings.aadharCardNoToast);
                  }else if(!regExpAadhar.hasMatch(aadhar)){
                    Utilities().toast(AppStrings.aadharCardNoValidToast);
                  }else if(jobType == "" || jobType == "Select Job Type"){
                    Utilities().toast(AppStrings.jobTypeToast);
                  }else{
                    addBusinessPartnerAPI(context, fullName, contact1, contact2, address,businessName,natureOfWork,email, pincode, pan, aadhar);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20.0,),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Text(
                    AppStrings.submit,
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
  String _formatAadharNumber(String value) {
    value = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    if (value.length > 4) {
      value = value.substring(0, 4) + ' ' + value.substring(4);
    }
    if (value.length > 9) {
      value = value.substring(0, 9) + ' ' + value.substring(9);
    }
    return value;
  }

  // addBusinessPartnerAPI
  Future<void> addBusinessPartnerAPI(BuildContext context,String fullName,String contact1,String contact2,String address,String businessName, String natureOfWork, String email,String pincode, String pan, String aadhar) async {
    Loader.ProgressloadingDialog(context, true);
    const url = Urls.createBusinessPartnerUrl;
    if(jobType == "Sr Business Partner"){
      jobType = "Business Partner";
    }
    // print("fullName--------- $fullName");
    // print("contact1--------- $contact1");
    // print("contact2--------- $contact2");
    // print("address--------- $address");
    // print("occupation--------- $occupation");
    // print("businessName--------- $businessName");
    // print("natureOfWork--------- $natureOfWork");
    // print("email--------- ${email}");
    // print("pincode--------- ${pincode}");
    // print("selectedState--------- ${selectedState}");
    // print("selectedCity--------- ${selectedCity}");
    // print("pan--------- ${pan}");
    // print("aadhar--------- ${aadhar}");
    // print("jobType--------- ${jobType}");
    try {
      var formData = FormData.fromMap({
        "name" :fullName,
        "mobile" :contact1,
        "alternate_mobile":contact2,
        "current_address":address,
        "occupation" :occupation,
        "business_name" :businessName,
        "work_nature" :natureOfWork,
        "email" :email,
        "pin_code" :pincode,
        "city" :selectedCity,
        "state" :selectedState,
        "aadhar_no" :aadhar,
        "pan_no" :pan,
        "role" :jobType,
        "user_id" :widget.userID,
      });

      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        // Navigator.of(context).pop();
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        addLeadModel response = addLeadModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 750),
              isIos: true,
              child: Dashboard(bottomIndex: 0),
            ),
                (route) => false,
          );
          setState(() {});
        }
      }

    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
}

class OccupationListDropdown extends StatefulWidget {
  String title;
  final Function(String) onChange; // Callback function
  OccupationListDropdown({super.key,required this.title,required this.onChange,});

  @override
  State<OccupationListDropdown> createState() => _OccupationListDropdownState();
}
class _OccupationListDropdownState extends State<OccupationListDropdown> {
  String dropdownValue = occupationList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      elevation: 16,
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: occupationList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class JobTypeListDropdown extends StatefulWidget {
  String title;
  final Function(String) onChange; // Callback function
  List<String> list;
  JobTypeListDropdown({super.key,required this.title,required this.onChange,required this.list,});

  @override
  State<JobTypeListDropdown> createState() => _JobTypeListDropdownState();
}
class _JobTypeListDropdownState extends State<JobTypeListDropdown> {
  String dropdownValue = "Select Job Type";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      elevation: 16,
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}