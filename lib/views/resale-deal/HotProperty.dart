import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/views/dashboard/dashboard.dart";

class HotProperty extends StatefulWidget {
  const HotProperty({super.key});

  @override
  State<HotProperty> createState() => _HotPropertyState();
}

class _HotPropertyState extends State<HotProperty> {
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
        body: const Center(
          child: Text("HotProperty"),
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
