import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  var phoneNumberController = TextEditingController();

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
                          AppStrings.otpVerification,
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
              const SizedBox(height: 10.0,),
              const Text(
                  AppStrings.verificationTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 35.0,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 20.0,),
              OtpTextField(
                obscureText: true,
                numberOfFields: 4,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                borderColor: AppColors.colorSecondaryDark,
                //set to true to show as box or false to show as dash
                showFieldAsBox: false,
                onCodeChanged: (String code) {
                  print('code is : $code');
                },
                onSubmit: (String verificationCode){
                  print('verificationCode is $verificationCode');
                }, // end onSubmit
              ),
              const SizedBox(height: 20.0,),
              const Text(AppStrings.didNotReceive,style: TextStyle(fontSize: 12.0),),
              const SizedBox(height: 20.0,),
              const Text(AppStrings.resendOTP,style: TextStyle(color: AppColors.colorSecondaryDark),),
              const SizedBox(height: 30.0,),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.rightToLeftWithFade,
                    //       alignment: Alignment.topCenter,
                    //       duration: const Duration(milliseconds: 750),
                    //       isIos: true,
                    //       child: Dashboard(bottomIndex: 0),
                    //     ),
                    //   (route) => false,
                    // );
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.verifyAndContinue,
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
}
