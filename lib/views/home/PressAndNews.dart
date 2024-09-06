import "package:cached_network_image/cached_network_image.dart";
import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/models/PressAndNewsModel.dart";
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

class PressAndNews extends StatefulWidget {
  const PressAndNews({super.key});

  @override
  State<PressAndNews> createState() => _PressAndNewsState();
}

class _PressAndNewsState extends State<PressAndNews> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  late String userID;
  String role = '';
  List<Data>? pressNewsList = [];
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
        pressAndNewsAPI(context);
    });
  }

  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("userID") ?? '';
    role = prefs.getString("role") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    pressAndNewsAPI(context);
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
        title: const Text(AppStrings.pressAndNews,style: TextStyle(color: AppColors.white,),),
      ),
      backgroundColor: AppColors.whitish,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pressNewsList!.isEmpty ? 1 : pressNewsList?.length,
              controller: scrollController,
              itemBuilder: (BuildContext context,int index) {
                if (pressNewsList!.isEmpty) {
                  return SizedBox(height: MediaQuery.of(context).size.height * 0.5,child: const Center(child: Text("No data found"),),);
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),color: AppColors.white,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: pressNewsList![index].map!,
                          width: MediaQuery.of(context).size.width,
                          height: 200.0,fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,),),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        const SizedBox(height: 5.0,),
                        Text(Utilities().DatefomatToOnlyDate("yyyy-MM-dd",pressNewsList![index].date!),style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 18.0,),),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  // post property list API
  Future<void> pressAndNewsAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var url = Urls.pressAndNewsUrl;
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        PressAndNewsModel response = PressAndNewsModel.fromJson(map);
        pressNewsList!.clear();
        pressNewsList = response.data!;
        setState(() {});
      }
    } on DioError catch (error) {
      if(error.response?.data['status'] == false){
        String errorMessage = error.response?.data['message'];
        pressNewsList = [];
        Utilities().toast(errorMessage);
        setState(() {});
      }
    } catch (_) {

    }
  }
  // post property list API
  Future<void> openPdf(String url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication);
  }
}
