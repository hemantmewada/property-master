// ignore_for_file: use_build_context_synchronously, sort_child_properties_last


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';
import 'package:propertymaster/views/my-account/ProfileAndKyc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Urls.dart' ;
import 'package:dio/dio.dart';
// apis

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late String userID;
  String role = '';
  String name = '';
  String empId = '';
  String email = '';
  String profileImage = "";
  bool isLoading = true;


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
    propertyDataAPI(context);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(AppStrings.myAccount,style: TextStyle(color: AppColors.white,),),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  CircleAvatar(
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child:
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
                  const SizedBox(height: 10.0),
                  Text(
                    name,
                    style: const TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                  ),
                  Text(
                    email,
                    style: const TextStyle(color: AppColors.black,),
                  ),
                  Text(
                    empId,
                    style: const TextStyle(color: AppColors.black,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () => navigateTo(context, const ProfileAndKyc(),),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 58.0,
                margin: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0,),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                decoration: myBoxDecoration(),
                child: const Row(
                  children: [
                    Icon(Icons.account_circle, size: 30.0, color: AppColors.white,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(
                        color: AppColors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Personal Profile & KYC',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {

              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 58.0,
                margin: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0,),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                decoration: myBoxDecoration(),
                child: const Row(
                  children: [
                    Icon(Icons.newspaper_rounded, size: 30.0, color: AppColors.white,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(
                        color: AppColors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'ID Card',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {

              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 58.0,
                margin: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0,),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                decoration: myBoxDecoration(),
                child: const Row(
                  children: [
                    Icon(Icons.payment, size: 30.0, color: AppColors.white,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(
                        color: AppColors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Payment',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () {

              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 58.0,
                margin: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0,),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                decoration: myBoxDecoration(),
                child: const Row(
                  children: [
                    Icon(Icons.lock, size: 30.0, color: AppColors.white,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(
                        color: AppColors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLogin", false);
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
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 58.0,
                margin: const EdgeInsets.only(top: 10.0,left: 10.0, right: 10.0,),
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                decoration: myBoxDecoration(),
                child: const Row(
                  children: [
                    Icon(Icons.logout_rounded, size: 30.0, color: AppColors.white,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(
                        color: AppColors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,color: AppColors.white,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  myBoxDecoration(){
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: AppColors.colorSecondary,
      boxShadow: [
        BoxShadow(
          color: Color(0xFFe6e6e6),
          offset: Offset(
            0.0,
            0.0,
          ),
          blurRadius: 8.0,
          spreadRadius: 0,
        ),
      ],
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    print('phoneNumber is ------------------------$phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> sendMessage(String phoneNumber,String message) async {
    // await launch("https://wa.me/${phoneNumber}?text=Hello");
    String appUrl;
    if (Platform.isAndroid) {
      appUrl = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
    } else {
      appUrl = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.parse(message)}";
    }

    await launch(appUrl);
  }

  Future<void> sendMailto(email) async {
    final String emailSubject = "";
    final Uri parsedMailto = Uri.parse("mailto:<$email>?subject=$emailSubject");

    if (!await launchUrl(
      parsedMailto,
      mode: LaunchMode.externalApplication,
    )) {
      throw "error";
    }
  }

  Future<void> openMaps() async {
    const url = "https://maps.app.goo.gl/WmexjF7Cz3zNHoEb7";
    await launch(url);
  }
  Future<void> propertyDataAPI(BuildContext context) async {
    try{
      setState(() => isLoading = true);
      var url = '${Urls.propertyDataUrl}?user_id=$userID';
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      setState(() => isLoading = false);
      if (responseDio.statusCode == 200) {
        print("propertyDataAPI ---- $url");
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
}
