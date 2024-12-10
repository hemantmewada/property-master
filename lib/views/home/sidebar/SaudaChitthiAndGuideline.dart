import "package:cached_network_image/cached_network_image.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/models/GuidlineAndSaudaChitthiModel.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/utilities/Loader.dart";
import "package:propertymaster/utilities/Urls.dart";
import "package:propertymaster/utilities/Utility.dart";
import "package:propertymaster/views/dashboard/dashboard.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:http/http.dart' as http;
import "package:share_plus/share_plus.dart";

class SaudaChitthiAndGuideline extends StatefulWidget {
  const SaudaChitthiAndGuideline({super.key});

  @override
  State<SaudaChitthiAndGuideline> createState() => _SaudaChitthiAndGuidelineState();
}

class _SaudaChitthiAndGuidelineState extends State<SaudaChitthiAndGuideline> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  late String userID;
  String role = '';
  Data? data;
  // Define a Timer variable
  Timer? _debounce;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  void _onSearchChanged(BuildContext context, String value) {
    // Cancel the previous debounce timer if it exists and is active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Create a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchController.text = value;
      layoutMapAPI(context, false);
    });
  }

  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("userID") ?? '';
    role = prefs.getString("role") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    layoutMapAPI(context, true);
    setState(() {});
  }
  // Cancel the debounce timer in the dispose method to prevent memory leaks
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(AppStrings.saudaChitthiAndGuideline,style: TextStyle(color: AppColors.white,),),
      ),
      backgroundColor: AppColors.whitish,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.picture_as_pdf,color: Colors.red,size: 30.0,),
                    const SizedBox(width: 10.0,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => sharePdf(data!.saudaChitthi!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid,),
                              borderRadius: BorderRadius.circular(5.0),
                              // color: AppColors.colorSecondary,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.share, size: 16.0, color: AppColors.colorSecondary,),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                  const Text("Share",style: TextStyle(color: AppColors.colorSecondary,),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        InkWell(
                          onTap: () => openPdf(data!.saudaChitthi!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid,),
                              borderRadius: BorderRadius.circular(5.0),
                              // color: AppColors.colorSecondary,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.open_in_new_outlined, size: 16.0, color: AppColors.colorSecondary,),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                  const Text("Open",style: TextStyle(color: AppColors.colorSecondary,),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                Text("Sauda Chitthi",style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18.0,),),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.picture_as_pdf,color: Colors.red,size: 30.0,),
                    const SizedBox(width: 10.0,),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => sharePdf(data!.guildline!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid,),
                              borderRadius: BorderRadius.circular(5.0),
                              // color: AppColors.colorSecondary,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.share, size: 16.0, color: AppColors.colorSecondary,),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                  const Text("Share",style: TextStyle(color: AppColors.colorSecondary,),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        InkWell(
                          onTap: () => openPdf(data!.guildline!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid,),
                              borderRadius: BorderRadius.circular(5.0),
                              // color: AppColors.colorSecondary,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.open_in_new_outlined, size: 16.0, color: AppColors.colorSecondary,),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                  const Text("Open",style: TextStyle(color: AppColors.colorSecondary,),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                Text("Guidline",style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18.0,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // post property list API
  Future<void> layoutMapAPI(BuildContext context, bool isLoad) async {
    if(isLoad){
      Loader.ProgressloadingDialog(context, true);
    }
    try {
      var url = Urls.saudaChitthiAndGuidelineUrl;
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      if(isLoad){
        Loader.ProgressloadingDialog(context, false);
      }
      if (responseDio.statusCode == 200) {
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        GuidlineAndSaudaChitthiModel response = GuidlineAndSaudaChitthiModel.fromJson(map);
        data = response.data;
        setState(() {});
      }
    } on DioError catch (error) {
      if(error.response?.data['status'] == false){
        String errorMessage = error.response?.data['message'];
        Utilities().toast(errorMessage);
      }
    } catch (_) {

    }
  }
  // post property list API
  Future<void> sharePdf(String pdfUrl) async {
    print(pdfUrl);
    try {
      shareLoading(context);
      // Download the PDF
      final response = await http.get(Uri.parse(pdfUrl));
      if (response.statusCode == 200) {
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        // Create a file in the temporary directory
        final file = File('${tempDir.path}/shared_document.pdf');
        // Write the PDF bytes to the file
        await file.writeAsBytes(response.bodyBytes);
        // Share the PDF
        await Share.shareFiles([file.path], text: "Check out this PDF!");
      } else {
        print('Failed to download PDF. Status code: ${response.statusCode}');
      }
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      print('Error sharing PDF: $e');
    }
  }
  Future<void> openPdf(String url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication);
  }
  shareLoading(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: Image.asset('assets/icons/spinner.gif',width: 40.0,),
              title: const Text('Sharing, Please wait...'),
            ),
          ]);
        });
  }
}
