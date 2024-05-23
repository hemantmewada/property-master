// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:propertymaster/models/RealEstateListModel.dart';
// import 'package:propertymaster/utilities/AppColors.dart';
// import 'package:propertymaster/utilities/AppStrings.dart';
// import 'package:propertymaster/views/RealEstateFollowUps.dart';
// import 'package:url_launcher/url_launcher.dart';
// // apis
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:propertymaster/utilities/Loader.dart';
// import 'package:propertymaster/utilities/Utility.dart';
// import 'package:propertymaster/utilities/Urls.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:propertymaster/utilities/datetime.dart';
// // apis
//
// class RealEstateDetail extends StatefulWidget {
//   final String title;
//   final String page;
//   const RealEstateDetail({super.key,required this.title,required this.page});
//
//   @override
//   State<RealEstateDetail> createState() => _RealEstateDetailState();
// }
//
// class _RealEstateDetailState extends State<RealEstateDetail> {
//   late String userID;
//   late String role;
//   var phoneNumberController = TextEditingController();
//   List<Listing>? leadList = [];
//   ScrollController scrollController = ScrollController();
//   bool isLoading = false;
//   int start = 0;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration.zero,(){
//       allProcess();
//     });
//   }
//
//   Future<void> allProcess() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userID = prefs.getString("userID") ?? '';
//     role = prefs.getString("role") ?? '';
//     print('my userID is >>>>> {$userID}');
//     print('my role is >>>>> {$role}');
//     initApiCall();
//     apiRefresh();
//     setState(() {});
//   }
//   initApiCall(){
//     leadList!.clear();
//     Future.delayed(const Duration(seconds: 0),(){
//       setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => realEstateDetailListingApi(context,true)));
//     });
//   }
//   apiRefresh() async{
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
//         if (!isLoading) {
//           start = start+10;
//           isLoading = !isLoading;
//           print("start>>>>>>>><<<<<<<${start}");
//           setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => realEstateDetailListingApi(context, true)));
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whitish,
//       appBar: AppBar(
//         backgroundColor: AppColors.colorSecondaryLight,
//         iconTheme: const IconThemeData(color: AppColors.white,),
//         title: Text(
//           widget.title,
//           style: const TextStyle(color: AppColors.white,),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8.0),
//         controller: scrollController,
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           // itemCount: leadList!.length < 0 ? 1 : leadList!.length,
//           itemCount: leadList?.length ?? 0,
//           itemBuilder: (BuildContext context, int index) {
//             if (leadList != null && leadList!.isNotEmpty) {
//               return Container(
//                 width: MediaQuery.of(context).size.width * 1,
//                 padding: const EdgeInsets.all(10.0),
//                 margin: const EdgeInsets.only(bottom: 10.0,),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5.0),
//                   color: AppColors.white,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           leadList![index].name!,
//                           style: const TextStyle(fontSize: 16.0,),
//                         ),
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () => _makePhoneCall('7415119928'),
//                               child: Container(
//                                 margin: const EdgeInsets.only(top: 5.0,),
//                                 child: SvgPicture.asset('assets/icons/phone.svg',color: AppColors.green,height: 30.0,width: 30.0,),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 sendMessage('7415119928','hi');
//                               },
//                               child: SvgPicture.asset('assets/icons/whatsapp.svg',height: 30.0,width: 30.0,),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5.0,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           leadList![index].locationName!,
//                           style: const TextStyle(fontSize: 16.0,color: AppColors.colorPrimaryDark,fontWeight: FontWeight.w600),
//                         ),
//                         InkWell(
//                           onTap: () => addContactNumberModal(),
//                           child: SvgPicture.asset('assets/icons/phone-plus.svg',color: AppColors.green,height: 24.0,width: 24.0,),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5.0,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             leadList![index].budget!,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 Utility().DatefomatToReferDate("MM-dd-yyyy hh:mm a",leadList![index].date!),
//                               ),
//                               Text(
//                                 Utility().DatefomatToTime12HoursFormat("MM-dd-yyyy hh:mm a",leadList![index].date!),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5.0,),
//                     leadList![index].lastFollowup != null ?
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.rightToLeftWithFade,
//                             alignment: Alignment.topCenter,
//                             duration: const Duration(milliseconds: 750),
//                             isIos: true,
//                             child: RealEstateFollowUps(leadId: leadList![index].id,budget: leadList![index].budget,contact: leadList![index].contact,date: leadList![index].date,locationName: leadList![index].locationName,name: leadList![index].name,page: widget.page),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 1,
//                         padding: const EdgeInsets.all(10.0,),
//                         decoration: const BoxDecoration(
//                           color: AppColors.whitish,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0,),),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "LFD ${Utility().DatefomatToReferDate("yyyy-MM-dd",leadList![index].lastFollowup!.nextFollowupDate!)}",
//                               style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.w700,),
//                             ),
//                             const SizedBox(height: 10.0,),
//                             Text(
//                               leadList![index].lastFollowup!.caseSummery!,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ) :
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           PageTransition(
//                             type: PageTransitionType.rightToLeftWithFade,
//                             alignment: Alignment.topCenter,
//                             duration: const Duration(milliseconds: 750),
//                             isIos: true,
//                             child: RealEstateFollowUps(leadId: leadList![index].id,budget: leadList![index].budget,contact: leadList![index].contact,date: leadList![index].date,locationName: leadList![index].locationName,name: leadList![index].name,page: widget.page),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 1,
//                         padding: const EdgeInsets.all(10.0,),
//                         decoration: const BoxDecoration(
//                           color: AppColors.whitish,
//                           borderRadius: BorderRadius.all(Radius.circular(5.0,),),
//                         ),
//                         child: const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Add Followup",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }else{
//               return const Center(child: Text('No Data Found!'),);
//             }
//           },
//         ),
//       ),
//     );
//   }
//   // addContactNumberModal dialog
//   Future addContactNumberModal() {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//         ),
//         contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//         content: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0,),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(12.0)),
//             border: Border.all(color: Colors.white),
//             color: Colors.white,
//           ),
//           height: 220.0,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     AppStrings.addContactNumber,
//                     style: TextStyle(
//                       fontSize: 22.0,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: SvgPicture.asset('assets/icons/cross.svg',width: 20.0,),
//                   )
//                 ],
//               ),
//               Container(
//                 height: 50.0,
//                 width: MediaQuery.of(context).size.width * 1,
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0,),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: AppColors.colorSecondary,
//                       width: 1.0,
//                       style: BorderStyle.solid
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: SvgPicture.asset(
//                         'assets/icons/phone.svg',
//                         width: 23.0,
//                         color: AppColors.colorSecondary,
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: TextFormField(
//                         controller: phoneNumberController,
//                         keyboardType: TextInputType.phone,
//                         style: const TextStyle(
//                           fontSize: 14.0, color: AppColors.black,
//                         ),
//                         cursorColor: AppColors.textColorGrey,
//                         decoration: const InputDecoration(
//                           hintText: AppStrings.addContactNumber,
//                           hintStyle: TextStyle(
//                             fontSize: 14.0,
//                             color: AppColors.textColorGrey,
//                             fontWeight: FontWeight.w500,
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 width: MediaQuery.of(context).size.width * 1,
//                 //height: MediaQuery.of(context).size.height * 0.06,
//                 height: 50.0,
//                 // width: 343.0,
//                 decoration: BoxDecoration(
//                   color: AppColors.colorSecondary,
//                   borderRadius: BorderRadius.circular(50.0),
//                 ),
//                 child: const Text(
//                   AppStrings.add,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.0,
//                     color: AppColors.white,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // addContactNumberModal dialog
//   Future<void> _makePhoneCall(String phoneNumber) async {
//     print('phoneNumber is ------------------------$phoneNumber');
//     final Uri launchUri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     await launchUrl(launchUri);
//   }
//   Future<void> sendMessage(String phoneNumber,String message) async {
//     String appUrl;
//     if (Platform.isAndroid) {
//       appUrl = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";
//     } else {
//       appUrl = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.parse(message)}";
//     }
//
//     if (await canLaunch(appUrl)) {
//       await launch(appUrl);
//     } else {
//       throw 'Could not launch $appUrl';
//     }
//   }
//   // real estate api
//   Future<void> realEstateDetailListingApi(BuildContext context, bool isLoad) async {
//     if(isLoad){
//       Loader.ProgressloadingDialog(context, true);
//     }
//     try {
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(Urls.leadsListUrl),
//       );
//       Map<String, String> header = {
//         "content-type": "application/json",
//         "accept": "application/json",
//         "x-api-key" : Utilities.xApiKey,
//       };
//       request.headers.addAll(header);
//       request.fields['user_id'] =  userID;
//       request.fields['role'] =  role;
//       request.fields['page'] =  widget.page;
//       request.fields['length'] =  '10';
//       request.fields['start'] =  start.toString();
//       print(request.fields);
//       var response = await request.send();
//       if(isLoad) {
//         Loader.ProgressloadingDialog(context, false);
//       }
//       response.stream.transform(convert.utf8.decoder).listen((event) async {
//         print(Urls.leadsListUrl);
//         Map<String, dynamic> map = convert.jsonDecode(event);
//         RealEstateListModel response = await RealEstateListModel.fromJson(map);
//         Utilities().toast(response.message);
//         if(response.status == true) {
//           var data = map['data']['listing'];
//           if (data != null) {
//             // print("data>>>${data}");
//             data.forEach((e) {
//               Listing nModel = Listing.fromJson(e);
//               // print("NotificationModel...${nModel.date}");
//               leadList!.add(nModel);
//               setState(() {});
//             });
//           }
//         }
//       });
//     } catch (e) {
//       Loader.ProgressloadingDialog(context, false);
//       Utilities().toast('error: $e');
//     }
//     return;
//   }
//   // real estate api
// }
