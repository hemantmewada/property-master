// ignore_for_file: use_build_context_synchronously, sort_child_properties_last


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propertymaster/models/GetProfileModel.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/models/MobileNoExistModel.dart';
import 'package:propertymaster/models/UpdateProfileImageModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:image_cropper/image_cropper.dart';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Urls.dart' ;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// apis

class ProfileAndKyc extends StatefulWidget {
  const ProfileAndKyc({super.key});

  @override
  State<ProfileAndKyc> createState() => _ProfileAndKycState();
}

class _ProfileAndKycState extends State<ProfileAndKyc> {
  late String userID;
  String role = '';
  String name = '';
  String empId = '';
  String email = '';
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController contact1Controller = TextEditingController();
  TextEditingController contact2Controller = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController doaController = TextEditingController();
  TextEditingController dojController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController currentResidenceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panCardNoController = TextEditingController();
  TextEditingController aadharCardNoController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDesignationController = TextEditingController();
  TextEditingController totalExperienceInYearsController = TextEditingController();
  TextEditingController natureOfWorkController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();

  RegExp regExpPAN = new RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
  RegExp regExpAadhar = new RegExp("[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}");


  final ImagePicker imagePickerAadharFront = ImagePicker();
  final ImagePicker imagePickerAadharBack = ImagePicker();
  final ImagePicker imagePickerPanCard = ImagePicker();
  final ImagePicker imagePickerBankPassbook = ImagePicker();
  final ImagePicker imagePickerCancelCheque = ImagePicker();
  final ImagePicker imagePickerProfile = ImagePicker();
  XFile? aadharFrontController;
  XFile? aadharBackController;
  XFile? panCardController;
  XFile? bankPassbookController;
  XFile? cancelChequeController;
  XFile? profileController;
  var bytes;

  String aadharFrontImageUrl= "";
  String aadharBackImageUrl= "";
  String panCardImageUrl= "";
  String bankPassbookImageUrl= "";
  String cancelChequeImageUrl= "";

  String profileImage = "";
  bool isLoading = true;

  Data? userData;

  DateTime selectedDOB = DateTime.now();
  Future<void> _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDOB,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 200),), // prev 200 years
      lastDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      currentDate: selectedDOB,
    );
    if (picked != null && picked != selectedDOB) {
      setState(() {
        selectedDOB = picked;
        // dateController.text = '${AppDate().toDate(selectedDOB.toString())}/${AppDate().toMonth(selectedDOB.toString())}/${AppDate().toYear(selectedDOB.toString())}';
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOB);
        dobController.text = formattedDate;
      });
    }
  }
  DateTime selectedDOA = DateTime.now();
  Future<void> _selectDOA(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDOA,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 200),), // prev 200 years
      lastDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      currentDate: selectedDOA,
    );
    if (picked != null && picked != selectedDOA) {
      setState(() {
        selectedDOA = picked;
        // dateController.text = '${AppDate().toDate(selectedDOA.toString())}/${AppDate().toMonth(selectedDOA.toString())}/${AppDate().toYear(selectedDOA.toString())}';
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOA);
        doaController.text = formattedDate;
      });
    }
  }
  DateTime selectedDOJ = DateTime.now();
  Future<void> _selectDOJ(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDOJ,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 200),), // prev 200 years
      lastDate: DateTime.now(),
      keyboardType: TextInputType.datetime,
      currentDate: selectedDOJ,
    );
    if (picked != null && picked != selectedDOJ) {
      setState(() {
        selectedDOJ = picked;
        // dateController.text = '${AppDate().toDate(selectedDOJ.toString())}/${AppDate().toMonth(selectedDOJ.toString())}/${AppDate().toYear(selectedDOJ.toString())}';
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDOJ);
        dojController.text = formattedDate;
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
    userID = prefs.getString("userID") ?? '';
    empId = prefs.getString("empId") ?? '';
    role = prefs.getString("role") ?? '';
    name = prefs.getString("name") ?? '';
    email = prefs.getString("email") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my empId is >>>>> {$empId}');
    print('my role is >>>>> {$role}');
    print('my email is >>>>> {$email}');
    getProfileAPI(context);
    getProfileImageAPI(context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(AppStrings.profileAndKyc,style: TextStyle(color: AppColors.white,),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap: () => bottomImageSelector(context, "profile"),
                    child: CircleAvatar(
                      radius: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        // radius: 48,
                        child: profileController != null ?
                        Image.file(
                          File(profileController!.path),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ) :
                        !isLoading ?
                        Image.network(
                          profileImage,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.cover,
                        ) :
                        loaderGIF,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0,),
              child: const Text(
                "Personal Information",
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: fullNameController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.fullName),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: fatherNameController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.fatherName),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: contact1Controller,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.contact1),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: contact2Controller,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.contact2),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        if(userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)){
                          null;
                        }else{
                          _selectDOB(context);
                        }
                      },
                      controller: dobController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecorationForDates(AppStrings.dobShort),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        if(userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)){
                          null;
                        }else{
                          _selectDOA(context);
                        }
                      },
                      controller: doaController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecorationForDates(AppStrings.doa),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        if(userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)){
                          null;
                        }else{
                          _selectDOJ(context);
                        }
                      },
                      controller: dojController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecorationForDates(AppStrings.doj),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      readOnly: true,
                      controller: designationController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.designation),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: idNoController,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.idNo),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      controller: currentResidenceController,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.currentResidenceAddress),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: emailController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.email),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: panCardNoController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 10,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.panCardNo),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: aadharCardNoController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      maxLength: 14,
                      onChanged: (value)=> setState(()=> aadharCardNoController.text = _formatAadharNumber(value)),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.aadharCardNo),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0,),
              child: const Text(
                "Working Experience",
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: companyNameController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.companyName),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: companyDesignationController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.companyDesignation),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: totalExperienceInYearsController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.totalExperienceInYears),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: natureOfWorkController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.natureOfWork),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0,),
              child: const Text(
                "Bank Details",
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: bankNameController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.bankName),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: accountNoController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.accountNo),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: branchNameController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.branchName),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                    decoration: boxDecoration,
                    child: TextFormField(
                      controller: ifscCodeController,
                      readOnly: (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? true : false,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                      cursorColor: AppColors.textColorGrey,
                      decoration: inputDecoration(AppStrings.ifscCode),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0,),
              child: const Text(
                "Documents",
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("1. Aadhar Front"),),
                          (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? Container() : InkWell(
                            onTap: () => bottomImageSelector(context, "aadharFront"),
                            child: const Icon(Icons.file_upload_outlined,color: AppColors.colorSecondary,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? null : bottomImageSelector(context, "aadharFront"),
                        child: Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: AppColors.light_grey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          child: aadharFrontController != null ?
                          fileImage(aadharFrontController!.path) :
                          aadharFrontImageUrl != "" ?
                          networkImage(aadharFrontImageUrl) :
                          imageNotAvailable,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("2. Aadhar Back"),),
                          (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? Container() : InkWell(
                            onTap: () => bottomImageSelector(context, "aadharBack"),
                            child: const Icon(Icons.file_upload_outlined,color: AppColors.colorSecondary,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? null : bottomImageSelector(context, "aadharBack"),
                        child: Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: AppColors.light_grey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          child: aadharBackController != null ?
                          fileImage(aadharBackController!.path) :
                          aadharBackImageUrl != "" ?
                          networkImage(aadharBackImageUrl) :
                          imageNotAvailable,
                        ),
                      ),
                    ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("3. Pan Card"),),
                          (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? Container() : InkWell(
                            onTap: () => bottomImageSelector(context, "panCard"),
                            child: const Icon(Icons.file_upload_outlined,color: AppColors.colorSecondary,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? null : bottomImageSelector(context, "panCard"),
                        child: Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: AppColors.light_grey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          child: panCardController != null ?
                          fileImage(panCardController!.path) :
                          panCardImageUrl != "" ?
                          networkImage(panCardImageUrl) :
                          imageNotAvailable,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("4. Bank Passbook"),),
                          (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? Container() : InkWell(
                            onTap: () => bottomImageSelector(context, "bankPassbook"),
                            child: const Icon(Icons.file_upload_outlined,color: AppColors.colorSecondary,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? null : bottomImageSelector(context, "bankPassbook"),
                        child: Container(
                          height: 100.0,
                          decoration: const BoxDecoration(
                            color: AppColors.light_grey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          child: bankPassbookController != null ?
                          fileImage(bankPassbookController!.path) :
                          bankPassbookImageUrl != "" ?
                          networkImage(bankPassbookImageUrl) :
                          imageNotAvailable,
                        ),
                      ),
                    ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: Text("5. Cancel Cheque"),),
                          (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? Container() : InkWell(
                            onTap: () => bottomImageSelector(context, "cancelCheque"),
                            child: const Icon(Icons.file_upload_outlined,color: AppColors.colorSecondary,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => (userData != null && (userData!.kycUpdatedStatus == "1" || userData!.kycUpdatedStatus == 1)) ? null : bottomImageSelector(context, "cancelCheque"),
                        child: Container(
                          height: 150.0,
                          decoration: const BoxDecoration(
                            color: AppColors.light_grey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          child: cancelChequeController != null ?
                          fileImage(cancelChequeController!.path) :
                          cancelChequeImageUrl != "" ?
                          networkImage(cancelChequeImageUrl) :
                          imageNotAvailable,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: ()  {
                String fullName = fullNameController.text;
                String fatherName = fatherNameController.text;
                String contact1 = contact1Controller.text;
                String dob = dobController.text;
                String doa = doaController.text;
                String doj = dojController.text;
                String designation = designationController.text;
                String idNo = idNoController.text;
                String currentResidence = currentResidenceController.text;
                String email = emailController.text;
                String pan = panCardNoController.text;
                String aadhar = aadharCardNoController.text;
                if(fullName.isEmpty){
                  Utilities().toast(AppStrings.fullNameToast);
                }else if(fatherName.isEmpty){
                  Utilities().toast(AppStrings.fatherNameToast);
                }else if(contact1.isEmpty){
                  Utilities().toast(AppStrings.contact1Toast);
                }else if(contact1.length < 10 || contact1.length > 10){
                  Utilities().toast(AppStrings.contact1ValidToast);
                }else if(dob.isEmpty){
                  Utilities().toast(AppStrings.dobToast);
                }else if(doa.isEmpty){
                  Utilities().toast(AppStrings.doaToast);
                }else if(doj.isEmpty){
                  Utilities().toast(AppStrings.dojToast);
                }else if(designation.isEmpty){
                  Utilities().toast(AppStrings.designationToast);
                }else if(idNo.isEmpty){
                  Utilities().toast(AppStrings.idNoToast);
                }else if(currentResidence.isEmpty){
                  Utilities().toast(AppStrings.currentResidenceAddress);
                }else if(email.isEmpty){
                  Utilities().toast(AppStrings.emailToast);
                }else if(!email.contains("@gmail.com")){
                  Utilities().toast(AppStrings.emailValidToast);
                }else if(pan.isEmpty){
                  Utilities().toast(AppStrings.panCardNoToast);
                }else if(!regExpPAN.hasMatch(pan)){
                  Utilities().toast(AppStrings.panCardNoValidToast);
                }else if(aadhar.isEmpty){
                  Utilities().toast(AppStrings.aadharCardNoToast);
                }else if(!regExpAadhar.hasMatch(aadhar)){
                  Utilities().toast(AppStrings.aadharCardNoValidToast);
                }else{
                  updateProfileAPI(context);
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 20.0,),
                width: MediaQuery.of(context).size.width * 1,
                height: 50.0,
                decoration: BoxDecoration(color: AppColors.colorSecondary,borderRadius: BorderRadius.circular(50.0),),
                child: const Text(
                  AppStrings.submit,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0,color: AppColors.white,fontWeight: FontWeight.w700,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Decoration boxDecoration = BoxDecoration(
    border: Border.all(
        color: AppColors.colorSecondary,
        width: 1.0,
        style: BorderStyle.solid
    ),
    borderRadius: BorderRadius.circular(5.0),
    color: Colors.white,
  );
  InputDecoration inputDecoration(String str){
    return InputDecoration(
      hintText: str,
      counterText: "",
      isDense: true,
      hintStyle: const TextStyle(
        fontSize: 14.0,
        color: AppColors.textColorGrey,
        fontWeight: FontWeight.w500,
      ),
      border: InputBorder.none,
    );
  }
  InputDecoration inputDecorationForDates(String str){
    return InputDecoration(
      hintText: str,
      labelText: str,
      counterText: "",
      isDense: true,
      hintStyle: const TextStyle(
        fontSize: 14.0,
        color: AppColors.textColorGrey,
        fontWeight: FontWeight.w500,
      ),
      border: InputBorder.none,
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
  Future<void> getProfileAPI(BuildContext context) async {
    try{
      Loader.ProgressloadingDialog(context, true);
      var url = '${Urls.getProfiledUrl}?id=$userID';
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print("getProfileAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        GetProfileModel res = GetProfileModel.fromJson(map);
        if (res.status == true) {
          // here the data will be fetched
          // Personal Info
          fullNameController.text = res.data!.name!;
          fatherNameController.text = res.data!.fatherName!;
          contact1Controller.text = res.data!.mobile!;
          contact2Controller.text = res.data!.alternateMobile!;
          dobController.text = res.data!.dob!;
          doaController.text = res.data!.doa!;
          dojController.text = res.data!.doj!;
          selectedDOB = DateTime.now();
          selectedDOA = DateTime.now();
          selectedDOJ = DateTime.now();
          // selectedDOB = DateTime.parse(res.data!.dob!);
          // selectedDOA = DateTime.parse(res.data!.doa!);
          // selectedDOJ = DateTime.parse(res.data!.doj!);
          designationController.text = role;
          idNoController.text = res.data!.idNo!;
          currentResidenceController.text = res.data!.currentAddress!;
          emailController.text = res.data!.email!;
          panCardNoController.text = res.data!.panNo!;
          aadharCardNoController.text = res.data!.aadharNo!;

          // Working Info
          companyNameController.text = res.data!.companyName!;
          companyDesignationController.text = res.data!.companyDesignation!;
          totalExperienceInYearsController.text = res.data!.totalExperience!;
          natureOfWorkController.text = res.data!.workNature!;

          // Bank Details
          bankNameController.text = res.data!.bankName!;
          accountNoController.text = res.data!.acNo!;
          branchNameController.text = res.data!.branchName!;
          ifscCodeController.text = res.data!.ifsc!;

          // documents
          aadharFrontImageUrl = res.data!.aadharcardFront!;
          aadharBackImageUrl = res.data!.aadharcardBack!;
          panCardImageUrl = res.data!.pancardImg!;
          bankPassbookImageUrl = res.data!.passbookImg!;
          cancelChequeImageUrl = res.data!.cancelCheque!;

          // set user data
          userData = res.data!;

          setState(() {});
        } else {
          Utilities().toast(res.message.toString());
          setState(() {});
        }
      }
      return;
    } catch (e) {
      print('error: $e');
      Utilities().toast('error: $e');
    }
  }
  Future<void> updateProfileAPI(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      Loader.ProgressloadingDialog(context, true);
      var url = '${Urls.updateProfileUrl}?id=$userID';
      var formData = FormData.fromMap({
        "id" : userID,
        "full_name" : fullNameController.text,
        "father_name" : fatherNameController.text,
        "mobile" : contact1Controller.text,
        "alternate_mobile" : contact2Controller.text,
        "email" : emailController.text,
        "dob" : DateFormat('yyyy-MM-dd').format(selectedDOB),
        "doa" : DateFormat('yyyy-MM-dd').format(selectedDOA),
        "doj" : DateFormat('yyyy-MM-dd').format(selectedDOJ),
        "current_address" : currentResidenceController.text,
        "aadhar_no" : aadharCardNoController.text,
        "pan_no" : panCardNoController.text,
        "designation" : designationController.text,
        "company_name" : companyNameController.text,
        "company_designation" : companyDesignationController.text,
        "working_experience" : totalExperienceInYearsController.text,
        "work_nature" : natureOfWorkController.text,
        "bank_name" : bankNameController.text,
        "account_number" : accountNoController.text,
        "branch_name" : branchNameController.text,
        "ifsc_code" : ifscCodeController.text,
      });
      if(aadharFrontController != null){
        formData.files.add(MapEntry("kyc_aadhar", await MultipartFile.fromFile(aadharFrontController!.path,filename: aadharFrontController!.name,),));
      }
      if(aadharBackController != null){
        formData.files.add(MapEntry("kyc_aadhar_back", await MultipartFile.fromFile(aadharBackController!.path,filename: aadharBackController!.name,),));
      }
      if(panCardController != null){
        formData.files.add(MapEntry("kyc_pan", await MultipartFile.fromFile(panCardController!.path,filename: panCardController!.name,),));
      }
      if(bankPassbookController != null){
        formData.files.add(MapEntry("kyc_passbook", await MultipartFile.fromFile(bankPassbookController!.path,filename: bankPassbookController!.name,),));
      }
      if(cancelChequeController != null){
        formData.files.add(MapEntry("kyc_cheque", await MultipartFile.fromFile(cancelChequeController!.path,filename: cancelChequeController!.name,),));
      }
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print("updateProfileAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        MobileNoExistModel res = MobileNoExistModel.fromJson(map);
        if (res.status == true) {
          prefs.setString("name", fullNameController.text);
          prefs.setString("email", emailController.text);
          Utilities().toast(res.message.toString());
          setState(() {});
        } else {
          Utilities().toast(res.message.toString());
          setState(() {});
        }
      }
      return;
    } on DioError catch (error) {
      Loader.ProgressloadingDialog(context, false);
      String errorMessage = error.response?.data['message'] ?? 'An error occurred';
      Utilities().toast(errorMessage);
      // print("error.message-------${error.response}");
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      print('error: $e');
      Utilities().toast('error: $e');
    }
  }
  Future<void> getProfileImageAPI(BuildContext context) async {
    try{
      setState(() => isLoading = true);
      var url = '${Urls.propertyDataUrl}?user_id=$userID';
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      setState(() => isLoading = false);
      if (responseDio.statusCode == 200) {
        print("getProfileImageAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        HomePageDataModel res = HomePageDataModel.fromJson(map);
        if (res.status == true) {
          profileImage = res.userData!.profileImg!;
          setState(() {});
        } else {
          Utilities().toast(res.message.toString());
          setState(() {});
        }
      }
      return;
    } catch (e) {
      setState(() => isLoading = false);
      print('error: $e');
      // Utilities().toast('error: $e');
    }
  }
  Future<void> updateProfileImageAPI(BuildContext context) async {
    try{
      const url = Urls.updateProfileImageUrl;
      var formData = FormData.fromMap({
        "user_id" :  userID,
        "profile_image" :  await MultipartFile.fromFile(profileController!.path, filename: profileController!.name),
      });
      final responseDio = await Dio().post(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print("updateProfileImageAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        UpdateProfileImageModel res = UpdateProfileImageModel.fromJson(map);
        if (res.status == true) {
          setState(() {});
        } else {
          setState(() {});
        }
        Utilities().toast(res.message.toString());
      }
      return;
    } catch (e) {
      Utilities().toast('error: $e');
    }
  }

  /// Image pick Bottom dialog.............
  bottomImageSelector(BuildContext context, String document){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => pickImage(context,ImageSource.camera, document),
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery'),
              onTap: () => pickImage(context,ImageSource.gallery, document),
            ),
            // if(documentUrl.isNotEmpty)
            //   ListTile(
            //     leading: const Icon(Icons.image),
            //     title: const Text('View'),
            //     onTap: () => print("something else action"),
            //   ),
          ]);
        }
    );
  }
  ///Image picker...............
  Future pickImage(BuildContext context,imageSource, String document) async {
    if(!kIsWeb){
      if(document == "aadharFront") {
        var image = await imagePickerAadharFront.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // aadharFrontController = XFile(image.path);
          Navigator.pop(context);
          setState((){});
        }
      }else if(document == "aadharBack") {
        var image = await imagePickerAadharBack.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // aadharBackController = XFile(image.path);
          Navigator.pop(context);
          setState((){});
        }
      }else if(document == "panCard") {
        var image = await imagePickerPanCard.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // panCardController = XFile(image.path);
          Navigator.pop(context);
          setState((){});
        }
      }else if(document == "bankPassbook") {
        var image = await imagePickerBankPassbook.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // bankPassbookController = XFile(image.path);
          Navigator.pop(context);
          setState((){});
        }
      }else if(document == "cancelCheque") {
        var image = await imagePickerCancelCheque.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // cancelChequeController = XFile(image.path);
          Navigator.pop(context);
          setState((){});
        }
      }else if(document == "profile") {
        var image = await imagePickerProfile.pickImage(source: imageSource,imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // profileController = XFile(image.path);
          Navigator.pop(context);
          // updateProfileImageAPI(context);
          setState((){});
        }
      }
      setState((){});
      print('image path (if) is ${bytes}');
    }else if(kIsWeb){

      if(document == "aadharFront") {
        var image = await imagePickerAadharFront.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // aadharFrontController = XFile(image.path);
          Navigator.pop(context);
          setState(() {});
        }
      }else if(document == "aadharBack") {
        var image = await imagePickerAadharBack.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // aadharBackController = XFile(image.path);
          Navigator.pop(context);
          setState(() {});
        }
      }else if(document == "aadharBack") {
        var image = await imagePickerPanCard.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // panCardController = XFile(image.path);
          Navigator.pop(context);
          setState(() {});
        }
      }else if(document == "bankPassbook") {
        var image = await imagePickerBankPassbook.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // bankPassbookController = XFile(image.path);
          Navigator.pop(context);
          setState(() {});
        }
      }else if(document == "cancelCheque") {
        var image = await imagePickerCancelCheque.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // cancelChequeController = XFile(image.path);
          Navigator.pop(context);
          setState(() {});
        }
      }else if(document == "profile") {
        var image = await imagePickerProfile.pickImage(source: imageSource, imageQuality: 10,);
        if (image == null) {
          print('+++++++++null');
          Navigator.pop(context);
        } else {
          _cropImage(XFile(image.path), document);
          // profileController = XFile(image.path);
          Navigator.pop(context);
          // updateProfileImageAPI(context);
          setState(() {});
        }
      }
      setState((){});
      print('image path (else) is ${bytes}');
    }
  }
  Widget networkImage(String path) => ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () => navigateTo(context, ImagePreviewScreen(imageUrl: path)),
        child: Image.network(
          path,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  Widget fileImage(String path) => ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: InkWell(
      onTap: () => navigateTo(context, ImagePreviewScreen(imageUrl: path)),
      child: Image.file(
        File(path),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    ),
  );
  final Widget imageNotAvailable = const Center(
    child: Text(
      "Not Uploaded Yet?\nClick to Upload",
      style: TextStyle(color: AppColors.white,),
      textAlign: TextAlign.center,
    ),
  );

  _cropImage(XFile imgFile, String document) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: AppColors.colorSecondary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: "Image Cropper",)
        ]
    );
    if (croppedFile != null) {
      if(document == "aadharFront") {
        setState(() => aadharFrontController = XFile(croppedFile.path));
      } else if(document == "aadharBack"){
        setState(() => aadharBackController = XFile(croppedFile.path));
      } else if(document == "panCard"){
        setState(() => panCardController = XFile(croppedFile.path));
      } else if(document == "bankPassbook"){
        setState(() => bankPassbookController = XFile(croppedFile.path));
      } else if(document == "cancelCheque"){
        setState(() => cancelChequeController = XFile(croppedFile.path));
      } else if(document == "profile"){
        setState(() {
          profileController = XFile(croppedFile.path);
          updateProfileImageAPI(context);
        });
      }
    }
  }
}
