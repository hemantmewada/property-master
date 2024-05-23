// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/ForgotPasswordModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propertymaster/models/LoginModel.dart';
// apis

class ResetPassword extends StatefulWidget {
  String? phoneNumber;
  ResetPassword({super.key, required this.phoneNumber});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('widget.phoneNumber : ${widget.phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.resetPassword,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              // const SizedBox(height: 10.0,),
              Center(child: Image.asset('assets/images/logo.png',width: 150.0,)),
              // const SizedBox(height: 10.0,),
              const Center(
                child: Text(
                  AppStrings.resetYourPassword,
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    // fontSize: 30.0,
                    color: AppColors.black,
                  ),
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
                              controller: confirmPasswordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(
                                fontSize: 14.0, color: AppColors.black,
                              ),
                              cursorColor: AppColors.textColorGrey,
                              decoration: const InputDecoration(
                                hintText: AppStrings.confirmPassword,
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
                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;
                    if(password.isEmpty){
                      Utilities().toast(AppStrings.passwordToast);
                    } else if(confirmPassword.isEmpty){
                      Utilities().toast(AppStrings.cofirmPasswordToast);
                    } else if(password != confirmPassword){
                      Utilities().toast(AppStrings.passwordcofirmPasswordToast);
                    } else{
                      await resetPasswordAPI(context, password, confirmPassword);
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
  // resetPasswordAPI
  Future<void> resetPasswordAPI(BuildContext context, String password, String confirmPassword) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.updatePassword),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      request.fields['mobile'] =  widget.phoneNumber!;
      request.fields['password'] =  password;
      request.fields['confirmPassword'] =  confirmPassword;
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        Map<String, dynamic> map = convert.jsonDecode(event);
        ForgotPasswordModel response = await ForgotPasswordModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 750),
              isIos: true,
              child: const LoginRegisteredUser(),
            ),
            (route) => false,
          );
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // resetPasswordAPI
}
