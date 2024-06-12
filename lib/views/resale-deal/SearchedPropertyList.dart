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

class SearchedPropertyList extends StatefulWidget {
  final String search;
  final String propertyType;
  final String typeOfProperty;
  final String budgetFrom;
  final String budgetTo;
  const SearchedPropertyList({super.key, required this.search, required this.propertyType, required this.typeOfProperty, required this.budgetFrom, required this.budgetTo});

  @override
  State<SearchedPropertyList> createState() => _SearchedPropertyListState();
}

class _SearchedPropertyListState extends State<SearchedPropertyList> {
  ScrollController scrollController = ScrollController();
  late String userID;
  String role = '';
  List<Listing>? postPropertyList = [];
  int totalPropertyCount = 0;
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
    postPropertyListFirstLoadAPI(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.resaleDeal,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
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
    );
  }
  // post property list API
  Future<void> postPropertyListFirstLoadAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    const url = Urls.postPropertyListUrl;
    try {
      var formData = FormData.fromMap({
        "user_id" :  userID,
        "role" :  role,
        "page" :  "saleplot",
        "searchproperty": widget.search,
        "project_type": widget.propertyType,
        "category": widget.typeOfProperty,
        "budget_from": widget.budgetFrom,
        "budget_to": widget.budgetTo,
      });
      print(formData.fields);
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);
        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        PostPropertyList response = PostPropertyList.fromJson(map);
        print("response.data!.recordsFiltered-------------${response.data!.recordsFiltered}");
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
