// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/models/MobileNoExistModel.dart';
import 'package:propertymaster/models/UpdateProfileImageModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/views/home/ContactUs.dart';
import 'package:propertymaster/views/home/NotificationScreen.dart';
import 'package:propertymaster/views/home/LayoutMap.dart';
import 'package:propertymaster/views/home/PressAndNews.dart';
import 'package:propertymaster/views/my-account/MyAccount.dart';
import 'package:propertymaster/views/lead-management/AddLead.dart';
import 'package:propertymaster/views/home/HomeDashboardPropertySlider.dart';
import 'package:propertymaster/views/lead-management/ManageLeadList.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';
import 'package:propertymaster/views/home/HomeSlider.dart';
import 'package:propertymaster/views/my-account/ProfileAndKyc.dart';
import 'package:propertymaster/views/my-team/BusinessPartnerRegistration.dart';
import 'package:propertymaster/views/my-team/TeamList.dart';
import 'package:propertymaster/views/resale-deal/PostProperty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import "package:share_plus/share_plus.dart";
import 'package:path_provider/path_provider.dart';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart' ;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:mime/mime.dart'; // To detect file types

// apis

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  late String userID;
  String role = '';
  String name = '';
  String empId = '';
  String type = "all";
  String profileImage = "";
  int todayWorkCount = 0;
  int totalBPCount = 0;
  int hotListedCount = 0;
  int totalPropertyCount = 0;
  List<HomeSlides>? imgList = [];
  List<String> jobTypeList1 = ['Select Job Type','Sr Business Partner','Business Partner'];
  List<String> jobTypeList2 = ['Select Job Type','Business Partner'];
  List<HotListedProperty>? postPropertyList = [];

  int daysLeft = 0;
  String daysLeftMessage = "";


  final ImagePicker imagePicker = ImagePicker();
  XFile? photoController;
  var bytes;


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
    print('my userID is >>>>> {$userID}');
    print('my empId is >>>>> {$empId}');
    print('my role is >>>>> {$role}');
    propertyDataAPI(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      key: _scaffoldkey,
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: AppColors.colorSecondaryLight,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 20.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => bottomProfileSelection(context),
                          child: CircleAvatar(
                            radius: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60.0),
                              // radius: 48,
                              child: photoController != null ?
                              Image.file(
                                File(photoController!.path),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ) :
                              Image.network(
                                profileImage,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // const Image(image: AssetImage("assets/images/user.png"),width: 50.0,),
                        const SizedBox(height: 5.0,),
                        Text(name,style: const TextStyle(color: AppColors.white)),
                        Text(empId,style: const TextStyle(color: AppColors.white)),
                        Text(role == "Business Partner" ? "Sr Business Partner" : role,style: const TextStyle(color: AppColors.white)),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_outlined,color: AppColors.colorSecondaryDark,),
                    title: const Text("Home"),
                    onTap: () => _scaffoldkey.currentState!.closeDrawer(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle_outlined,color: AppColors.colorSecondaryDark,),
                    title: const Text("My Profile"),
                    onTap: () => navigateTo(context, const MyAccount()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_settings_sharp,color: AppColors.colorSecondaryDark,),
                    title: const Text("Videos"),
                    onTap: () => openPage(videoUrl),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline,color: AppColors.colorSecondaryDark,),
                    title: const Text("About Us"),
                    onTap: () => openPage(aboutUsUrl),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone,color: AppColors.colorSecondaryDark,),
                    title: const Text("Contact Us"),
                    onTap: () => navigateTo(context, const ContactUs()),
                    // onTap: () => contactUsShowAlertDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.image_search,color: AppColors.colorSecondaryDark,),
                    title: const Text(AppStrings.searchLayoutMap),
                    onTap: () => navigateTo(context, const LayoutMap()),
                    // onTap: () => contactUsShowAlertDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.newspaper_rounded,color: AppColors.colorSecondaryDark,),
                    title: const Text(AppStrings.pressAndNews),
                    onTap: () => navigateTo(context, const PressAndNews()),
                  ),
                  role == "Sr Business Manager" || role == "Manager" ?
                  ListTile(
                    leading: const Icon(Icons.share,color: AppColors.colorSecondaryDark,),
                    title: const Text("Register Link For Sr BP"),
                    onTap: () => Share.share('https://propertymaster.co.in/propertymaster-admin/employee/usersadd?user_id=${userID}&job_type=Business%20Partner'),
                  ) :
                  Container(),
                  role == "Sr Business Manager" || role == "Manager" ?
                  ListTile(
                    leading: const Icon(Icons.share,color: AppColors.colorSecondaryDark,),
                    title: const Text("Register Link For BP"),
                    onTap: () => Share.share('https://propertymaster.co.in/propertymaster-admin/employee/usersadd?user_id=${userID}&job_type=Jr%20Business%20Partner'),
                  ) :
                  Container(),
                  ListTile(
                    leading: const Icon(Icons.logout,color: AppColors.colorSecondaryDark,),
                    title: const Text('Logout'),
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
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
                  child: Column(
                    children: <Widget>[
                      const Divider(),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: const BorderRadius.all(Radius.circular(5.0,),),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () => openPage(facebookUrl),
                              child: SvgPicture.asset('assets/icons/facebook.svg', width: 30.0,),
                            ),
                          ),
                          const SizedBox(width: 5.0,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: const BorderRadius.all(Radius.circular(5.0,),),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () => openPage(instagramUrl),
                              child: SvgPicture.asset('assets/icons/instagram.svg', width: 30.0,),
                            ),
                          ),
                          const SizedBox(width: 5.0,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent[100],
                              borderRadius: const BorderRadius.all(Radius.circular(5.0,),),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () => openPage(linkedinUrl),
                              child: SvgPicture.asset('assets/icons/linkedin.svg', width: 30.0,),
                            ),
                          ),
                          const SizedBox(width: 5.0,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: const BorderRadius.all(Radius.circular(5.0,),),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () => openPage(youtubeUrl),
                              child: SvgPicture.asset('assets/icons/youtube.svg', width: 30.0,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 140.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => _scaffoldkey.currentState!.openDrawer(),
                    child: SvgPicture.asset('assets/icons/menu.svg',color: AppColors.white,width: 25.0,height: 25.0,),
                  ),
                  const SizedBox(width: 10.0,),
                  const Expanded(
                    flex: 1,
                    child: Text(AppStrings.propertyMaster,style: TextStyle(fontSize: 20.0,color: AppColors.white,overflow: TextOverflow.ellipsis),),
                  ),
                  InkWell(
                    onTap: () => navigateTo(context, NotificationScreen()),
                    child: const Icon(Icons.notifications_rounded,color: AppColors.white,),
                  ),
                  const SizedBox(width: 10.0,),
                  InkWell(
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 750),
                            isIos: true,
                            child: const PostProperty(),
                          )
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(color: AppColors.white,borderRadius: BorderRadius.all(Radius.circular(50.0,),),),
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0,),
                        child: const Text(AppStrings.postProperty,style: TextStyle(fontSize: 12.0,),),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              searchContainer(context, totalPropertyCount, searchController, (value) => searchController.text = value, true),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorSecondaryLight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imgList!.isEmpty
                ? const SizedBox(
                    // height: 283.0,
                    height: 200.0,
                    child: Center(
                      child: Text(
                        'No data yet !',
                        style: TextStyle(color: AppColors.colorSecondary),
                      ),
                    ),
                  )
                : HomeSlider(imgList: imgList),
            // const SizedBox(height: 10.0,),
            postPropertyList!.isNotEmpty ?
            HomeDashboardPropertySlider(propertyList: postPropertyList!, userId: userID, role: role,) :
            const SizedBox(
              height: 214.0,
              child: Center(
                child: Text(
                  'No Hot Properties were found !',
                  style: TextStyle(color: AppColors.colorSecondary),
                ),
              ),
            ),
            // submit your lead button
            InkWell(
              highlightColor: AppColors.transparent,
              splashColor: AppColors.transparent,
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 750),
                      isIos: true,
                      child: const AddLead(),
                    )
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0,),
                // margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                width: MediaQuery.of(context).size.width * 1,
                height: 45.0,
                decoration: BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Text(
                  AppStrings.submitYourLead,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: Column(
                children: [
                  // side by side buttons

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 1,
                  //       child: InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               PageTransition(
                  //                 type: PageTransitionType.rightToLeftWithFade,
                  //                 alignment: Alignment.topCenter,
                  //                 duration: const Duration(milliseconds: 750),
                  //                 isIos: true,
                  //                 child: const BusinessPartnerRegistration(),
                  //               )
                  //           );
                  //         },
                  //         highlightColor: AppColors.transparent,
                  //         splashColor: AppColors.transparent,
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           margin: const EdgeInsets.all(5.0,),
                  //           // width: MediaQuery.of(context).size.width * 1,
                  //           height: 40.0,
                  //           decoration: BoxDecoration(
                  //             color: AppColors.colorSecondary,
                  //             borderRadius: BorderRadius.circular(50.0),
                  //           ),
                  //           child: const Text(
                  //             AppStrings.createABusinessPartner,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               fontSize: 12.0,
                  //               color: AppColors.white,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       flex: 1,
                  //       child: InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //               context,
                  //               PageTransition(
                  //                 type: PageTransitionType.rightToLeftWithFade,
                  //                 alignment: Alignment.topCenter,
                  //                 duration: const Duration(milliseconds: 750),
                  //                 isIos: true,
                  //                 child: const AddLead(),
                  //               )
                  //           );
                  //         },
                  //         highlightColor: AppColors.transparent,
                  //         splashColor: AppColors.transparent,
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           margin: const EdgeInsets.all(5.0,),
                  //           // width: MediaQuery.of(context).size.width * 1,
                  //           height: 40.0,
                  //           decoration: BoxDecoration(
                  //             color: AppColors.colorSecondary,
                  //             borderRadius: BorderRadius.circular(50.0),
                  //           ),
                  //           child: const Text(
                  //             AppStrings.submitYourLead,
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               fontSize: 12.0,
                  //               color: AppColors.white,
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  alignment: Alignment.topCenter,
                                  duration: const Duration(milliseconds: 750),
                                  isIos: true,
                                  child: ManageLeadList(title: AppStrings.todayWork,page: 'totaltodaywork', userID: userID, role: role,),
                                )
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: AppColors.carrotColorDark,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/bell.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(AppStrings.todayWork,style: TextStyle(color: AppColors.white,fontSize: 11.0,),),
                                        const SizedBox(height: 5.0,),
                                        Text(todayWorkCount.toString(),style: const TextStyle(color: AppColors.white,fontSize: 18.0,),                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0,),
                      Expanded(
                        child: role == "Sr Business Manager" || role == "Manager" || role == "Business Partner" ?
                        InkWell(
                          onTap: () => navigateTo(context, TeamList(heading: AppStrings.totalBP,type: "total_partner"),),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/users-alt.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(AppStrings.totalBP2,
                                          style: TextStyle(color: AppColors.white,fontSize: 11.0,),
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Text(totalBPCount.toString(),style: const TextStyle(color: AppColors.white,fontSize: 18.0,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ) :
                        const Center(),
                      ),
                      const SizedBox(width: 5.0,),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  alignment: Alignment.topCenter,
                                  duration: const Duration(milliseconds: 750),
                                  isIos: true,
                                  child: ManageLeadList(title: AppStrings.hotListed,page: 'totalhotlisted',userID: userID,role: role,),
                                )
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/fire.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(AppStrings.hotListed,style: TextStyle(color: AppColors.white,fontSize: 11.0,),),
                                        const SizedBox(height: 5.0,),
                                        Text(hotListedCount.toString(),style: const TextStyle(color: AppColors.white,fontSize: 18.0,),                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // create a business partner button
            if(role == "Sr Business Manager" || role == "Manager" || role == "Business Partner") InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 750),
                        isIos: true,
                        child: BusinessPartnerRegistration(userID: userID,role: role,jobTypeList: role == "Business Partner" ? jobTypeList2 : jobTypeList1),
                      )
                  );
                },
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0,),
                  child: BlinkText(
                    AppStrings.createABusinessPartner,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0,color: AppColors.colorSecondaryDark,fontWeight: FontWeight.w700,),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  // property data api
  // this api we have to change with dio
  Future<void> propertyDataAPI(BuildContext context) async {
    try{
      Loader.ProgressloadingDialog(context, true);
      var url = '${Urls.propertyDataUrl}?user_id=$userID';
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print("propertyDataAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        HomePageDataModel res = HomePageDataModel.fromJson(map);
        if (res.status == true) {
          imgList = res.homeSlides;
          profileImage = res.userData!.profileImg!;
          todayWorkCount = res.todayWorkCount!;
          totalBPCount = res.totalBusinessPartners!;
          hotListedCount = res.hotListedCount!;
          totalPropertyCount = res.totalCount!;
          postPropertyList = res.hotListedProperty!;
          daysLeft = res.daysDifference!;
          daysLeftMessage = res.alertmassage!;

          // for (var element in res.homeBanner!) {
          //   homeBanner(context, element);
          // }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool? banner1 = prefs.getBool("banner1");
          bool? banner2 = prefs.getBool("banner2");
          if (banner1 == true && res.homeBanner != null && res.homeBanner!.isNotEmpty) {
            homeBanner1(context, res.homeBanner![0]);
          }
          if (banner2 == true && res.homeBanner != null && res.homeBanner!.length > 1) {
            homeBanner2(context, res.homeBanner![1]);
          }

          Future.delayed(const Duration(seconds: 1),(){
            if(res.daysDifference! > 0) {
              homeAlertDialog(context);
            }
          });
          setState(() {});
        } else {
          Utilities().toast(res.message.toString());
          setState(() {});
        }
      }
      return;
    } catch (e) {
      print('error: $e');
      Utilities().toast('error: $e');
    }
  }
  Future<void> updateProfileImageAPI(BuildContext context) async {
    try{
      const url = Urls.updateProfileImageUrl;
      var formData = FormData.fromMap({
        "user_id" :  userID,
        "profile_image" :  await MultipartFile.fromFile(photoController!.path, filename: photoController!.name),
      });
      final responseDio = await Dio().post(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print("updateProfileImageAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        UpdateProfileImageModel res = UpdateProfileImageModel.fromJson(map);
        if (res.status == true) {
          setState(() {});
        } else {
          setState(() {});
        }
        Utilities().toast(res.message.toString());
      }
      return;
    } catch (e) {
      Utilities().toast('error: $e');
    }
  }
  // property data api
  /// Image pick Bottom dialog.............
  bottomProfileSelection(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                //Navigator.pop(context);
                pickImage(context,ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery'),
              onTap: () {
                // Navigator.pop(context);
                pickImage(context,ImageSource.gallery);
              },
            ),
          ]);
        });
  }
  ///Image picker...............
  Future pickImage(BuildContext context,imageSource) async {
    if(!kIsWeb){
      var image = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 10,
      );
      if (image == null) {
        print('+++++++++null');
        Navigator.pop(context);
      } else {
        photoController = XFile(image.path);
        updateProfileImageAPI(context);
        Navigator.pop(context);
        setState((){});
      }
    }else if(kIsWeb){
      var image = await imagePicker.pickImage(source: imageSource,
          imageQuality: 10);
      if (image == null) {
        print('+++++++++null');
        Navigator.pop(context);
      } else {
        photoController = XFile(image.path);
        updateProfileImageAPI(context);
      }
      setState((){});
      print('image path is ${bytes}');
    }
  }
  Future<void> openPage(url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication);
  }
  homeAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(10.0,),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0),),),
      alignment: Alignment.center,
      content: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/images/warning.svg', height: 250.0,),
            Text("$daysLeft Days left.", textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600),),
            Text(daysLeftMessage, textAlign: TextAlign.center,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0),
                        color: AppColors.transparent,
                      ),
                      child: const Center(child: Text("Back"),),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 750),
                          isIos: true,
                          child: const ProfileAndKyc(),
                        )
                    ).then((value) => Navigator.of(context).pop()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0),
                        color: AppColors.colorSecondary,
                      ),
                      child: const Center(
                        child: Text("Upload KYC",style: TextStyle(color: AppColors.white,),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
    final String emailSubject = "Subject here";
    final Uri parsedMailto = Uri.parse("mailto:<$email>?subject=$emailSubject");

    if (!await launchUrl(
      parsedMailto,
      mode: LaunchMode.externalApplication,
    )) {
      throw "error";
    }
  }
  homeBanner1(BuildContext context, HomeBanner? banner){
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog1(banner: banner, userId: userID),
    );
  }
  homeBanner2(BuildContext context, HomeBanner? banner){
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Dialog2(banner: banner, userId: userID),
    );
  }
}
class Dialog1 extends StatefulWidget {
  final HomeBanner? banner;
  final String userId;
  const Dialog1({super.key, required this.banner, required this.userId});

  @override
  State<Dialog1> createState() => _Dialog1State();
}

class _Dialog1State extends State<Dialog1> {
  late VideoPlayerController? _videoController;
  late Future<void>? _initializeVideoPlayerFuture;
  late String extension;
  bool isShareLoading = false;
  bool isSkipLoading = false;

  @override
  void initState() {
    super.initState();

    // Get the file extension
    extension = widget.banner!.image!.split(".").last.toLowerCase();

    if (extension == "mp4") {
      _videoController = VideoPlayerController.network(widget.banner!.image!);
      _initializeVideoPlayerFuture = _videoController!.initialize().then((value) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        // Start autoplay
        _videoController!.play(); // This makes the video autoplay
      });
      _videoController!.setLooping(true);
    } else {
      _videoController = null;
      _initializeVideoPlayerFuture = null;
    }
  }

  @override
  void dispose() {
    // Dispose the video controller if it was used
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    extension = widget.banner!.image!.split(".").last;
    print("extension-------$extension");
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
          child: Stack(
            children: [
              Column(
                children: [
                  extension == "jpeg" || extension == "jpg" || extension == "png" ?
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      imageUrl: widget.banner!.image!,
                      width: MediaQuery.of(context).size.width,
                      // height: double.infinity,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,),),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ) :
                  extension == "mp4" ?
                  Expanded(
                    flex: 4,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ) : Container(),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setBool("banner1", false);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.red,width: 1.0,style: BorderStyle.solid,),
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.red,
                              ),
                              child: Center(
                                child: isSkipLoading ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/spinner.gif',width: 20.0,),
                                    const Text("Skipping...",style: TextStyle(color: AppColors.white),),
                                  ],
                                ) :
                                const Text("Skip",style: TextStyle(color: AppColors.white),),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => shareFileFromUrl(widget.banner!.image!),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.green,width: 1.0,style: BorderStyle.solid,),
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.green,
                              ),
                              child: Center(
                                child: isShareLoading ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/spinner.gif',width: 20.0,),
                                    const Text("Sharing...",style: TextStyle(color: AppColors.white),),
                                  ],
                                ) :
                                const Text("Share",style: TextStyle(color: AppColors.white),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareFileFromUrl(String fileUrl) async {
    setState(() => isShareLoading = true);
    print(fileUrl);
    try {
      // Download the file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        // Detect the file type
        final mimeType = lookupMimeType(fileUrl);
        if (mimeType == null) {
          print('Unknown file type');
          return;
        }

        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();

        // Determine file extension based on MIME type
        String extension = mimeType.split('/')[1];
        String fileName = 'shared_file.$extension';

        // Create a file in the temporary directory
        final file = File('${tempDir.path}/$fileName');

        // Write the bytes to the file
        await file.writeAsBytes(response.bodyBytes);


        setState(() => isShareLoading = false);
        // Share the file
        await Share.shareXFiles([XFile(file.path)]);
      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isShareLoading = false);
      print('Error sharing file: $e');
    }
  }
}

class Dialog2 extends StatefulWidget {
  final HomeBanner? banner;
  final String userId;
  const Dialog2({super.key, required this.banner, required this.userId});

  @override
  State<Dialog2> createState() => _Dialog2State();
}

class _Dialog2State extends State<Dialog2> {
  late VideoPlayerController? _videoController;
  late Future<void>? _initializeVideoPlayerFuture;
  late String extension;
  bool isShareLoading = false;
  bool isSkipLoading = false;

  @override
  void initState() {
    super.initState();

    // Get the file extension
    extension = widget.banner!.image!.split(".").last.toLowerCase();

    if (extension == "mp4") {
      _videoController = VideoPlayerController.network(widget.banner!.image!);
      _initializeVideoPlayerFuture = _videoController!.initialize().then((value) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        // Start autoplay
        _videoController!.play(); // This makes the video autoplay
      });
      _videoController!.setLooping(true);
    } else {
      _videoController = null;
      _initializeVideoPlayerFuture = null;
    }
  }

  @override
  void dispose() {
    // Dispose the video controller if it was used
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    extension = widget.banner!.image!.split(".").last;
    print("extension-------$extension");
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
          child: Stack(
            children: [
              Column(
                children: [
                  extension == "jpeg" || extension == "jpg" || extension == "png" ?
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      imageUrl: widget.banner!.image!,
                      width: MediaQuery.of(context).size.width,
                      // height: double.infinity,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,),),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ) :
                  extension == "mp4" ?
                  Expanded(
                    flex: 4,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ) : Container(),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setBool("banner2", false);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.red,width: 1.0,style: BorderStyle.solid,),
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.red,
                              ),
                              child: Center(
                                child: isSkipLoading ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/spinner.gif',width: 20.0,),
                                    const Text("Skipping...",style: TextStyle(color: AppColors.white),),
                                  ],
                                ) :
                                const Text("Skip",style: TextStyle(color: AppColors.white),),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => shareFileFromUrl(widget.banner!.image!),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.green,width: 1.0,style: BorderStyle.solid,),
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppColors.green,
                              ),
                              child: Center(
                                child: isShareLoading ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/spinner.gif',width: 20.0,),
                                    const Text("Sharing...",style: TextStyle(color: AppColors.white),),
                                  ],
                                ) :
                                const Text("Share",style: TextStyle(color: AppColors.white),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareFileFromUrl(String fileUrl) async {
    setState(() => isShareLoading = true);
    print(fileUrl);
    try {
      // Download the file
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        // Detect the file type
        final mimeType = lookupMimeType(fileUrl);
        if (mimeType == null) {
          print('Unknown file type');
          return;
        }

        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();

        // Determine file extension based on MIME type
        String extension = mimeType.split('/')[1];
        String fileName = 'shared_file.$extension';

        // Create a file in the temporary directory
        final file = File('${tempDir.path}/$fileName');

        // Write the bytes to the file
        await file.writeAsBytes(response.bodyBytes);


        setState(() => isShareLoading = false);
        // Share the file
        await Share.shareXFiles([XFile(file.path)]);
      } else {
        print('Failed to download file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => isShareLoading = false);
      print('Error sharing file: $e');
    }
  }
}
