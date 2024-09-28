import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/dashboard/ManageLead.dart';
import 'package:propertymaster/views/resale-deal/MyProperty.dart';
import 'package:propertymaster/views/resale-deal/UsersProperty.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:propertymaster/models/NotificationBirthdayModel.dart';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String userID;
  late String role;
  ScrollController scrollController = ScrollController();
  List<Data>? birthdaysList = [];

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
    print("userID ----------$userID");
    print("userID ----------$role");
    birthdaysAPI();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: Text(AppStrings.birthdays,style: const TextStyle(color: AppColors.white,),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: birthdaysList?.length ?? 0,
              controller: scrollController,
              itemBuilder: (BuildContext context,int index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () => navigateTo(context, ImagePreviewScreen(imageUrl: birthdaysList![index].profileImg!),),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      child: CachedNetworkImage(
                                        imageUrl: birthdaysList![index].profileImg!,
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,),),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0,),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${birthdaysList![index].name!}'s birthday today.",style: const TextStyle(fontSize: 16.0,),),
                                          Text(Utilities().DatefomatForBirthday("yyyy-MM-dd", birthdaysList![index].dob!)),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15.0,),
        ],
      ),
    );
  }
  // addFollowUp Modal start
  Future<void> _makePhoneCall(String phoneNumber) async {
    print('phoneNumber is ------------------------$phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> sendMessage(String phoneNumber,String message) async {
    String appUrl;
    if (Platform.isAndroid) {
      appUrl = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
    } else {
      appUrl = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.parse(message)}";
    }

    // if (await launch(appUrl)) {
    await launch(appUrl);
    // } else {
    //   throw 'Could not launch $appUrl';
    // }
  }
  // employee list api
  Future<void> birthdaysAPI() async {
    Loader.ProgressloadingDialog(context, true);
    const url = Urls.birthdaysUrl;
    try {
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print("birthdaysAPI---------${url}");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        NotificationBirthdayModel response = NotificationBirthdayModel.fromJson(map);
        birthdaysList!.clear();
        birthdaysList = response.data;
        setState(() {});
        if(birthdaysList!.isEmpty){
          Utilities().toast(response.message);
        }
      }
    } on DioError catch (error) {
      Loader.ProgressloadingDialog(context, false);

    } catch (_) {
      Loader.ProgressloadingDialog(context, false);

    }
  }
// employee list api
}