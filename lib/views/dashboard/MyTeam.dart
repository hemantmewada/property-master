// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:propertymaster/models/EmployeeCountModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/LeadBox.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/my-team/TeamList.dart';
// apis
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class MyTeam extends StatefulWidget {
  String userID;
  String role;
  MyTeam({super.key,required this.userID,required this.role});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  String type = "all";
  Data? employeeCount;
  var searchController = TextEditingController();
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
    // Sr Business Manager, Manager, Business Partner
    // role = 'Business Partner';
    print("widget.userID--------{${widget.userID}}");
    print("widget.role--------{${widget.role}}");
    employeeCountAPI(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.teamDashboard,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: widget.role == null ? const Center() : widget.role == "Full Time Business Partner" || widget.role == "Part Time Business Partner"
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppStrings.serviceNotAvailable,textAlign: TextAlign.center),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      MyTeamLeadBox(
                        count: employeeCount == null ? '0' : employeeCount!.totaluser.toString(),
                        pendingCount: "0",
                        heading: AppStrings.totalUser,
                        primaryColor: AppColors.colorSecondary,
                        secondaryColor: AppColors.colorSecondaryDashboard,
                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                        pageLink: TeamList(heading: AppStrings.totalUser,type: "total_user"),
                      ),
                      const SizedBox(width: 10.0,),
                      MyTeamLeadBox(
                        count: employeeCount == null ? '0' : employeeCount!.todayuser.toString(),
                        pendingCount: "0",
                        heading: AppStrings.todayUser,
                        primaryColor: AppColors.colorPrimaryDark,
                        secondaryColor: AppColors.primaryColorLight,
                        icon: const Icon(FontAwesomeIcons.userClock,color: AppColors.white),
                        pageLink: TeamList(heading: AppStrings.todayUser,type: "today_user"),
                      ),
                      const SizedBox(width: 10.0,),
                      MyTeamLeadBox(
                        count: employeeCount == null ? '0' : employeeCount!.activeUser.toString(),
                        pendingCount: "0",
                        heading: AppStrings.activeUser,
                        primaryColor: AppColors.orange,
                        secondaryColor: AppColors.orangeLight,
                        icon: const Icon(FontAwesomeIcons.userCheck,color: AppColors.white),
                        pageLink: TeamList(heading: AppStrings.activeUser,type: "active_user"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  widget.role == "Sr Business Manager" ?
                      Column(
                        children: [
                          Row(
                            children: [
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.businessManager.toString(),
                                pendingCount: "0",
                                heading: AppStrings.businessManager,
                                primaryColor: AppColors.parrotColorDark,
                                secondaryColor: AppColors.parrotColorLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.businessManager,type: "bm"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.sBusinessPartner.toString(),
                                pendingCount: "0",
                                heading: AppStrings.srBP,
                                primaryColor: AppColors.green,
                                secondaryColor: AppColors.greenLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.srBP,type: "sbp"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.ftBusinessPartner.toString(),
                                pendingCount: "0",
                                heading: AppStrings.fullTimeBP,
                                primaryColor: AppColors.orange,
                                secondaryColor: AppColors.orangeLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.fullTimeBP,type: "ftbp"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.ptBusinessPartner.toString(),
                                pendingCount: "0",
                                heading: AppStrings.partTimeBP,
                                primaryColor: AppColors.parrotColorDark,
                                secondaryColor: AppColors.parrotColorLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.partTimeBP,type: "ptbp"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.completeKycUser.toString(),
                                pendingCount: "0",
                                heading: AppStrings.completeKYCUser,
                                primaryColor: AppColors.dark_grey,
                                secondaryColor: AppColors.light_grey,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.completeKYCUser,type: "complete_kyc"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.pendingKycUser.toString(),
                                pendingCount: "0",
                                heading: AppStrings.pendingKYCUser,
                                primaryColor: AppColors.dark_part_time_BP,
                                secondaryColor: AppColors.part_time_BP,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.pendingKYCUser,type: "pending_kyc"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0,),
                          Row(
                            children: [
                              MyTeamLeadBox(
                                count: employeeCount == null ? '0' : employeeCount!.rejectUser.toString(),
                                pendingCount: "0",
                                heading: AppStrings.rejectUser,
                                primaryColor: AppColors.voilet,
                                secondaryColor: AppColors.voiletLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.rejectUser,type: "reject_user"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                // count: employeeCount == null ? '0' : employeeCount!.ourProjects.toString(),
                                count: '0',
                                pendingCount: "0",
                                heading: AppStrings.ourProjects,
                                primaryColor: AppColors.carrotColorDark,
                                secondaryColor: AppColors.carrotColorLight,
                                icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                pageLink: TeamList(heading: AppStrings.ourProjects,type: "project"),
                              ),
                              const SizedBox(width: 10.0,),
                              MyTeamLeadBox(
                                isAvailable: false,
                              ),
                            ],
                          ),
                        ],
                      ) :
                  widget.role == "Manager" ?
                      Column(
                            children: [
                              Row(
                                children: [
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.sBusinessPartner.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.srBP,
                                    primaryColor: AppColors.green,
                                    secondaryColor: AppColors.greenLight,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.totalUser,type: "total_user"),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.ftBusinessPartner.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.fullTimeBP,
                                    primaryColor: AppColors.orange,
                                    secondaryColor: AppColors.orangeLight,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.fullTimeBP,type: "ftbp"),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.ptBusinessPartner.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.partTimeBP,
                                    primaryColor: AppColors.parrotColorDark,
                                    secondaryColor: AppColors.parrotColorLight,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.partTimeBP,type: "ptbp"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.completeKycUser.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.completeKYCUser,
                                    primaryColor: AppColors.dark_grey,
                                    secondaryColor: AppColors.light_grey,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.completeKYCUser,type: "complete_kyc"),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.pendingKycUser.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.pendingKYCUser,
                                    primaryColor: AppColors.dark_part_time_BP,
                                    secondaryColor: AppColors.part_time_BP,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.pendingKYCUser,type: "pending_kyc"),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    count: employeeCount == null ? '0' : employeeCount!.rejectUser.toString(),
                                    pendingCount: "0",
                                    heading: AppStrings.rejectUser,
                                    primaryColor: AppColors.voilet,
                                    secondaryColor: AppColors.voiletLight,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.rejectUser,type: "reject_user"),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  MyTeamLeadBox(
                                    count: '0',
                                    pendingCount: "0",
                                    heading: AppStrings.ourProjects,
                                    primaryColor: AppColors.carrotColorDark,
                                    secondaryColor: AppColors.carrotColorLight,
                                    icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                    pageLink: TeamList(heading: AppStrings.ourProjects,type: "project"),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    isAvailable: false,
                                  ),
                                  const SizedBox(width: 10.0,),
                                  MyTeamLeadBox(
                                    isAvailable: false,
                                  ),
                                ],
                              ),
                            ],
                        ) :
                  widget.role == "Business Partner" ?
                      Column(
                                children: [
                                  Row(
                                    children: [
                                      MyTeamLeadBox(
                                        count: employeeCount == null ? '0' : employeeCount!.ftBusinessPartner.toString(),
                                        pendingCount: "0",
                                        heading: AppStrings.fullTimeBP,
                                        primaryColor: AppColors.orange,
                                        secondaryColor: AppColors.orangeLight,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.fullTimeBP,type: "ftbp"),
                                      ),
                                      const SizedBox(width: 10.0,),
                                      MyTeamLeadBox(
                                        count: employeeCount == null ? '0' : employeeCount!.ptBusinessPartner.toString(),
                                        pendingCount: "0",
                                        heading: AppStrings.partTimeBP,
                                        primaryColor: AppColors.parrotColorDark,
                                        secondaryColor: AppColors.parrotColorLight,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.partTimeBP,type: "ptbp"),
                                      ),
                                      const SizedBox(width: 10.0,),
                                      MyTeamLeadBox(
                                        count: employeeCount == null ? '0' : employeeCount!.completeKycUser.toString(),
                                        pendingCount: "0",
                                        heading: AppStrings.completeKYCUser,
                                        primaryColor: AppColors.dark_grey,
                                        secondaryColor: AppColors.light_grey,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.completeKYCUser,type: "complete_kyc"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      MyTeamLeadBox(
                                        count: employeeCount == null ? '0' : employeeCount!.pendingKycUser.toString(),
                                        pendingCount: "0",
                                        heading: AppStrings.pendingKYCUser,
                                        primaryColor: AppColors.dark_part_time_BP,
                                        secondaryColor: AppColors.part_time_BP,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.pendingKYCUser,type: "pending_kyc"),
                                      ),
                                      const SizedBox(width: 10.0,),
                                      MyTeamLeadBox(
                                        count: employeeCount == null ? '0' : employeeCount!.rejectUser.toString(),
                                        pendingCount: "0",
                                        heading: AppStrings.rejectUser,
                                        primaryColor: AppColors.voilet,
                                        secondaryColor: AppColors.voiletLight,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.rejectUser,type: "reject_user"),
                                      ),
                                      const SizedBox(width: 10.0,),
                                      MyTeamLeadBox(
                                        count: '0',
                                        pendingCount: "0",
                                        heading: AppStrings.ourProjects,
                                        primaryColor: AppColors.carrotColorDark,
                                        secondaryColor: AppColors.carrotColorLight,
                                        icon: const Icon(FontAwesomeIcons.user,color: AppColors.white),
                                        pageLink: TeamList(heading: AppStrings.ourProjects,type: "project"),
                                      ),
                                    ],
                                  ),
                                ],
                            ) :
                  Container(),
                ],
            ),
      ),
    );
  }
  // employee count api
  Future<void> employeeCountAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try{
      const url = Urls.employeeCountUrl;
      var formData = FormData.fromMap({"user_id": widget.userID});
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        EmployeeCountModel res = EmployeeCountModel.fromJson(map);
        if (res.status == true) {
          employeeCount = res.data;
          setState(() {});
        } else {
          Utilities().toast(res.message);
        }
      }
      return;
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // employee count api
}