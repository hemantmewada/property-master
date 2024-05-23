import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/views/dashboard/dashboard.dart";

class AllProperty extends StatefulWidget {
  const AllProperty({super.key});

  @override
  State<AllProperty> createState() => _AllPropertyState();
}

class _AllPropertyState extends State<AllProperty> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.colorSecondaryLight,
          iconTheme: const IconThemeData(color: AppColors.white,),
          title: const Text(
            AppStrings.resaleDeal,
            style: TextStyle(color: AppColors.white,),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
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
            },
          ),
        ),
        backgroundColor: AppColors.whitish,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                controller: scrollController,
                itemBuilder: (BuildContext context,int index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 8.0,right: 8.0,left: 8.0,),
                    // margin: const EdgeInsets.only(bottom: 8.0,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppColors.white,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Tricone City",
                                style: TextStyle(fontWeight: FontWeight.w600,),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "₹ 83.6 Lakh",
                                style: TextStyle(fontWeight: FontWeight.w600,),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Agriculture Land",
                                style: TextStyle(fontWeight: FontWeight.w600,),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Khandwa Road"),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("First Sale",style: TextStyle(color: AppColors.textColorGrey,),),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    "1500",
                                    style: TextStyle(color: AppColors.textColorGrey,),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "East",
                                    style: TextStyle(color: AppColors.textColorGrey,),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "New Project",
                                    style: TextStyle(color: AppColors.textColorGrey,),
                                    textAlign: TextAlign.end,
                                  ),
                                  Text(
                                    "One sides Open",
                                    style: TextStyle(color: AppColors.textColorGrey,),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0,),
                        Text(
                          AppStrings.callForDetail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.colorPrimaryDark,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5.0,),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15.0,),
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
}
