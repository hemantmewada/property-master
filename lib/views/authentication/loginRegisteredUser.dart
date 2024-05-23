// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/ForgotPasswordModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/others/TermsAndConditions.dart';
import 'package:propertymaster/views/authentication/Register.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:propertymaster/views/authentication/otp.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propertymaster/models/LoginModel.dart';
import 'package:dio/dio.dart';
// apis

class LoginRegisteredUser extends StatefulWidget {
  const LoginRegisteredUser({super.key});

  @override
  State<LoginRegisteredUser> createState() => _LoginRegisteredUserState();
}

class _LoginRegisteredUserState extends State<LoginRegisteredUser> {
  var userIDController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

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
              // SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              // const SizedBox(height: 10.0,),
              Center(child: Image.asset('assets/images/logo.png',width: 150.0,)),
              // const SizedBox(height: 10.0,),
              const Text(
                AppStrings.loginTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.0,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 20.0,),
              AutofillGroup(
                child: Column(
                  children: [
                    // userId container
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
                              'assets/icons/registered_user.svg',
                              width: 23.0,
                              color: AppColors.colorSecondary,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              autofillHints: const [AutofillHints.username],
                              controller: userIDController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                fontSize: 14.0, color: AppColors.black,
                              ),
                              cursorColor: AppColors.textColorGrey,
                              decoration: const InputDecoration(
                                hintText: AppStrings.userID,
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
                    // password container
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
                              'assets/icons/lock.svg',
                              width: 23.0,
                              color: AppColors.colorSecondary,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              autofillHints: const [AutofillHints.password],
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                fontSize: 14.0, color: AppColors.black,
                              ),
                              cursorColor: AppColors.textColorGrey,
                              decoration: const InputDecoration(
                                hintText: AppStrings.password,
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
                  ],
                ),
              ),
              // login button starts
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: InkWell(
                  onTap: () async {
                    String userID = userIDController.text;
                    String password = passwordController.text;
                    if(userID.isEmpty){
                      Utilities().toast(AppStrings.userIDToast);
                    } else if(password.isEmpty){
                      Utilities().toast(AppStrings.passwordToast);
                    } else{
                      await loginAPI(context, userID, password);
                    }
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.logIn,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              // login button ends
              InkWell(
                onTap: () {
                  phoneNumberController.clear();
                  forgotPasswordModal();
                },
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                child: const Text(
                  AppStrings.forgotPassword,
                  style: TextStyle(
                    color: AppColors.colorPrimaryDark,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              // login button ends
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 750),
                        isIos: true,
                        child: TermsAndConditions(),
                      )
                  );
                },
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                child: const Text(
                  AppStrings.terrmsAndConditions,
                  style: TextStyle(
                    color: AppColors.colorPrimaryDark,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 750),
                        isIos: true,
                        child: const Register(),
                      )
                  );
                },
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                child: const Text(
                  AppStrings.doNotHaveAccount,
                  style: TextStyle(
                      color: AppColors.colorPrimaryDark,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // forget password dialog
  Future forgotPasswordModal() {
    return showDialog(
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
          height: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.forgotPassword,
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
              const Text(
                AppStrings.forgotPasswordDescription,
                style: TextStyle(fontSize: 13.0,),
              ),
              const SizedBox(height: 10.0,),
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
              InkWell(
                onTap: () async {
                  String phoneNumber = phoneNumberController.text;
                  if(phoneNumber.isEmpty){
                    Utilities().toast(AppStrings.phoneToast);
                  } else if(phoneNumber.length != 10){
                    Utilities().toast(AppStrings.phoneValidToast2);
                  } else{
                    sendOTPAPI(context, phoneNumber);
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
                    AppStrings.sendOTP,
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
  // forget password dialog
  // loginapi api
  Future<void> loginAPI(BuildContext context, String userID, String password) async {
    Loader.ProgressloadingDialog(context, true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      const url = Urls.loginUrl;
      var formData = FormData.fromMap({
        "email" :  userID,
        "password" :  password,
      });
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        Map<String, dynamic> map = (responseDio.data as Map).cast<String,dynamic>();
        LoginModel response = LoginModel.fromJson(map);
        Utilities().toast(response.message);
        if (response.status == true) {
          prefs.setBool("isLogin", true);
          prefs.setString("userID", response.data!.userId!);
          prefs.setString("role", response.data!.role!);
          prefs.setString("name", response.data!.name!);
          prefs.setString("empId", response.data!.empId!);
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
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // login api
  // sendOTPAPI
  Future<void> sendOTPAPI(BuildContext context, String phoneNumber) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.sendOtp),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      request.fields['mobile'] =  phoneNumber;
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(Urls.sendOtp);
        Map<String, dynamic> map = convert.jsonDecode(event);
        ForgotPasswordModel response = await ForgotPasswordModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          Navigator.of(context).pop();
          await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 750),
                isIos: true,
                child: Otp(phoneNumber: phoneNumber),
              )
          );
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // sendOTPAPI
}
