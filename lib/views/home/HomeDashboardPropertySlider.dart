// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/HomeDashboardPropertyListModel.dart';
import 'package:propertymaster/models/HomeDashboardPropertyListModel.dart';
import 'package:propertymaster/models/PostPropertyList.dart' as PostPropertyList;
import 'package:propertymaster/models/PropertyDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:propertymaster/views/home/PropertyDetail.dart';

class HomeDashboardPropertySlider extends StatefulWidget {
  List<PostPropertyList.Listing> propertyList;
  String userId;
  HomeDashboardPropertySlider({super.key, required this.propertyList, required this.userId});

  @override
  _HomeDashboardPropertySliderState createState() => _HomeDashboardPropertySliderState();
}

class _HomeDashboardPropertySliderState extends State<HomeDashboardPropertySlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> propertySliderData = widget.propertyList!
        .map((item) {
          return propertyContainer(context,item, widget.userId);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.calonyName!,
                      style: TextStyle(fontWeight: FontWeight.w700,),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.expectedPrice.toString(),
                      style: TextStyle(fontWeight: FontWeight.w700,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.propertyType!,
                      style: TextStyle(fontWeight: FontWeight.w700,),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.location!,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.flatSize!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.possessionStatus!,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.transactionType!,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.facing!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.furnishedStatus!,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Text(
                AppStrings.callNow,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.colorPrimaryDark,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
        }).toList();

    return Stack(
      children: [
        CarouselSlider(
          items: propertySliderData,
          options: CarouselOptions(
              autoPlay: true,
              pauseAutoPlayInFiniteScroll: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        // Positioned(
        //   left: 20.0,
        //   bottom: 20.0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: propertyList!.map((url) {
        //       int index = propertyList!.indexOf(url);
        //       return Container(
        //         width: 8,
        //         height: 8,
        //         margin: const EdgeInsets.symmetric(
        //           vertical: 10,
        //           horizontal: 3,
        //         ),
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: _current == index ? AppColors.colorSecondary : AppColors.colorSecondaryDashboard,
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    );
  }
}
