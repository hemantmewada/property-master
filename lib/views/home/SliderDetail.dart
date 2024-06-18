// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/home/SliderDetailCarousel.dart';

const List<KeyValueClass> amenitiesList = [
  KeyValueClass(value: "covered_campus", name: "Covered Campus"),
  KeyValueClass(value: "semi_covered_campus", name: "Semi Covered Campus"),
  KeyValueClass(value: "school_campus", name: "School in Campus"),
  KeyValueClass(value: "underground_light_fitting", name: "Underground light fitting "),
  KeyValueClass(value: "children_play_area", name: "Children Play Area"),
  KeyValueClass(value: "common_water_supply", name: "Common Water Supply"),
  KeyValueClass(value: "swimming pool", name: "Swimming Pool"),
  KeyValueClass(value: "club_house", name: "Clubhouse"),
  KeyValueClass(value: "24X7 Security", name: "24*7 Security"),
  KeyValueClass(value: "club_house", name: "Clubhouse"),
  KeyValueClass(value: "swimming pool", name: "Swimming Pool"),
  KeyValueClass(value: "Gymnasium", name: "Gymnasium"),
  KeyValueClass(value: "CCTV Security", name: "CCTV Security"),
  KeyValueClass(value: "Conference_Hal", name: "Conference Hall"),
  KeyValueClass(value: "Private Car Parking", name: "Private Car Parking"),
];

class SliderDetail extends StatefulWidget {
  ListingNew? propertyData;
  SliderDetail({super.key,required this.propertyData});

  @override
  State<SliderDetail> createState() => _SliderDetailState();
}

class _SliderDetailState extends State<SliderDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(AppStrings.propertyMaster,style: TextStyle(color: AppColors.white,),),
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.propertyData!.heading!,style: const TextStyle(fontSize: 20.0,),),
                  Row(
                    children: [
                      const Text("By "),
                      Text(
                        widget.propertyData!.builderName!,
                        style: const TextStyle(color: AppColors.colorSecondaryDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    widget.propertyData!.budget!,
                    style: const TextStyle(fontSize: 16.0,color: AppColors.colorSecondaryDark,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0,),
                  Text("Plot Sizes - ${widget.propertyData!.plotSize!}",),
                  Text("Project Status - ${widget.propertyData!.propertyStatus!}",),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      const Icon(Icons.edit_location,color: AppColors.colorSecondary),
                      Text(widget.propertyData!.location!,),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Text("RERA Registered No: ${widget.propertyData!.registrationNumber!}",),
                ],
              ),
            ),
            SliderDetailCarousel(imgList: widget.propertyData!.multipleImage!),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Amenities at ${widget.propertyData!.heading}",style: const TextStyle(fontSize: 20.0,),),
                  const SizedBox(height: 10.0,),
                  Wrap(
                    runSpacing: 5.0,
                    spacing: 5.0,
                    children: [
                      for (var amenity in widget.propertyData!.amenities!)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0,),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.colorSecondary,
                                    width: 1.0,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  amenitiesList.firstWhere((element) => element.value == amenity, orElse: () => const KeyValueClass(value: '', name: '')).name,
                                  style: const TextStyle(
                                    color: AppColors.textColorGrey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width * 1,
            //   padding: const EdgeInsets.all(10.0),
            //   margin: const EdgeInsets.all(8.0),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5.0),
            //     color: AppColors.white,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Home Loan Offers for ${widget.propertyData!.heading}",style: const TextStyle(fontSize: 20.0,),),
            //       const SizedBox(height: 10.0,),
            //       Wrap(
            //         runSpacing: 5.0,
            //         spacing: 5.0,
            //         children: [
            //           for (var i = 0; i < amenitiesList.length; i++)
            //             Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Container(
            //                   padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0,),
            //                   decoration: BoxDecoration(
            //                     border: Border.all(
            //                         color: AppColors.colorSecondary,
            //                         width: 1.0,
            //                         style: BorderStyle.solid
            //                     ),
            //                     borderRadius: BorderRadius.circular(5.0),
            //                     color: Colors.white,
            //                   ),
            //                   child: Center(
            //                     child: Text(
            //                       amenitiesList[i].name,
            //                       style: const TextStyle(
            //                         color: AppColors.textColorGrey,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About ${widget.propertyData!.heading}",style: const TextStyle(fontSize: 20.0,),),
                  const SizedBox(height: 10.0,),
                  Text(widget.propertyData!.about!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
