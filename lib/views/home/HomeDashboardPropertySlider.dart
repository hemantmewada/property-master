// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/HomeDashboardPropertyListModel.dart';
import 'package:propertymaster/models/PropertyDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:propertymaster/views/home/PropertyDetail.dart';

class HomeDashboardPropertySlider extends StatefulWidget {
  HomeDashboardPropertySlider({super.key});

  @override
  _HomeDashboardPropertySliderState createState() => _HomeDashboardPropertySliderState();
}

class _HomeDashboardPropertySliderState extends State<HomeDashboardPropertySlider> {
  int _current = 0;
  List<HomeDashboardPropertyListModel>? propertyList = [
    HomeDashboardPropertyListModel(colonyName: 'Tricone City', projectAmount: '₹ 5.0 Lac.', propertyType: 'Residential Plot', location: 'Khandwa Road', size: '1500', possessionStatus: 'New Project', transactionType: 'First Sale', facing: 'East', furnishedStatus: 'Non Furnished'),
    HomeDashboardPropertyListModel(colonyName: 'Info City', projectAmount: '₹ 10.0 Lac.', propertyType: 'Flat', location: 'AB Road Bypass', size: '4500', possessionStatus: 'Ready To Move', transactionType: 'First Sale', facing: 'West', furnishedStatus: 'Semi Furnished'),
    HomeDashboardPropertyListModel(colonyName: 'The Grand Virasat', projectAmount: '₹ 20.0 Lac.', propertyType: 'Industrial Plots', location: 'AB Road Bypass', size: '1600', possessionStatus: 'Under development', transactionType: 'First Sale', facing: 'North', furnishedStatus: 'One Sides open'),
    HomeDashboardPropertyListModel(colonyName: 'Lotus Garden', projectAmount: '₹ 40.0 Lac.', propertyType: 'Godown/Warehouse', location: 'Mangaliya AB Road', size: '3200', possessionStatus: 'New Project', transactionType: 'First Sale', facing: 'South', furnishedStatus: 'Semi Furnished'),
    HomeDashboardPropertyListModel(colonyName: 'victoria city', projectAmount: '₹ 20.0 Lac.', propertyType: 'Commercial Plot', location: 'Jhalaria', size: '2000', possessionStatus: 'Ready To Move', transactionType: 'First Sale', facing: 'East', furnishedStatus: 'Non Furnished'),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> propertySliderData = propertyList!
        .map((item) {
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
                      item.colonyName!,
                      style: TextStyle(fontWeight: FontWeight.w700,),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.projectAmount!,
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
                      item.size!,
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
                AppStrings.callForDetail,
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
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
          child: CarouselSlider(
            items: propertySliderData,
            options: CarouselOptions(
                autoPlay: true,
                pauseAutoPlayInFiniteScroll: true,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                aspectRatio: 2.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
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
