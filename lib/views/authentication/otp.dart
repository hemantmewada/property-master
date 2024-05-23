// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:propertymaster/models/ForgotPasswordModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/authentication/SetNewPassword.dart';
// apis
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Urls.dart';
// apis

class Otp extends StatefulWidget {
  String? phoneNumber;
  Otp({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('widget.phoneNumber : ${widget.phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.otpVerification,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 56.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, top: 20.0),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    AppStrings.verifyYourNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 13.0, left: 20.0, right: 20.0),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    AppStrings.enterYourOtpBelow,
                    style: TextStyle(
                      color: AppColors.colorSecondary,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 67.0),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Color(0xff254d71),
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '•',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {},
                  backgroundColor: Colors.transparent,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    fieldHeight: 45,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    inactiveColor: AppColors.colorSecondary,
                    inactiveFillColor: AppColors.primaryColorLight,
                    borderWidth: 1.2,
                    activeColor: AppColors.colorPrimaryDark,
                    selectedColor:
                    AppColors.colorPrimary, // single box border color
                  ),
                  cursorColor: AppColors.colorPrimary,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  errorAnimationController: errorController,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 13.0, left: 20.0, right: 20.0),
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: InkWell(
                  onTap: () {
                    String otp = otpController.text;
                    if (otp.isEmpty) {
                      Utilities().toast(AppStrings.otpToast);
                    } else if (otp.length != 6) {
                      Utilities().toast(AppStrings.otpValidToast);
                    } else {
                      otpVerificationAPI(context, otp);
                    }
                  },
                  child: Align(
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
              Container(
                padding: EdgeInsets.only(top: 17.0),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    AppStrings.didntReceiveCode,
                    style: TextStyle(
                      color: AppColors.colorSecondary,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await sendOTPAPI(context, widget.phoneNumber!);
                },
                child: Center(
                  child: Text(
                    AppStrings.resendANewCode,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
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
  // otpVerificationAPI
  Future<void> otpVerificationAPI(BuildContext context, String otp) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.otpVerfication),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      request.fields['mobile'] =  widget.phoneNumber!;
      request.fields['otp'] =  otp;
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        Map<String, dynamic> map = convert.jsonDecode(event);
        ForgotPasswordModel response = await ForgotPasswordModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 750),
                isIos: true,
                child: ResetPassword(phoneNumber: widget.phoneNumber),
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
  // otpVerificationAPI
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
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // sendOTPAPI
}
