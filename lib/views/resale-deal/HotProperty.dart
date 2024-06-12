import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:intl/intl.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/models/PostPropertyList.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/utilities/Loader.dart";
import "package:propertymaster/utilities/Urls.dart";
import "package:propertymaster/utilities/Utility.dart";
import "package:propertymaster/views/dashboard/dashboard.dart";
import "package:shared_preferences/shared_preferences.dart";

class HotProperty extends StatefulWidget {
  const HotProperty({super.key});

  @override
  State<HotProperty> createState() => _HotPropertyState();
}

class _HotPropertyState extends State<HotProperty> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  late String userID;
  String role = '';
  int _page = 0;
  final int _limit = 100;
  List<Listing>? postPropertyList = [];
  int totalPropertyCount = 0;
  String searchproperty = "";
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
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    postPropertyListFirstLoadAPI(context, true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.colorSecondaryLight,
        //   iconTheme: const IconThemeData(color: AppColors.white,),
        //   title: const Text(
        //     AppStrings.resaleDeal,
        //     style: TextStyle(color: AppColors.white,),
        //   ),
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back),
        //     onPressed: (){
        //       Navigator.pushAndRemoveUntil(
        //         context,
        //         PageTransition(
        //           type: PageTransitionType.rightToLeftWithFade,
        //           alignment: Alignment.topCenter,
        //           duration: const Duration(milliseconds: 500),
        //           isIos: true,
        //           child: Dashboard(bottomIndex: 0),
        //         ),
        //         (route) => false,
        //       );
        //     },
        //   ),
        // ),
        appBar: appBarPostPropertyList(context, totalPropertyCount, searchController, (value) {
          searchController.text = value;
          Future.delayed(const Duration(seconds: 1), (){
            postPropertyListFirstLoadAPI(context, false);
          });
        }),
        backgroundColor: AppColors.whitish,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: postPropertyList!.isEmpty ? 1 : postPropertyList?.length,
                controller: scrollController,
                itemBuilder: (BuildContext context,int index) {
                  return postPropertyList!.isEmpty ?
                  SizedBox(height: MediaQuery.of(context).size.height * 0.5,child: const Center(child: Text("No data found"),)) :
                  propertyContainer(context,postPropertyList![index], userID);
                },
              ),
            ),
            // const SizedBox(height: 15.0,),
          ],
        ),
      ),
      onWillPop: () async {
        print("back by navigation back button");
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 500),
            isIos: true,
            child: Dashboard(bottomIndex: 0),
          ),
              (route) => false,
        );
        return false;
      },
    );
  }
  // post property list API
  Future<void> postPropertyListFirstLoadAPI(BuildContext context, bool isLoad) async {
    if(isLoad){
      Loader.ProgressloadingDialog(context, true);
    }
    const url = Urls.postPropertyListUrl;
    try {
      var formData = FormData.fromMap({
        "user_id" :  userID,
        "role" :  role,
        "page" :  "hotlist",
        "length" :  _limit.toString(),
        "start" :  _page.toString(),
        "searchproperty": searchController.text,
      });
      final responseDio = await Dio().post(url,data: formData,);
      if(isLoad){
        Loader.ProgressloadingDialog(context, false);
      }
      if (responseDio.statusCode == 200) {
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        PostPropertyList response = PostPropertyList.fromJson(map);
        postPropertyList!.clear();
        postPropertyList = response.data!.listing;
        totalPropertyCount = response.data!.recordsFiltered!;
        setState(() {});
      }
    } on DioError catch (error) {

    } catch (_) {

    }
  }
// post property list API
}
