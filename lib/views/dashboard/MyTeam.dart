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
  MyTeam({super.key, required this.userID, required this.role});

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
    Future.delayed(Duration.zero, () {
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
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        title: const Text(
          AppStrings.teamDashboard,
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      body: widget.role == null
          ? const Center()
          : widget.role == ApiVarConsts.admin || widget.role == ApiVarConsts.srBusinessManager || widget.role == ApiVarConsts.manager
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTeamLeadBox(
                            count: employeeCount == null
                                ? '0'
                                : employeeCount!.totaluser.toString(),
                            pendingCount: "0",
                            heading: "Total\nUser",
                            primaryColor: AppColors.colorSecondary,
                            secondaryColor: AppColors.colorSecondaryDashboard,
                            icon: const Icon(FontAwesomeIcons.user,
                                color: AppColors.white),
                            pageLink: TeamList(
                                heading: AppStrings.totalUser,
                                type: "total_user"),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          MyTeamLeadBox(
                            count: employeeCount == null
                                ? '0'
                                : employeeCount!.todayuser.toString(),
                            pendingCount: "0",
                            heading: "Today\nUser",
                            primaryColor: AppColors.colorPrimaryDark,
                            secondaryColor: AppColors.primaryColorLight,
                            icon: const Icon(FontAwesomeIcons.userClock,
                                color: AppColors.white),
                            pageLink: TeamList(
                                heading: AppStrings.todayUser,
                                type: "today_user"),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          widget.role == ApiVarConsts.srBusinessManager || widget.role == ApiVarConsts.admin
                              ? MyTeamLeadBox(
                                  count: employeeCount == null
                                      ? '0'
                                      : employeeCount!.businessManager
                                          .toString(),
                                  pendingCount: "0",
                                  heading: "Business\nManager",
                                  primaryColor: AppColors.voilet,
                                  secondaryColor: AppColors.voiletLight,
                                  icon: const Icon(FontAwesomeIcons.user,
                                      color: AppColors.white),
                                  pageLink: TeamList(
                                      heading: AppStrings.businessManager,
                                      type: "bm"),
                                )
                              : widget.role == "Manager"
                                  ? MyTeamLeadBox(
                                      count: employeeCount == null
                                          ? '0'
                                          : employeeCount!.sBusinessPartner
                                              .toString(),
                                      pendingCount: "0",
                                      heading: "Sr. Business\nPartner",
                                      primaryColor: AppColors.green,
                                      secondaryColor: AppColors.greenLight,
                                      icon: const Icon(FontAwesomeIcons.user,
                                          color: AppColors.white),
                                      pageLink: TeamList(
                                          heading: AppStrings.srBP,
                                          type: "sbp"),
                                    )
                                  : widget.role == "Business Partner"
                                      ? MyTeamLeadBox(
                                          count: employeeCount == null
                                              ? '0'
                                              : employeeCount!.ftBusinessPartner
                                                  .toString(),
                                          pendingCount: "0",
                                          heading: "Business\nPartner",
                                          primaryColor: AppColors.orange,
                                          secondaryColor: AppColors.orangeLight,
                                          icon: const Icon(
                                              FontAwesomeIcons.user,
                                              color: AppColors.white),
                                          pageLink: TeamList(
                                              heading: AppStrings.bp,
                                              type: "bp"),
                                        )
                                      : Container(),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      widget.role == ApiVarConsts.srBusinessManager || widget.role == ApiVarConsts.admin
                          ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTeamLeadBox(
                                      count: employeeCount == null
                                          ? '0'
                                          : employeeCount!.sBusinessPartner
                                              .toString(),
                                      pendingCount: "0",
                                      heading: "Sr. Business\nPartner",
                                      primaryColor: AppColors.green,
                                      secondaryColor: AppColors.greenLight,
                                      icon: const Icon(FontAwesomeIcons.user,
                                          color: AppColors.white),
                                      pageLink: TeamList(
                                          heading: AppStrings.srBP,
                                          type: "sbp"),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    MyTeamLeadBox(
                                      count: employeeCount == null
                                          ? '0'
                                          : employeeCount!.ftBusinessPartner
                                              .toString(),
                                      pendingCount: "0",
                                      heading: "Business\nPartner",
                                      primaryColor: AppColors.orange,
                                      secondaryColor: AppColors.orangeLight,
                                      icon: const Icon(FontAwesomeIcons.user,
                                          color: AppColors.white),
                                      pageLink: TeamList(
                                          heading: AppStrings.bp, type: "bp"),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    MyTeamLeadBox(isAvailable: false),
                                  ],
                                ),
                              ],
                            )
                          : widget.role == "Manager"
                              ? Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyTeamLeadBox(
                                          count: employeeCount == null
                                              ? '0'
                                              : employeeCount!.ftBusinessPartner
                                                  .toString(),
                                          pendingCount: "0",
                                          heading: "Business\nPartner",
                                          primaryColor: AppColors.orange,
                                          secondaryColor: AppColors.orangeLight,
                                          icon: const Icon(
                                              FontAwesomeIcons.user,
                                              color: AppColors.white),
                                          pageLink: TeamList(
                                              heading: AppStrings.bp,
                                              type: "bp"),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        MyTeamLeadBox(
                                          isAvailable: false,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        MyTeamLeadBox(
                                          isAvailable: false,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: Text(
                            "KYC Verified Partner",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTeamLeadBox(
                                count: employeeCount == null
                                    ? '0'
                                    : employeeCount!.completeKycUser.toString(),
                                pendingCount: "0",
                                heading: "Complete KYC\nUser",
                                primaryColor: AppColors.dark_grey,
                                secondaryColor: AppColors.light_grey,
                                icon: const Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.white,
                                ),
                                pageLink: TeamList(
                                    heading: AppStrings.completeKYCUser,
                                    type: "complete_kyc"),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              MyTeamLeadBox(
                                isAvailable: false,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              MyTeamLeadBox(
                                count: employeeCount == null
                                    ? '0'
                                    : employeeCount!.pendingKycUser.toString(),
                                pendingCount: "0",
                                heading: "Pending KYC\nUser",
                                primaryColor: AppColors.colorPrimaryDark,
                                secondaryColor: AppColors.primaryColorLight,
                                icon: const Icon(
                                  Icons.verified_outlined,
                                  color: AppColors.white,
                                ),
                                pageLink: TeamList(
                                    heading: AppStrings.pendingKYCUser,
                                    type: "pending_kyc"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(AppStrings.serviceNotAvailable,
                        textAlign: TextAlign.center),
                  ),
                ),
    );
  }

  // employee count api
  Future<void> employeeCountAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.employeeCountUrl;
      var formData = FormData.fromMap({"user_id": widget.userID});
      final responseDio = await Dio().post(
        url,
        data: formData,
      );
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);
        print(formData.fields);
        Map<String, dynamic> map =
            (responseDio.data as Map).cast<String, dynamic>();
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
