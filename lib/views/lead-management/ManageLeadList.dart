// main.dart
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/AddContactModel.dart';
import 'package:propertymaster/models/RealEstateListModel.dart';
import 'dart:convert';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:propertymaster/views/lead-management/RealEstateFollowUps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

// apis

class ManageLeadList extends StatefulWidget {
  final String title;
  final String page;
  final String userID;
  final String role;
  const ManageLeadList({Key? key,required this.title,required this.page,required this.userID,required this.role}) : super(key: key);

  @override
  State<ManageLeadList> createState() => _ManageLeadListState();
}

class _ManageLeadListState extends State<ManageLeadList> {
  var phoneNumberController = TextEditingController();
  int _page = 0;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List<Listing>? leadList = [];
  ScrollController scrollController = ScrollController();
  var searchController = TextEditingController();
  String searchParameter = '';
  bool onLoadFocusOnTextFormFieldForAll = true;
  bool onLoadFocusOnTextFormFieldForOthers = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    print("widget.userID--------{${widget.userID}}");
    print("widget.role--------{${widget.role}}");
    print("widget.page--------{${widget.page}}");
    _firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whitish,
        // appBar: AppBar(
        //   backgroundColor: AppColors.colorSecondaryLight,
        //   iconTheme: const IconThemeData(color: AppColors.white,),
        //   title: Text(
        //     widget.title,
        //     style: const TextStyle(color: AppColors.white,),
        //   ),
        // ),
        appBar: AppBar(
          toolbarHeight: 140.0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset('assets/icons/back2.svg',color: AppColors.white,width: 25.0,height: 25.0,),
                    ),
                    const SizedBox(width: 10.0,),
                    Text(widget.title,style: const TextStyle(fontSize: 22.0,color: AppColors.white,),),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.colorSecondary,
                        width: 1.0,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 23.0,
                          color: AppColors.colorSecondary,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onChanged: (val){
                            print("val onChanged is ------------------$val");
                            setState(() => searchParameter = val);
                            realEstateDetailListingFirstLoadAPI(context,false);
                          },
                          onFieldSubmitted: (val) {
                            print("val onSubmitted is ------------------$val");
                            setState(() => searchParameter = val);
                            realEstateDetailListingFirstLoadAPI(context,false);
                          },
                          controller: searchController,
                          autofocus: widget.page == 'all' ? onLoadFocusOnTextFormFieldForAll : onLoadFocusOnTextFormFieldForOthers,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontSize: 14.0, color: AppColors.black,
                          ),
                          cursorColor: AppColors.textColorGrey,
                          decoration: const InputDecoration(
                            hintText: AppStrings.searchLeads,
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.textColorGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.colorSecondaryLight,
        ),
        body: _isFirstLoadRunning ?
          const Center(
            child: CircularProgressIndicator(),
          ):
          Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: leadList?.length ?? 0,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color:
                      // (leadList![index].lastFollowup!.isHot! == '1') ? AppColors.red : AppColors.white,
                      (leadList![index]?.isHot ?? '0') == '1' ? AppColors.red : AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                leadList![index].name!,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  leadList![index].contact!,
                                  style: TextStyle(
                                    color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                  ),
                                ),
                                const SizedBox(width: 5.0,),
                                InkWell(
                                  onTap: () => _makePhoneCall(leadList![index].contact!),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5.0,),
                                    child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    sendMessage(leadList![index].contact!,'Hi, How can i help you.');
                                  },
                                  child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                leadList![index].leadSources == null ? "" : leadList![index].leadSources!,
                                style: TextStyle(
                                  color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                ),
                              ),
                            ),
                            (leadList![index].contact2 == null || leadList![index].contact2!.isEmpty || leadList![index].contact2 == '0' || leadList![index].contact2 == "0")
                                ? InkWell(
                                    onTap: () => addContactNumberModal(leadList![index].id),
                                    child: SvgPicture.asset('assets/icons/phone-plus.svg',color: AppColors.green,height: 24.0,width: 24.0,),
                                  )
                                : Row(
                                  children: [
                                    Text(
                                      leadList![index].contact2!,
                                      style: TextStyle(
                                        color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0,),
                                    InkWell(
                                      onTap: () => _makePhoneCall(leadList![index].contact2!),
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 5.0,),
                                        child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        sendMessage(leadList![index].contact2!,'Hi, How can i help you.');
                                      },
                                      child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                leadList![index].locationName == null ? "" : leadList![index].locationName!,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.colorPrimaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                leadList![index].location == null ? "" : leadList![index].location!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.colorPrimaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                leadList![index].budget == null ? "" : leadList![index].budget!,
                                style: TextStyle(
                                  color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Utilities().DatefomatToReferDate("dd-MM-yyyy hh:mm a",leadList![index].date!),
                                    style: TextStyle(
                                      color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    Utilities().DatefomatToTime12HoursFormat("MM-dd-yyyy hh:mm a",leadList![index].date!),
                                    style: TextStyle(
                                      color: (leadList![index]?.isHot ?? '0') == '1' ? AppColors.white : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0,),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                alignment: Alignment.topCenter,
                                duration: const Duration(milliseconds: 750),
                                isIos: true,
                                child: RealEstateFollowUps(
                                  userID: widget.userID,
                                  leadId: leadList![index].id,
                                  budget: leadList![index].budget,
                                  contact: leadList![index].contact,
                                  date: leadList![index].date,
                                  locationName: leadList![index].locationName,
                                  name: leadList![index].name,
                                  leadSource: leadList![index].leadSources,
                                  page : widget.page,
                                  leadSources: leadList![index].leadSources,
                                  contact2: leadList![index].contact2,
                                  location: leadList![index].location,
                                  id: leadList![index].id,
                                  lastFollowup: leadList![index].type
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            padding: const EdgeInsets.all(10.0,),
                            decoration: const BoxDecoration(
                              color: AppColors.whitish,
                              borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                            ),
                            child:
                            leadList![index].lastFollowup != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(widget.page == "all")
                                  leadList![index].type == null || leadList![index].type == "" ? Container() : Text(
                                  leadList![index].type!, style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,)
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "LFD : ",
                                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Utilities().DatefomatToOnlyDate("yyyy-MM-dd HH:mm:ss",leadList![index].lastFollowup!.insertDate!),
                                            style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,),
                                          ),
                                          Text(
                                            Utilities().DatefomatToOnlyTime("yyyy-MM-dd HH:mm:ss",leadList![index].lastFollowup!.insertDate!),
                                            style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0,),
                                (leadList![index].lastFollowup!.caseSummery == null)
                                  ? Container()
                                  : Text(leadList![index].lastFollowup!.caseSummery!,),
                                (leadList![index].lastFollowup!.remark == null)
                                  ? Container()
                                  : Text(leadList![index].lastFollowup!.remark!,),
                              ],
                            ) :
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add Followup",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_isLoadMoreRunning == true) const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            // if (_hasNextPage == false) Container(
            //     padding: const EdgeInsets.only(top: 30, bottom: 40),
            //     color: Colors.amber,
            //     child: const Center(
            //       child: Text('You have fetched all of the content'),
            //   ),
            // ),
          ],
        )
    );
  }

  Future<void> _loadMore() async {
    if (_hasNextPage == true && _isFirstLoadRunning == false && _isLoadMoreRunning == false && scrollController.position.extentAfter < 300 ) {
    // if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 10; // Increase _page by 10

      realEstateDetailListingLoadMoreAPI(context);


      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future<void> _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    realEstateDetailListingFirstLoadAPI(context,true);

    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  // addContactNumberModal dialog
  Future addContactNumberModal(String? leadId) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0,),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          height: 220.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.addContactNumber,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset('assets/icons/cross.svg',width: 20.0,),
                  )
                ],
              ),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.colorSecondary,
                      width: 1.0,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SvgPicture.asset(
                        'assets/icons/phone.svg',
                        width: 23.0,
                        color: AppColors.colorSecondary,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          fontSize: 14.0, color: AppColors.black,
                        ),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          hintText: AppStrings.addContactNumber,
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  String phone = phoneNumberController.text;
                  if(phone.isEmpty){
                    Utilities().toast(AppStrings.phoneToast);
                  }else if(phone.length < 10 || phone.length > 10) {
                    Utilities().toast(AppStrings.phoneValidToast);
                  }else{
                    addContactAPI(context,leadId);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 1,
                  //height: MediaQuery.of(context).size.height * 0.06,
                  height: 50.0,
                  // width: 343.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Text(
                    AppStrings.add,
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
      ),
    );
  }
  // addContactNumberModal dialog
  // real estate api
  Future<void> realEstateDetailListingFirstLoadAPI(BuildContext context, bool isLoad) async {
    if(isLoad){
      Loader.ProgressloadingDialog(context, true);
    }
    const url = Urls.leadsListUrl;
    try {
      var formData = FormData.fromMap({
        "user_id" :  widget.userID,
        "role" :  widget.role,
        "page" :  widget.page,
        "length" :  _limit.toString(),
        "start" :  _page.toString(),
        "searchParameter" : searchParameter,
      });
      final responseDio = await Dio().post(url,data: formData,);
      if(isLoad){
        Loader.ProgressloadingDialog(context, false);
      }
      if (responseDio.statusCode == 200) {
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        RealEstateListModel response = RealEstateListModel.fromJson(map);
        leadList!.clear();
        phoneNumberController.clear();
        leadList = response.data!.listing;
        setState(() {});
        if(leadList!.isEmpty){
          Utilities().toast("No Data Found");
        }
      }
    } on DioError catch (error) {

    } catch (_) {

    }
  }
  // real estate api
  // real estate load more api
  Future<void> realEstateDetailListingLoadMoreAPI(BuildContext context) async {
    try {
      const url = Urls.leadsListUrl;
      var formData = FormData.fromMap({
        "user_id" :  widget.userID,
        "role" :  widget.role,
        "page" :  widget.page,
        "length" :  _limit.toString(),
        "start" :  _page.toString(),
        "searchParameter" : searchParameter,
      });
      final responseDio = await Dio().post(url,data: formData,);
      if (responseDio.statusCode == 200) {
        print(Urls.leadsListUrl);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        RealEstateListModel response = RealEstateListModel.fromJson(map);
        if (response.status == true) {
          final List<Listing> fetchedPosts = List<Listing>.from(
              response.data!.listing!);
          if (fetchedPosts.isNotEmpty) {
            setState(() {
              leadList!.addAll(fetchedPosts);
            });
          } else {
            setState(() {
              _hasNextPage = false;
            });
          }
        } else {
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Utilities().toast('error: $e');
    }
    return;
  }
  // real estate load more api
  // real estate api
  Future<void> addContactAPI(BuildContext context, String? leadId) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.addContact2Url;
      var formData = FormData.fromMap({
        "lead_id" :  leadId!,
        "contact" :  phoneNumberController.text,
      });
      final responseDio = await Dio().post(url,data: formData,);

      Loader.ProgressloadingDialog(context, false);
      Navigator.of(context).pop();

      if (responseDio.statusCode == 200) {
        print(Urls.addContact2Url);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        AddContactModel response = AddContactModel.fromJson(map);

        if(response.status == true) {
          Utilities().toast(response.message);
          setState(() {});
        }else{
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  // real estate api
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

    // if (await launch(appUrl)) {
      await launch(appUrl);
    // } else {
    //   throw 'Could not launch $appUrl';
    // }
  }
}
