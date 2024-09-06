import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/dashboard/ManageLead.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:propertymaster/models/EmployeeListModel.dart';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class TeamList extends StatefulWidget {
  String type;
  String heading;
  TeamList({super.key,required this.type,required this.heading});

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  late String userID;
  late String role;
  ScrollController scrollController = ScrollController();
  List<Data>? employeeList = [];

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
    employeeListAPI();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: Text(widget.heading,style: const TextStyle(color: AppColors.white,),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: employeeList?.length ?? 0,
              controller: scrollController,
              itemBuilder: (BuildContext context,int index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                  // margin: const EdgeInsets.only(bottom: 8.0,),
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
                                    onTap: () => navigateTo(context, ImagePreviewScreen(imageUrl: employeeList![index].profileImg!),),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(5.0),),
                                        image: DecorationImage(
                                          image: NetworkImage(employeeList![index].profileImg!),
                                          fit: BoxFit.cover,
                                        ),
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
                                          Text(employeeList![index].name!,style: const TextStyle(fontSize: 16.0,),),
                                          Text(employeeList![index].role == "Business Partner" ? "Sr Business Partner" : employeeList![index].role!),
                                          Text(
                                            employeeList![index].mobile!,
                                            style: const TextStyle(fontSize: 16.0,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(employeeList![index].empId!,),
                                          const SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => _makePhoneCall(employeeList![index].mobile!),
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 5.0,),
                                                  child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                                                ),
                                              ),
                                              const SizedBox(width: 10.0,),
                                              InkWell(
                                                onTap: () => sendMessage('+91${employeeList![index].mobile!}','Hi, How can i help you.'),
                                                child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => navigateTo(context, ManageLead(userID: employeeList![index].userId!, role: employeeList![index].role!)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(Utilities().DatefomatToOnlyDate2("yyyy-MM-dd HH:mm:ss",employeeList![index].registerDateTime!)),
                            ),
                            Row(
                              children: [
                                const Text(AppStrings.totalLeads,style: TextStyle(fontSize: 16.0,),),
                                const SizedBox(width: 5.0,),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0,),
                                  decoration: const BoxDecoration(
                                    color: AppColors.colorSecondary,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0),
                                      bottomLeft: Radius.circular(5.0),
                                      bottomRight: Radius.circular(5.0),
                                      topRight: Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Text(employeeList![index].totalLeads.toString(),style: const TextStyle(color: AppColors.white,fontSize: 16.0,),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5.0,),
                    ],
                  ),
                );
                return Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                  // margin: const EdgeInsets.only(bottom: 8.0,),
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
                                    onTap: () => navigateTo(context, ImagePreviewScreen(imageUrl: "https://propertymaster.co.in/propertymaster-admin/assets/our-space/accounts.jpg"),),
                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                      NetworkImage("https://propertymaster.co.in/propertymaster-admin/assets/our-space/accounts.jpg"),
                                      // NetworkImage(employeeList![index].profileImg!)),
                                      backgroundColor: Colors.transparent,
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
                                          Text(Utilities().DatefomatToOnlyDate2("yyyy-MM-dd HH:mm:ss",employeeList![index].registerDateTime!)),
                                          const SizedBox(height: 10.0,),
                                          Text(
                                            employeeList![index].mobile!,
                                            style: const TextStyle(fontSize: 16.0,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(employeeList![index].empId!,),
                                          const SizedBox(height: 10.0,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => _makePhoneCall(employeeList![index].mobile!),
                                                child: Container(
                                                  margin: const EdgeInsets.only(top: 5.0,),
                                                  child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  sendMessage('+91${employeeList![index].mobile!}','Hi, How can i help you.');
                                                },
                                                child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0,),
                      InkWell(
                        onTap: () => navigateTo(context, ManageLead(userID: employeeList![index].userId!, role: employeeList![index].role!)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employeeList![index].name!,
                                    style: const TextStyle(fontSize: 16.0,),
                                  ),
                                  Text(employeeList![index].role == "Business Partner" ? "Sr Business Partner" : employeeList![index].role!),
                                ],
                              ),
                            ),
                            const Expanded(child: Text(AppStrings.totalLeads,style: TextStyle(fontSize: 16.0,),)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0,),
                              decoration: const BoxDecoration(
                                color: AppColors.colorSecondary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                              ),
                              child: Text(employeeList![index].totalLeads.toString(),style: const TextStyle(color: AppColors.white,fontSize: 16.0,),),
                            ),
                          ],
                        ),
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
  Future<void> employeeListAPI() async {
    Loader.ProgressloadingDialog(context, true);
    const url = Urls.employeeListListUrl;
    try {
      var formData = FormData.fromMap({
        "user_id" :  userID,
        "type" :  widget.type,
      });
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        EmployeeListModel response = EmployeeListModel.fromJson(map);
        employeeList!.clear();
        employeeList = response.data;
        setState(() {});
        if(employeeList!.isEmpty){
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