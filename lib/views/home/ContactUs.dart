// ignore_for_file: use_build_context_synchronously, sort_child_properties_last


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(AppStrings.contactUs,style: TextStyle(color: AppColors.white,),),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Admin Support :",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => _makePhoneCall("+918819888032"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("+91 8819888032",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => _makePhoneCall("07314681395"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("07314681395",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => sendMessage("+918819888032",""),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/whatsapp.svg",width: 22.0,),
                          const SizedBox(width: 5.0,),
                          const Expanded(child: Text("+91 8819888032",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => sendMailto("indore.propertymaster@gmail.com"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.mail,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("indore.propertymaster@gmail.com",),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sales Support :",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => _makePhoneCall("+919644888813"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("+91 9644888813",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => _makePhoneCall("07314681395"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.call,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("07314681395",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => sendMessage("+919644888813",""),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/whatsapp.svg",width: 22.0,),
                          const SizedBox(width: 5.0,),
                          const Expanded(child: Text("+91 9644888813",),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => sendMailto("contact@propertymaster.co.in"),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.mail,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("contact@propertymaster.co.in",),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Registered Address :",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  InkWell(
                    onTap: () => openMaps(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,color: AppColors.colorSecondaryDark,),
                          SizedBox(width: 5.0,),
                          Expanded(child: Text("222- Singapore Gold City -1 ,Oppo Vistara Township Ab Bypass Road Indore",),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
