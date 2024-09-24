import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:propertymaster/utilities/AppColors.dart";
import "package:propertymaster/utilities/AppStrings.dart";
import "package:propertymaster/views/resale-deal/SoldProperty.dart";
import "package:propertymaster/views/resale-deal/AllProperty.dart";
import "package:propertymaster/views/resale-deal/HotProperty.dart";
import "package:propertymaster/views/resale-deal/MyProperty.dart";

class ResaleDealDashboard extends StatefulWidget {
  int bottomIndex;
  ResaleDealDashboard({super.key,required this.bottomIndex});

  @override
  State<ResaleDealDashboard> createState() => _ResaleDealDashboardState();
}
var widgetOptions = [
  const AllProperty(),
  MyProperty(),
  const HotProperty(),
  const SoldProperty(),
];

class _ResaleDealDashboardState extends State<ResaleDealDashboard> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        widget.bottomIndex = index;
        // print("index--------------------${widget.bottomIndex}");
      });
    }
    return Scaffold(
        body: widgetOptions[
        widget.bottomIndex
        ],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg',color: AppColors.white,width: 25.0,height: 25.0,),
              label: AppStrings.allProperty,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/my-property.svg',color: AppColors.white,width: 25.0,height: 25.0,),
              label: AppStrings.myProperty,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/hot-property.svg',color: AppColors.white,width: 30.0,height: 30.0,),
              label: AppStrings.hotProperty,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/sold-property.svg',color: AppColors.white,width: 30.0,height: 30.0,),
              label: AppStrings.soldProperty,
            ),
          ],
          currentIndex: widget.bottomIndex,
          elevation: 0.0,
          backgroundColor: AppColors.colorSecondaryLight,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white,
          onTap: onItemTapped,
          selectedFontSize: 12.0,
          unselectedFontSize: 10.0,
        )
    );
  }
}
