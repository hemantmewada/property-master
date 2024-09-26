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
import 'dart:async';

class UsersProperty extends StatefulWidget {
  final String userId;
  final String role;
  const UsersProperty({super.key, required this.userId, required this.role});

  @override
  State<UsersProperty> createState() => _UsersPropertyState();
}

class _UsersPropertyState extends State<UsersProperty> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  int _page = 0;
  final int _limit = 100;
  List<Listing>? postPropertyList = [];
  int totalPropertyCount = 0;
  String searchproperty = "";
  String page = "mypost";
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
      postPropertyListFirstLoadAPI(context, false);
    });
  }

  Future<void> allProcess() async {
    postPropertyListFirstLoadAPI(context, true);
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
      appBar: appBarPostPropertyList(context, totalPropertyCount, searchController, (value) => _onSearchChanged(context, value),true),
      backgroundColor: AppColors.whitish,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      page = "mypost";
                      postPropertyListFirstLoadAPI(context, true);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0),
                        color: page == "mypost" ? AppColors.colorSecondary : AppColors.transparent,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            page == "mypost" ? const Icon(Icons.bolt_sharp, size: 16.0, color: AppColors.white,) : Container(),
                            page == "mypost" ? SizedBox(width: MediaQuery.of(context).size.width * 0.01,) : Container(),
                            Text(AppStrings.myProperty,style: TextStyle(color: page == "mypost" ? AppColors.white : AppColors.colorSecondary,),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      page = "sold";
                      postPropertyListFirstLoadAPI(context, true);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorSecondary,width: 1.0,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5.0),
                        color: page == "sold" ? AppColors.colorSecondary : AppColors.transparent,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            page == "sold" ? const Icon(Icons.bolt_sharp, size: 16.0, color: AppColors.white,) : Container(),
                            page == "sold" ? SizedBox(width: MediaQuery.of(context).size.width * 0.01,) : Container(),
                            Text(AppStrings.soldProperty,style: TextStyle(color: page == "sold" ? AppColors.white : AppColors.colorSecondary,),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: postPropertyList!.isEmpty ? 1 : postPropertyList?.length,
              controller: scrollController,
              itemBuilder: (BuildContext context,int index) {
                return postPropertyList!.isEmpty ?
                SizedBox(height: MediaQuery.of(context).size.height * 0.5,child: const Center(child: Text("No data found"),)) :
                propertyContainer(context,postPropertyList![index], widget.userId, widget.role, "my-property", true);
              },
            ),
          ),
          // const SizedBox(height: 15.0,),
        ],
      ),
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
        "user_id" :  widget.userId,
        "role" :  widget.role,
        "page" :  page,
        "length" :  _limit.toString(),
        "start" :  _page.toString(),
        "searchproperty": searchController.text,
      });
      print(formData.fields);
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
