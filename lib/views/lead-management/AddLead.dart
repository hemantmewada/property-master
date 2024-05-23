// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/LeadSourceListModel.dart';
import 'package:propertymaster/models/MobileNoExistModel.dart';
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

class AddLead extends StatefulWidget {
  const AddLead({super.key});

  @override
  State<AddLead> createState() => _AddLeadState();
}
const List<String> requiredPropertyList = <String>[
  'Residential Plots',
  'Commercial Plots',
  'Flats',
  'Ready Duplex',
  'Row House',
  'P plus C',
  'Commercial Office',
  'Commercial Shop',
  'Indestrial Plots',
  'Form House',
  'Agriculture Land',
  'SNW Villas Omkareshwar',
];
const List<String> budgetList = <String>[
  '15 to 20 Lakh',
  '20 to 30 Lakh',
  '30 to 40 Lakh',
  '40 to 50 Lakh ',
  '50 to 60 Lakh',
  '60 to 70 Lakh',
  '70 to 85 Lakh',
  '85 Lakh to 1 cr',
  '2 cr',
  '3 cr',
  '4 cr',
  '5 cr',
  '10 cr and above',
];
const List<String> locationList = <String>[
  'Tricon City',
  'Info City',
  'The Grand Virasat',
  'Singapur Gold City 1',
  'White Pearl',
  'Parshvanath',
];

String leadSource = "";
class _AddLeadState extends State<AddLead> {
  var searchController = TextEditingController();
  var fullNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController(text: "Indore");
  var projectNameController = TextEditingController();
  var sizeController = TextEditingController();
  var locationNameController = TextEditingController();
  String requirement = AppStrings.buy;
  String requiredProperty = requiredPropertyList.first;
  String location = locationList.first;
  String locationStr = '1';
  String budget = budgetList.first;
  String budgetSellTitle = AppStrings.budgetInLakh;
  late String userID;
  late String role;
  List<Data> locationList2 = [];
  List<String> leadSourceList = [];
  bool isLoading = false;

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
      allProcess();
    });
  }

  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("userID") ?? '';
    role = prefs.getString("role") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    locationListAPI(context);
    leadSourceListAPI(context);
    setState(() {});
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
                  const Text(AppStrings.realEstateEnquiry,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
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
                      height: 39.0,
                      child: TextFormField(
                        onChanged: (value) {
                          if(value.length == 10){
                            mobileNoExistAPI(context,value);
                          }
                        },
                        controller: contact1Controller,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        // maxLength: 10,
                        decoration: InputDecoration(
                          // counterText: "",
                          isDense: true,
                          hintText: AppStrings.contact1,
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          suffixIcon: isLoading ? Image.asset('assets/icons/spinner.gif',width: 32.0,) : null,
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
                              print(newValue);
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
              // buy sell row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.requirement),
                        const SizedBox(height: 5.0,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0,),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    requirement = AppStrings.buy;
                                    budgetSellTitle = AppStrings.budgetInLakh;
                                  });
                                },
                                child: Row(
                                  children: [
                                    requirement == AppStrings.buy ?
                                    SvgPicture.asset('assets/icons/selected.svg',width: 16.0,) :
                                    SvgPicture.asset('assets/icons/unselected.svg',width: 16.0,),
                                    const SizedBox(width: 5.0),
                                    const Text(
                                      "Buy",
                                      style: TextStyle(color: AppColors.black,),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10.0,),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    requirement = AppStrings.sell;
                                    budgetSellTitle = AppStrings.sellAmount;
                                  });
                                },
                                child: Row(
                                  children: [
                                    requirement == AppStrings.sell ?
                                    SvgPicture.asset('assets/icons/selected.svg',width: 16.0,) :
                                    SvgPicture.asset('assets/icons/unselected.svg',width: 16.0,),
                                    const SizedBox(width: 5.0),
                                    const Text(
                                      "Sell",
                                      style: TextStyle(color: AppColors.black,),
                                    )
                                  ],
                                ),
                              ),
                            ],
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
                        const Text(AppStrings.requiredProperty),
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
                          child: RequiredPropertyDropdown(
                            reason: requiredProperty,
                            onChange: (newValue){
                              setState((){
                                requiredProperty = newValue;
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
              // location and budget row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.locationName),
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
                            controller: locationNameController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: AppStrings.locationName,
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
                        Text(budgetSellTitle),
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
                          child: BudgetDropdown(
                            reason: budget,
                            onChange: (newValue){
                              setState((){
                                budget = newValue;
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
              // lead source & size (SQFT) row
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.leadSource),
                        const SizedBox(height: 5.0,),
                        Container(
                          // height: 38.0,
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
                          /*child: TextFormField(
                            controller: leadSourceController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: AppStrings.leadSource,
                              hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.textColorGrey,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                            ),
                          ),*/
                          child: AutoCompleteLeadSource(leadSourceList: leadSourceList),
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
                        const Text(AppStrings.sizeInSqFt),
                        const SizedBox(height: 5.0,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0,),
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
                            controller: sizeController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: AppStrings.sizeInSqFt,
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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.projectName),
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
                          child: (locationList2.isEmpty) ?
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: 32.0,
                            alignment: Alignment.centerLeft,
                            child: const Text(AppStrings.projectName),
                          ) :
                          projectListWidget(
                            locationList2: locationList2,
                            onCallBack: (newValue){
                              setState((){
                                locationStr = newValue;
                                if(newValue != 'other'){
                                  projectNameController.clear();
                                }
                              });
                            },
                          ),
                          // child: const Text("Select location"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: locationStr == 'other'
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.projectName),
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
                                controller: projectNameController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                                cursorColor: AppColors.textColorGrey,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: AppStrings.projectName,
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
                        )
                        : Container(),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  String projectName = projectNameController.text;
                  String locationName = locationNameController.text;
                  String fullName = fullNameController.text;
                  String contact1 = contact1Controller.text;
                  String contact2 = contact2Controller.text;
                  String address = addressController.text;
                  String size = sizeController.text;
                  if(fullName.isEmpty){
                    Utilities().toast(AppStrings.fullNameToast);
                  }else if(contact1.isEmpty){
                    Utilities().toast(AppStrings.contact1Toast);
                  }else if(contact1.length < 10 || contact1.length > 10){
                    Utilities().toast(AppStrings.contact1ValidToast);
                  }else if(locationName.isEmpty){
                    Utilities().toast(AppStrings.locationNameToast);
                  }else if(leadSource.isEmpty){
                    Utilities().toast(AppStrings.leadSourceToast);
                  }else if(size.isEmpty){
                    Utilities().toast(AppStrings.sizeToast);
                  }else if(locationStr == 'other' && projectName.isEmpty){
                    Utilities().toast(AppStrings.projectNameToast);
                  }else{
                    addLeadAPI(context, fullName, contact1, contact2, address, leadSource, size, projectName, locationName);
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
  Future<void> addLeadAPI(BuildContext context,String fullName,String contact1,String contact2,String address,String leadSource,String size,String projectName,String locationName) async {
    Loader.ProgressloadingDialog(context, true);
    budget = removeLakhFromBudget(budget);
    try {
      const url = Urls.addLeadUrl;
      var formData = FormData.fromMap({
        "user_id" : userID,
        "role" : role,
        "bm_id" : userID,
        "contact1" : contact1,
        "contact2" : contact2,
        "city" : selectedCity,
        "residentail_address" : address,
        "lead_source" : leadSource,
        "requirement" : requirement,
        "property_type" : requiredProperty,
        "prefered_location" : locationStr,
        "other_prefered_location" : projectName,
        "budget" : budget,
        "property_size" : size,
        "state" : selectedState,
        "name":fullName,
        "location":locationName,
      });
      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      Navigator.of(context).pop();
      if (responseDio.statusCode == 200) {

        print(Urls.addLeadUrl);

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
  Future<void> locationListAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.locationListUrl;
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        LocationListModel response = LocationListModel.fromJson(map);

        if (response.status == true) {
          locationList2 = response.data!;
          setState(() {});
        } else {
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  Future<void> leadSourceListAPI(BuildContext context) async {
    try {
      const url = Urls.leadSourceListUrl;
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print(Urls.leadSourceListUrl);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        LeadSourceListModel response = LeadSourceListModel.fromJson(map);


        if(response.status == true){
          leadSourceList = response.data!;
          setState(() {});
        }else {
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }

  Future<void> mobileNoExistAPI(BuildContext context,String contact1) async {
    isLoading = true;
    setState((){});
    try {
      const url = Urls.mobileExistUrl;
      var formData = FormData.fromMap({
        "contact1" : contact1
      });
      final responseDio = await Dio().post(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        MobileNoExistModel response = MobileNoExistModel.fromJson(map);

        if(response.status == true){
          Utilities().toast(response.message);
        }
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      isLoading = false;
      setState((){});
      print('error: $e');
    }
    return;
  }
}

class RequiredPropertyDropdown extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  RequiredPropertyDropdown({super.key,required this.reason,required this.onChange,});

  @override
  State<RequiredPropertyDropdown> createState() => _RequiredPropertyDropdownState();
}
class _RequiredPropertyDropdownState extends State<RequiredPropertyDropdown> {
  String dropdownValue = requiredPropertyList.first;

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
      items: requiredPropertyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class LocationDropdown extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  LocationDropdown({super.key,required this.reason,required this.onChange,});

  @override
  State<LocationDropdown> createState() => _LocationDropdownState();
}
class _LocationDropdownState extends State<LocationDropdown> {
  String dropdownValue = locationList.first;

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
      items: locationList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class BudgetDropdown extends StatefulWidget {
  String reason;
  final Function(String) onChange; // Callback function
  BudgetDropdown({super.key,required this.reason,required this.onChange,});

  @override
  State<BudgetDropdown> createState() => _BudgetDropdownState();
}
class _BudgetDropdownState extends State<BudgetDropdown> {
  String dropdownValue = budgetList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: budgetList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class projectListWidget extends StatefulWidget {
  List<Data>? locationList2;
  Function onCallBack;
  projectListWidget({super.key, required this.locationList2, required this.onCallBack});

  @override
  State<projectListWidget> createState() => _projectListWidgetState();
}
class _projectListWidgetState extends State<projectListWidget> {
  String dropdownValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.locationList2!.first.id.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.black,),
      underline: Container(color: AppColors.transparent,),
      items: List.generate(
          widget.locationList2!.length,
              (index) => DropdownMenuItem(
            onTap: () {
              widget.onCallBack(widget.locationList2![index].id);
            },
            child: Text(widget.locationList2![index].name.toString()),
            value: widget.locationList2![index].id.toString(),
          ),
      ),
      onChanged: (String? value) {
        dropdownValue = value.toString();
        setState(() {});
      },
    );
  }
}

class AutoCompleteLeadSource extends StatefulWidget {
  List<String> leadSourceList;
  AutoCompleteLeadSource({super.key,required this.leadSourceList});

  // static const List<String> _kOptions = <String>[
  //   'aardvark',
  //   'bobcat',
  //   'chameleon',
  // ];

  @override
  State<AutoCompleteLeadSource> createState() => _AutoCompleteLeadSourceState();
}
class _AutoCompleteLeadSourceState extends State<AutoCompleteLeadSource> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // if (textEditingValue.text == '') {
        //   return const Iterable<String>.empty();
        // }
        setState(() {
          leadSource = textEditingValue.text;
        });
        return widget.leadSourceList.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        // debugPrint('You just selected $selection');
        leadSource = selection;
        setState(() {});
      },
    );
  }
}

removeLakhFromBudget(String budget){
  if(budget == "15 to 20 Lakh"){
    return "15 to 20";
  }else if(budget == "20 to 30 Lakh"){
    return "20 to 30";
  }else if(budget == "30 to 40 Lakh"){
    return "30 to 40";
  }else if(budget == "40 to 50 Lakh "){
    return "40 to 50";
  }else if(budget == "50 to 60 Lakh"){
    return "50 to 60";
  }else if(budget == "60 to 70 Lakh"){
    return "60 to 70";
  }else if(budget == "70 to 85 Lakh"){
    return "70 to 85";
  }else{
    return budget;
  }
}