// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
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
];

const List<String> stateList = <String>[
  'Madhya Pradesh',
  'Uttar Pradesh',
  'Maharashtra',
  'Gujarat',
  'Rajsthan',
  'Punjab',
  'Delhi',
  'Bihar',
  'Chhattisgarh',
  'Haryana',
  'West Bengal',
  'Karnataka',
  'Tamilnadu',
  'Goa',
  'Odisa',
  'Himanchal Pradesh',
  'Uttarakhand',
  'Aandhra Pradesh',
  'Assam',
  'Jammu Kashmir',
  'Kerala',
];
List<String> cityList = <String>[
  'Indore',
  'Bhopal',
  'Ujjain',
  'Khandwa',
  'Ratlam',
  'Dewas',
  'Jabalpur',
  'Rewa',
  'Gwalior',
  'Khargone',
];
const List<String> budgetList = <String>[
  '15 to 20 Lakh',
  '20 to 30 Lakh',
  '30 to 40 Lakh',
  '40 to 50 Lakh ',
  '50 to 60 Lakh',
  '60 to 70 Lakh',
  '70 to 85 Lakh',
  '85 to 1 cr',
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

class _AddLeadState extends State<AddLead> {
  var searchController = TextEditingController();
  var fullNameController = TextEditingController();
  var contact1Controller = TextEditingController();
  var contact2Controller = TextEditingController();
  var addressController = TextEditingController();
  var leadSourceController = TextEditingController();
  var projectNameController = TextEditingController();
  var sizeController = TextEditingController();
  var locationNameController = TextEditingController();
  String requirement = AppStrings.buy;
  String requiredProperty = requiredPropertyList.first;
  String state = stateList.first;
  String city = cityList.first;
  String location = locationList.first;
  String locationStr = '1';
  String budget = budgetList.first;
  String budgetSellTitle = AppStrings.budgetInLakh;
  late String userID;
  late String role;
  List<Data> locationList2 = [];
  // onCallBackFunction(String Id) async {
  //   locationStr = await Id;
  //   setState(() {});
  // }

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
                  const Text(AppStrings.propertyMaster,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
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
                      child: TextFormField(
                        controller: contact1Controller,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: "",
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
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: "",
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
                          child: StateDropdown(
                            name: state,
                            onChange: (newValue){
                              setState((){
                                state = newValue;
                              });
                            },
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
                          child: CityDropdown(
                            name: city,
                            onChange: (newValue){
                              setState((){
                                city = newValue;
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
                          // child: LocationDropdown(
                          //   reason: location,
                          //   onChange: (newValue){
                          //     setState((){
                          //       location = newValue;
                          //     });
                          //   },
                          // ),
                          child: (locationList2.isEmpty) ? Container() : SearchFilter(
                            locationList2: locationList2,
                            onCallBack: (newValue){
                              setState((){
                                locationStr = newValue;
                                if(newValue != 'other'){
                                  projectNameController.clear();
                                }
                              });
                            },
                            // onCallBack: onCallBackFunction,
                          ),
                          // child: const Text("Select location"),
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
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
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
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: locationStr == 'other'
                        ? Container(
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
                        )
                        : Container(),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  print(state);
                  print(city);
                  return;
                  String projectName = projectNameController.text;
                  String locationName = locationNameController.text;
                  String fullName = fullNameController.text;
                  String contact1 = contact1Controller.text;
                  String contact2 = contact2Controller.text;
                  String address = addressController.text;
                  String leadSource = leadSourceController.text;
                  String size = sizeController.text;
                  if(fullName.isEmpty){
                    Utilities().toast(AppStrings.fullNameToast);
                  }else if(contact1.isEmpty){
                    Utilities().toast(AppStrings.contact1Toast);
                  }else if(contact1.length < 10 || contact1.length > 10){
                    Utilities().toast(AppStrings.contact1ValidToast);
                  }else if(locationStr == 'other' && projectName.isEmpty){
                    Utilities().toast(AppStrings.projectNameToast);
                  }else if(locationName.isEmpty){
                    Utilities().toast(AppStrings.locationNameToast);
                  }else if(leadSource.isEmpty){
                    Utilities().toast(AppStrings.leadSourceToast);
                  }else if(size.isEmpty){
                    Utilities().toast(AppStrings.sizeToast);
                  }else{
                    addLeadAPI(context, fullName, contact1, contact2, address, leadSource, size, requirement, requiredProperty, budget, projectName, locationName);
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
  void locationModal(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
              backgroundColor: AppColors.white,
              title: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Select your category',
                      style: TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2/2,
                        childAspectRatio: 8/9,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        // final splitted = categorieslist[index].bg!.split('#');
                        // String color = '0xFF${splitted[1].toLowerCase()}';
                        final splitted = '#EEE9FF'.split('#');
                        String color = '0xFF${splitted[1].toLowerCase()}';
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Padding(
                            padding:  const EdgeInsets.only(top: 0.0,bottom: 0.0,/*right: 5.0,left: 5.0,*/),
                            child: Container(
                              height: 170.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    // padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color:  Color(int.parse(color)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.network(
                                          'https://cdn.pixabay.com/photo/2023/12/30/17/39/kombucha-8478515_1280.jpg',
                                          width: 30.0,
                                          height: 30.0,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height,
                                          padding: const EdgeInsets.all(15.0),
                                          child: SvgPicture.asset(
                                            'assets/icons/right_tick.svg',
                                            width: 30.0,
                                            height: 30.0,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  const Text(
                                    "Category Name",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.15, 10, MediaQuery.of(context).size.width * 0.15, 0),
                            // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: const BoxDecoration(
                              color: AppColors.colorPrimary,
                              borderRadius: BorderRadius.all(Radius.circular(19.0)),
                            ),
                            child: const Text(
                              'Done',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Future<void> addLeadAPI(BuildContext context,String fullName,String contact1,String contact2,String address,String leadSource,String size,String requirement,String requiredProperty,String budget,String projectName,String locationName) async {
    // Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.addLeadUrl),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      request.fields['user_id'] =  userID;
      request.fields['role'] =  role;
      request.fields['bm_id'] =  userID;
      request.fields['contact1'] =  contact1;
      request.fields['contact2'] =  contact2;
      request.fields['city'] =  'city';
      request.fields['residentail_address'] =  address;
      request.fields['lead_source'] =  leadSource;
      request.fields['requirement'] =  requirement;
      request.fields['property_type'] =  requiredProperty;
      request.fields['prefered_location'] =  locationStr;
      request.fields['other_prefered_location'] =  projectName;
      request.fields['budget'] =  budget;
      request.fields['property_size'] =  size;
      request.fields['state'] =  'state';
      request.fields['name'] =  fullName;
      request.fields['location'] = locationName;
      print(request.fields);
      return;
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      Navigator.of(context).pop();
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(Urls.addLeadUrl);
        Map<String, dynamic> map = convert.jsonDecode(event);
        addLeadModel response = await addLeadModel.fromJson(map);
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
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  Future<void> locationListAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'GET',
        Uri.parse(Urls.locationListUrl),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      print(request.fields);
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(Urls.locationListUrl);
        Map<String, dynamic> map = convert.jsonDecode(event);
        LocationListModel response = await LocationListModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          locationList2 = response.data!;
          setState(() {});
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
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
      padding: const EdgeInsets.symmetric(vertical: 8.0,),
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

// state dropdown
class StateDropdown extends StatefulWidget {
  String name;
  final Function(String) onChange; // Callback function
  StateDropdown({super.key,required this.name,required this.onChange,});

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}
class _StateDropdownState extends State<StateDropdown> {
  String dropdownValue = stateList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0,),
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
      items: stateList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// city dropdown
class CityDropdown extends StatefulWidget {
  String name;
  final Function(String) onChange; // Callback function
  CityDropdown({super.key,required this.name,required this.onChange,});

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}
class _CityDropdownState extends State<CityDropdown> {
  String dropdownValue = cityList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0,),
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
      items: cityList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// location list stateful widget dropdown
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
      padding: const EdgeInsets.symmetric(vertical: 8.0,),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0,),
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

class SearchFilter extends StatefulWidget {
  List<Data>? locationList2;
  Function onCallBack;
  SearchFilter({super.key, required this.locationList2, required this.onCallBack});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}
class _SearchFilterState extends State<SearchFilter> {
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
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: const InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      value: dropdownValue,
      style: const TextStyle(fontSize: 14.0,color: AppColors.black,),
      // icon: const Icon(Icons.keyboard_arrow_down),
      items: List.generate(
          widget.locationList2!.length,
              (index) => DropdownMenuItem(
            onTap: () {
              widget.onCallBack(widget.locationList2![index].id);
            },
            child: Text(widget.locationList2![index].name.toString()),
            value: widget.locationList2![index].id.toString(),
          )),
      onChanged: (String? value) {
        dropdownValue = value.toString();
        setState(() {});
      },
    );
  }
}
