import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/FreeUserRegistrationModel.dart';
import 'package:propertymaster/models/FreeUserRegistrationModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/authentication/OTPVerification.dart';

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

class LoginFreeUser extends StatefulWidget {
  const LoginFreeUser({super.key});

  @override
  State<LoginFreeUser> createState() => _LoginFreeUserState();
}

class _LoginFreeUserState extends State<LoginFreeUser> {
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  String role = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 30.0,
                          height: 30.0,
                          child: SvgPicture.asset('assets/icons/back.svg'),
                        ),
                        const SizedBox(width: 10.0),
                        const Text(
                          AppStrings.back,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              // const SizedBox(height: 10.0,),
              // const Text(
              //   AppStrings.loginTitle2,
              //   style: TextStyle(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 35.0,
              //     color: AppColors.black,
              //   ),
              // ),
              const SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text("Are you a",style: TextStyle(fontSize: 12.0,),),),
                          const SizedBox(height: 5.0,),
                          InkWell(
                            onTap: () => setState(() => role = "Customer"),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5.0),
                                color: role == "Customer" ? AppColors.colorSecondary : AppColors.transparent,
                              ),
                              child: Center(
                                child: Text("Customer",style: TextStyle(color: role == "Customer" ? AppColors.white : AppColors.colorSecondary,),textAlign: TextAlign.center,),
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
                          Center(child: Text("Do you want to become a",style: TextStyle(fontSize: 12.0,),),),
                          const SizedBox(height: 5.0,),
                          InkWell(
                            onTap: () => setState(() => role = "Business Partner"),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(5.0),
                                color: role == "Business Partner" ? AppColors.colorSecondary : AppColors.transparent,
                              ),
                              child: Center(
                                child: Text("Business Partner",style: TextStyle(color: role == "Business Partner" ? AppColors.white : AppColors.colorSecondary,),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
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
                      child: Icon(Icons.account_circle_rounded,color: AppColors.colorSecondary,),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                          fontSize: 14.0, color: AppColors.black,
                        ),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
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
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
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
                          hintText: AppStrings.phoneNumber,
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
              const SizedBox(height: 20.0,),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: InkWell(
                  onTap: () {
                    String name = nameController.text;
                    String phone = phoneNumberController.text;
                    if(role.isEmpty){
                      Utilities().toast("Please select type");
                    }else if(name.isEmpty){
                      Utilities().toast(AppStrings.fullNameToast);
                    }else if(phone.isEmpty){
                      Utilities().toast(AppStrings.phoneToast);
                    }else if(phone.length < 10 || phone.length > 10) {
                      Utilities().toast(AppStrings.phoneValidToast);
                    }else{
                      freeUserRegisterAPI(context);
                    }
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.submit,
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
      ),
    );
  }
  Future<void> freeUserRegisterAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.freeUserRegisterUrl;
      var formData = FormData.fromMap({
        "name" : nameController.text,
        "role" : role,
        "mobile" : phoneNumberController.text,
      });
      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      Navigator.of(context).pop();
      if (responseDio.statusCode == 200) {

        print(Urls.addLeadUrl);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        FreeUserRegistrationModel response = FreeUserRegistrationModel.fromJson(map);

        Utilities().toast(response.message);
        // if(response.status == true){
        //   Navigator.of(context).pop();
        //   setState(() {});
        // }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
}
