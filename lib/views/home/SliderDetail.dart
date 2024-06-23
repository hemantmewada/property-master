// ignore_for_file: use_build_context_synchronously, sort_child_properties_last


import 'package:flutter/material.dart';
import 'package:propertymaster/models/HomePageDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/views/home/SliderDetailCarousel.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';

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
                      const Icon(Icons.location_on,color: AppColors.colorSecondary),
                      Text(widget.propertyData!.location!,),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("RERA Registered No: ${widget.propertyData!.registrationNumber!}",),
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () async {
                          Map<Permission, PermissionStatus> statuses = await [
                            Permission.storage,
                            //add more permission to request here.
                          ].request();

                          if(statuses[Permission.storage]!.isGranted){
                            var dir = await DownloadsPathProvider.downloadsDirectory;
                            if(dir != null){
                              String savename = "${widget.propertyData!.heading!}-${new DateTime.timestamp()}.pdf";
                              String savePath = "${dir.path}/$savename";
                              print(savePath);
                              //output:  /storage/emulated/0/Download/banner.png

                              try {
                                await Dio().download(
                                    widget.propertyData!.certificateUpload!,
                                    savePath,
                                    onReceiveProgress: (received, total) {
                                      if (total != -1) {
                                        print("${(received / total * 100).toStringAsFixed(0)}%");
                                        //you can build progressbar feature too
                                      }
                                    });
                                print("File is saved to download folder.");
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("File Downloaded"),
                                ));
                              } on DioError catch (e) {
                                print(e.message);
                              }
                            }
                          }else{
                            print("No permission to read and write.");
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Permission Denied !"),
                            ));
                          }
                        },
                        child: const Icon(Icons.file_download_outlined,color: AppColors.colorSecondary,),
                      ),
                    ],
                  ),
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
                  Text("Home Loan Offers for ${widget.propertyData!.heading}",style: const TextStyle(fontSize: 20.0,),),
                  const SizedBox(height: 10.0,),
                  SizedBox(
                    height: 100.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.propertyData!.loanProvider!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Image.network(widget.propertyData!.loanProvider![index].image!,height: 80.0,),
                              Text(widget.propertyData!.loanProvider![index].name!,),
                            ],
                          );
                        }
                    ),
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
