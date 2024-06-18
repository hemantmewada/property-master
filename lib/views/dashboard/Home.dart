// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/PostPropertyList.dart' as PostPropertyList;
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/models/UpdateProfileImageModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/home/SliderDetail.dart';
import 'package:propertymaster/views/lead-management/AddLead.dart';
import 'package:propertymaster/views/home/HomeDashboardPropertySlider.dart';
import 'package:propertymaster/views/lead-management/ManageLeadList.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';
import 'package:propertymaster/views/home/HomeSlider.dart';
import 'package:propertymaster/views/my-team/BusinessPartnerRegistration.dart';
import 'package:propertymaster/views/resale-deal/PostProperty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
// apis
import 'dart:async';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart' ;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
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
  int hotListedCount = 0;
  int totalPropertyCount = 0;
  List<ListingNew>? imgList = [];
  List<String> jobTypeList1 = ['Select Job Type','Sr Business Partner','Full Time Business Partner','Part Time Business Partner'];
  List<String> jobTypeList2 = ['Select Job Type','Full Time Business Partner','Part Time Business Partner'];
  List<HotListedProperty>? postPropertyList = [];

  final ImagePicker imagePicker = ImagePicker();
  XFile? photoController;
  XFile? imageFile;
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // UserAccountsDrawerHeader(
            //   accountName: Text(name),
            //   accountEmail: Text(role == "Business Partner" ? "Sr Business Partner" : role),
            //   decoration: const BoxDecoration(color: AppColors.colorSecondaryLight,),
            //   currentAccountPicture: const CircleAvatar(
            //     backgroundImage: AssetImage("assets/images/user.png"),
            //   ),
            // ),
            Container(
              color: AppColors.colorSecondaryLight,
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 20.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      bottoms_Profileimage(context);
                      // print("fsdfjsdfk");
                    },
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
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.video_settings_sharp),
              title: const Text("Videos"),
              onTap: () => openVideoPage(),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
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
                  const Text(AppStrings.propertyMaster,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
                  Expanded(
                    flex: 1,
                    child: InkWell(
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
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50.0,),),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0,),
                          child: const Text(AppStrings.postProperty,style: TextStyle(fontSize: 12.0,),),
                        ),
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
            HomeDashboardPropertySlider(propertyList: postPropertyList!, userId: userID,) :
            const SizedBox(
              // height: 283.0,
              height: 120.0,
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
                      const SizedBox(width: 5.0,),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //       type: PageTransitionType.rightToLeftWithFade,
                            //       alignment: Alignment.topCenter,
                            //       duration: const Duration(milliseconds: 750),
                            //       isIos: true,
                            //       child: const HomeScreen(),
                            //     )
                            // );
                          },
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
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppStrings.totalBP2,
                                          style: TextStyle(color: AppColors.white,fontSize: 11.0,),
                                        ),
                                        SizedBox(height: 5.0,),
                                        Text('0',
                                          style: TextStyle(color: AppColors.white,fontSize: 18.0,),
                                        ),
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
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0,),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const BlinkText(
                    AppStrings.createABusinessPartner,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
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
      var url = '${Urls.propertyDataUrl}?user_id=$userID';
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print("propertyDataAPI ---- $url");
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        HomePageDataModel res = HomePageDataModel.fromJson(map);
        if (res.status == true) {
          imgList = res.listingNew;
          profileImage = res.userData!.profileImg!;
          todayWorkCount = res.todayWorkCount!;
          hotListedCount = res.hotListedCount!;
          totalPropertyCount = res.totalCount!;
          postPropertyList = res.hotListedProperty!;
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
  bottoms_Profileimage(BuildContext context){
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
  Future<void> openVideoPage() async {
    const url = videosUrl;
    final Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication);
  }
}
