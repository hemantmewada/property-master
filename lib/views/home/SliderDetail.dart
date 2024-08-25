// ignore_for_file: use_build_context_synchronously, sort_child_properties_last


import 'package:flutter/material.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/home/SliderDetailCarousel.dart';
import 'package:url_launcher/url_launcher.dart';

const List<KeyValueClass> amenitiesList = [
  KeyValueClass(value: "covered_campus", name: "Covered Campus"),
  KeyValueClass(value: "semi_covered_campus", name: "Semi Covered Campus"),
  KeyValueClass(value: "school_campus", name: "School in Campus"),
  KeyValueClass(value: "underground_light_fitting", name: "Underground light"),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Project Name: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                            fontFamily: "Poppins"
                          ),
                        ),
                        TextSpan(
                          text: widget.propertyData!.heading!,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColors.colorSecondaryDark,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   widget.propertyData!.heading!,
                  //   style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),
                  // ),
                  Row(
                    children: [
                      const Text("By "),
                      Text(
                        widget.propertyData!.builderName!,
                        style: const TextStyle(color: AppColors.colorSecondaryDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Price Starts From: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                            fontFamily: "Poppins"
                          ),
                        ),
                        TextSpan(
                          text: widget.propertyData!.budget!,
                          style: const TextStyle(
                            color: AppColors.colorSecondaryDark,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   widget.propertyData!.budget!,
                  //   style: const TextStyle(fontSize: 16.0,color: AppColors.colorSecondaryDark,fontWeight: FontWeight.bold),
                  // ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Size Starts From: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                            fontFamily: "Poppins"
                          ),
                        ),
                        TextSpan(
                          text: widget.propertyData!.plotSize!,
                          style: const TextStyle(
                            color: AppColors.colorSecondaryDark,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Project Status: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                            fontFamily: "Poppins"
                          ),
                        ),
                        TextSpan(
                          text: widget.propertyData!.propertyStatus!,
                          style: const TextStyle(
                            color: AppColors.colorSecondaryDark,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Location And Address: ",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                            fontFamily: "Poppins"
                          ),
                        ),
                        TextSpan(
                          text: widget.propertyData!.location!,
                          style: const TextStyle(
                            color: AppColors.colorSecondaryDark,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Layout Map: ",
                        style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: AppColors.black,),
                      ),
                      InkWell(
                        onTap: () => openPdf(widget.propertyData!.map!),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Click to Open",style: TextStyle(color: AppColors.colorSecondary,),),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                            const Icon(Icons.download_rounded, size: 16.0, color: AppColors.colorSecondary,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
                  const Text("Amenities",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  Wrap(
                    runSpacing: 5.0,
                    spacing: 5.0,
                    children: [
                      for (var entry in widget.propertyData!.amenities!.asMap().entries)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${entry.key + 1}. ${amenitiesList.firstWhere((element) => element.value == entry.value, orElse: () => const KeyValueClass(value: '', name: '')).name} ',),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
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
                  const Text("About",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  Text(widget.propertyData!.about!),
                ],
              ),
            ),
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
                  const Text("Home Loan Providers",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,),),
                  const SizedBox(height: 10.0,),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.propertyData!.loanProvider!.length,
                      itemBuilder: (BuildContext context, int index) => Text('${index+1}. ${widget.propertyData!.loanProvider![index].name!}',)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> openPdf(String url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url,mode: LaunchMode.externalApplication);
  }
}
