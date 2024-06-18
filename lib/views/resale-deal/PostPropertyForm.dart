// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/models/PostPropertyModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/Utility.dart';
// apis
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:dio/dio.dart';
import 'package:propertymaster/models/LocationListPostPropertyModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// apis

const List<String> plotTypePropertyList = <String>[
  'Residential Plot',
  'Commercial Plot',
  'Industrial Land',
  'Farmhouse Land',
  'Agriculture Land',
];
const List<String> commercialTypePropertyList = <String>[
  'Office Space',
  'Commercial Space',
  'Showroom',
  'Godown',
  'Warehouse',
];
const List<String> flatHouseTypePropertyList = <String>[
  'Flat',
  'Row house',
  'Bungalows',
  'Villas',
];

const List<String> facingList = <String>[
  'East',
  'West',
  'North',
  'South',
];
const List<String> floorList = <String>[
  'Ground Floor',
  'First Floor',
  'Second Floor',
  'Third Floor',
];
const List<String> noOfFloorList = <String>[
  'Ground Floor',
  'G + One',
  'G + Two',
  'G + Three',
];
const List<String> furnishedList = <String>[
  'Non furnished',
  'Semi furnished',
  'Full furnished',
];
const List<String> flatSizeList = <String>[
  '1BHK',
  '2BHK',
  '3BHK',
  '4BHK',
];
const List<String> openSideList = <String>[
  'One',
  'Two',
  'Three',
  'Four',
];
const List<String> possessionStatusList = <String>[
  'New Project',
  'Ready to move',
  'Under Development',
];
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
];
const List<KeyValueClass> otherAmenitiesList = <KeyValueClass>[
  KeyValueClass(value: "club_house", name: "Clubhouse"),
  KeyValueClass(value: "swimming pool", name: "Swimming Pool"),
  KeyValueClass(value: "Gymnasium", name: "Gymnasium"),
  KeyValueClass(value: "CCTV Security", name: "CCTV Security"),
  KeyValueClass(value: "Conference_Hal", name: "Conference Hall"),
  KeyValueClass(value: "Private Car Parking", name: "Private Car Parking"),
];
String location = "";
class PostPropertyForm extends StatefulWidget {
  final String type;
  const PostPropertyForm({super.key,required this.type});

  @override
  State<PostPropertyForm> createState() => _PostPropertyFormState();
}

class _PostPropertyFormState extends State<PostPropertyForm> {
  var projectColonyNameController = TextEditingController();
  var locationNameController = TextEditingController();
  var propertyAddressController = TextEditingController();
  var associativeNameController = TextEditingController();
  var associativeContactController = TextEditingController();
  var widthController = TextEditingController();
  var lengthController = TextEditingController();
  var superBuildupAreaController = TextEditingController();
  var totalNoOfFloorsController = TextEditingController();
  var totalAreaController = TextEditingController();
  var expectedPriceController = TextEditingController();
  var pricePerSqFtController = TextEditingController();
  String userID = "";
  String role = "";
  String plotTypeProperty = plotTypePropertyList.first;
  String commercialTypeProperty = commercialTypePropertyList.first;
  String flatHouseTypeProperty = flatHouseTypePropertyList.first;
  String facing = facingList.first;
  String floor = floorList.first;
  String noOfFloor = noOfFloorList.first;
  String furnished = furnishedList.first;
  String flatSize = flatSizeList.first;
  String openSide = openSideList.first;
  String possessionStatus = possessionStatusList.first;
  String transactionType = "First Sale";
  var descriptionController = TextEditingController();

  List<String> selectedAmenitiesList = [];
  List<String> locationList = [];

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
    print("widget.type---------${widget.type}");
    location = "";
    locationListPostPropertyAPI(context);
    setState(() {});
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset('assets/icons/back2.svg',color: AppColors.white,width: 25.0,height: 25.0,),
                  ),
                  const SizedBox(width: 10.0,),
                  Text(widget.type,style: const TextStyle(fontSize: 22.0,color: AppColors.white,),),
                ],
              ),
              const SizedBox(height: 20.0,),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorSecondaryLight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // project Colony Name
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: containerDecoration,
                child: TextFormField(
                  controller: projectColonyNameController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                  cursorColor: AppColors.textColorGrey,
                  decoration: inputDecoration(AppStrings.projectColonyName),
                ),
              ),
              const SizedBox(height: 15.0,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.locationName),
                        const SizedBox(height: 5.0,),
                        Container(
                          // height: 38.0,
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          /*child: TextFormField(
                            controller: locationNameController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: inputDecoration(AppStrings.locationName),
                          ),*/
                          child: AutoCompleteLeadSource(locationList: locationList),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.type == AppStrings.plots ? AppStrings.plotType : widget.type == AppStrings.commercialSpace ? AppStrings.spaceType : AppStrings.homeType),
                        const SizedBox(height: 5.0,),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0,),
                          decoration: containerDecoration,
                          child: widget.type == AppStrings.plots ?
                          PlotTypePropertyDropdown(
                            value: plotTypeProperty,
                            onChange: (newValue){
                              setState((){
                                plotTypeProperty = newValue;
                              });
                            },
                          ) : widget.type == AppStrings.commercialSpace ?
                          CommercialTypePropertyDropdown(
                            value: commercialTypeProperty,
                            onChange: (newValue){
                              setState((){
                                commercialTypeProperty = newValue;
                              });
                            },
                          ) :
                          FlatHouseTypePropertyDropdown(
                            value: flatHouseTypeProperty,
                            onChange: (newValue){
                              setState((){
                                flatHouseTypeProperty = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if(role == "Sr Business Manager" || role == "Manager")
              Column(
                children: [
                  const SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          child: TextFormField(
                            controller: associativeNameController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: inputDecoration(AppStrings.associativeName),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          child: TextFormField(
                            readOnly: true,
                            controller: associativeContactController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: inputDecoration(AppStrings.associativeContact),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: containerDecoration,
                child: TextFormField(
                  controller: propertyAddressController,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                  cursorColor: AppColors.textColorGrey,
                  decoration: inputDecoration(AppStrings.propertyAddress),
                ),
              ),
              widget.type == AppStrings.plots ?
              Column(
                    children: [
                      const SizedBox(height: 15.0,),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: TextFormField(
                                onChanged: (width) {
                                  if(width == ""){
                                    Utilities().toast("Invalid width.");
                                    totalAreaController.text = "";
                                    return;
                                  } else if(int.parse(width) < 1){
                                    Utilities().toast("Invalid width.");
                                    totalAreaController.text = "";
                                    return;
                                  }
                                  var length = lengthController.text;
                                  if(length != "" && int.parse(length) > 0){
                                    int totalArea = int.parse(width) * int.parse(length);
                                    totalAreaController.text = totalArea.toString();
                                    var expectedPrice = expectedPriceController.text;
                                    if(totalArea > 0 && expectedPrice != "" && int.parse(expectedPrice) > 0){
                                      int pricePerSqFt = int.parse(expectedPrice) ~/ totalArea;
                                      pricePerSqFtController.text = pricePerSqFt.toString();
                                    }
                                  }
                                },
                                controller: widthController,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                                cursorColor: AppColors.textColorGrey,
                                decoration: inputDecoration(AppStrings.width),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: TextFormField(
                                onChanged: (length) {
                                  if(length == ""){
                                    Utilities().toast("Invalid length.");
                                    totalAreaController.text = "";
                                    return;
                                  } else if(int.parse(length) < 1){
                                    Utilities().toast("Invalid length.");
                                    totalAreaController.text = "";
                                    return;
                                  }
                                  var width = widthController.text;
                                  if(width != "" && int.parse(width) > 0){
                                    int totalArea = int.parse(width) * int.parse(length);
                                    totalAreaController.text = totalArea.toString();
                                    var expectedPrice = expectedPriceController.text;
                                    if(totalArea > 0 && expectedPrice != "" && int.parse(expectedPrice) > 0){
                                      int pricePerSqFt = int.parse(expectedPrice) ~/ totalArea;
                                      pricePerSqFtController.text = pricePerSqFt.toString();
                                    }
                                  }
                                },
                                controller: lengthController,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                                cursorColor: AppColors.textColorGrey,
                                decoration: inputDecoration(AppStrings.length),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: TextFormField(
                                readOnly: true,
                                controller: totalAreaController,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                                cursorColor: AppColors.textColorGrey,
                                decoration: inputDecoration(AppStrings.totalArea),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(AppStrings.facing),
                                const SizedBox(height: 5.0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                  decoration: containerDecoration,
                                  child: FacingDropdown(
                                    value: facing,
                                    onChange: (newValue){
                                      setState((){
                                        facing = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(AppStrings.openSide),
                                const SizedBox(height: 5.0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                                  decoration: containerDecoration,
                                  child: OpenSideDropdown(
                                    value: openSide,
                                    onChange: (newValue){
                                      setState((){
                                        openSide = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
              ) :
              Column(
                children: [
                  const SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          child: TextFormField(
                            onChanged: (superBuildupArea) {
                              if(superBuildupArea == ""){
                                Utilities().toast("Invalid width.");
                                totalAreaController.text = "";
                                pricePerSqFtController.text = "";
                                superBuildupAreaController.text = "";
                                return;
                              } else if(int.parse(superBuildupArea) < 1){
                                Utilities().toast("Invalid width.");
                                totalAreaController.text = "";
                                pricePerSqFtController.text = "";
                                superBuildupAreaController.text = "";
                                return;
                              }
                              var expectedPrice = expectedPriceController.text;
                              if(expectedPrice != "" && int.parse(expectedPrice) > 0){
                                int pricePerSqFt = int.parse(expectedPrice) ~/ int.parse(superBuildupArea);
                                pricePerSqFtController.text = pricePerSqFt.toString();
                              }
                            },
                            controller: superBuildupAreaController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: inputDecoration(AppStrings.superBuildupArea),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          child: TextFormField(
                            controller: totalNoOfFloorsController,
                            textCapitalization: TextCapitalization.words,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                            cursorColor: AppColors.textColorGrey,
                            decoration: inputDecoration(AppStrings.totalNoOfFloors),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  widget.type == AppStrings.commercialSpace && commercialTypeProperty != "Godown" ?
                  Row(
                    children: [
                      widget.type == AppStrings.commercialSpace ?
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.spaceOnWhichFloor),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FloorDropdown(
                                value: floor,
                                onChange: (newValue){
                                  setState((){
                                    floor = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ) :
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.flatSize),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FlatSizeDropdown(
                                value: flatSize,
                                onChange: (newValue){
                                  setState((){
                                    flatSize = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.furnishedStatus,),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FurnishedDropdown(
                                value: furnished,
                                onChange: (newValue){
                                  setState((){
                                    furnished = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : widget.type == AppStrings.commercialSpace ?
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.noOfFloor),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: NoOfFloorDropdown(
                                value: noOfFloor,
                                onChange: (newValue){
                                  setState((){
                                    noOfFloor = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.furnishedStatus,style: TextStyle(fontSize: 13.0,),),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FurnishedDropdown(
                                value: furnished,
                                onChange: (newValue){
                                  setState((){
                                    furnished = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.facing),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FacingDropdown(
                                value: facing,
                                onChange: (newValue){
                                  setState((){
                                    facing = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : Container(),
                  widget.type == AppStrings.flatHouseVilla && flatHouseTypeProperty != "Flat" ?
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.noOfFloor),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: NoOfFloorDropdown(
                                value: noOfFloor,
                                onChange: (newValue){
                                  setState((){
                                    noOfFloor = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.furnishedStatus,style: TextStyle(fontSize: 13.0,),),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FurnishedDropdown(
                                value: furnished,
                                onChange: (newValue){
                                  setState((){
                                    furnished = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.facing),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FacingDropdown(
                                value: facing,
                                onChange: (newValue){
                                  setState((){
                                    facing = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : widget.type == AppStrings.flatHouseVilla ?
                  Row(
                    children: [
                      widget.type == AppStrings.commercialSpace ?
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.spaceOnWhichFloor),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FloorDropdown(
                                value: floor,
                                onChange: (newValue){
                                  setState((){
                                    floor = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ) :
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.flatSize),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FlatSizeDropdown(
                                value: flatSize,
                                onChange: (newValue){
                                  setState((){
                                    flatSize = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(AppStrings.furnishedStatus,),
                            const SizedBox(height: 5.0,),
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                              decoration: containerDecoration,
                              child: FurnishedDropdown(
                                value: furnished,
                                onChange: (newValue){
                                  setState((){
                                    furnished = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) : Container(),
                ],
              ),
              const SizedBox(height: 15.0,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.transactionType),
                        const SizedBox(height: 5.0,),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0,),
                          decoration: containerDecoration,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    transactionType = "First Sale";
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0,),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colorSecondary,
                                          width: 1.0,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: transactionType == "First Sale" ? AppColors.colorSecondary : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "First Sale",
                                        style: TextStyle(
                                          color: transactionType == "First Sale" ? AppColors.white : AppColors.textColorGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5.0,),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    transactionType = "ReSale";
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0,),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colorSecondary,
                                          width: 1.0,
                                          style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: transactionType == "ReSale" ? AppColors.colorSecondary : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "ReSale",
                                        style: TextStyle(
                                          color: transactionType == "ReSale" ? AppColors.white : AppColors.textColorGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppStrings.possessionStatus),
                        const SizedBox(height: 5.0,),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                          decoration: containerDecoration,
                          child: possessionStatusDropdown(
                            value: possessionStatus,
                            onChange: (newValue){
                              setState((){
                                possessionStatus = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: containerDecoration,
                      child: TextFormField(
                        onChanged: (pricePerSqFt) {
                          if(pricePerSqFt == ""){
                            Utilities().toast("Invalid length.");
                            pricePerSqFtController.text = "";
                            expectedPriceController.text = "";
                            return;
                          } else if(int.parse(pricePerSqFt) < 1){
                            Utilities().toast("Invalid length.");
                            pricePerSqFtController.text = "";
                            expectedPriceController.text = "";
                            return;
                          }
                          if(widget.type == AppStrings.plots){
                            var totalArea = totalAreaController.text;
                            if(totalArea != "" && int.parse(totalArea) > 0){
                              int expectedPrice = int.parse(pricePerSqFt) * int.parse(totalArea);
                              expectedPriceController.text = expectedPrice.toString();
                            }
                          }else{
                            var superBuildupArea = superBuildupAreaController.text;
                            if(superBuildupArea != "" && int.parse(superBuildupArea) > 0){
                              int expectedPrice = int.parse(pricePerSqFt) * int.parse(superBuildupArea);
                              expectedPriceController.text = expectedPrice.toString();
                            }
                          }
                        },
                        controller: pricePerSqFtController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        decoration: inputDecoration(AppStrings.pricePerSqFt),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                      decoration: containerDecoration,
                      child: TextFormField(
                        readOnly: true,
                        controller: expectedPriceController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                        cursorColor: AppColors.textColorGrey,
                        decoration: inputDecoration(AppStrings.expectedPrice),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              const Text(AppStrings.amenities),
              const SizedBox(height: 5.0,),
              widget.type == AppStrings.plots ?
              Wrap(
                runSpacing: 5.0,
                spacing: 5.0,
                children: [
                  for (var i = 0; i < amenitiesList.length; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if(selectedAmenitiesList.contains(amenitiesList[i].value)){
                              selectedAmenitiesList.remove(amenitiesList[i].value);
                            }else{
                              selectedAmenitiesList.add(amenitiesList[i].value);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.colorSecondary,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                              color: selectedAmenitiesList.contains(amenitiesList[i].value) ? AppColors.colorSecondary : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                amenitiesList[i].name,
                                style: TextStyle(
                                  color: selectedAmenitiesList.contains(amenitiesList[i].value) ? AppColors.white : AppColors.textColorGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ) :
              Wrap(
                runSpacing: 5.0,
                spacing: 5.0,
                children: [
                  for (var i = 0; i < otherAmenitiesList.length; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if(selectedAmenitiesList.contains(otherAmenitiesList[i].value)){
                              selectedAmenitiesList.remove(otherAmenitiesList[i].value);
                            }else{
                              selectedAmenitiesList.add(otherAmenitiesList[i].value);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0,),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.colorSecondary,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                              color: selectedAmenitiesList.contains(otherAmenitiesList[i].value) ? AppColors.colorSecondary : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                otherAmenitiesList[i].name,
                                style: TextStyle(
                                  color: selectedAmenitiesList.contains(otherAmenitiesList[i].value) ? AppColors.white : AppColors.textColorGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 15.0,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                decoration: containerDecoration,
                child: TextFormField(
                  controller: descriptionController,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 14.0, color: AppColors.black,),
                  cursorColor: AppColors.textColorGrey,
                  decoration: inputDecoration(AppStrings.description),
                ),
              ),
              InkWell(
                onTap: () {
                  String projectColonyName = projectColonyNameController.text;
                  String width = widthController.text;
                  String length = lengthController.text;
                  String expectedPrice = expectedPriceController.text;
                  String pricePerSqFt = pricePerSqFtController.text;
                  String superBuildupArea = superBuildupAreaController.text;
                  String totalNoOfFloors = totalNoOfFloorsController.text;
                  if(projectColonyName.isEmpty) {
                    Utilities().toast(AppStrings.projectColonyToast);
                  }else if(location.isEmpty){
                    Utilities().toast(AppStrings.locationNameToast);
                  }else if(expectedPrice.isEmpty || int.parse(expectedPrice) < 1){
                    Utilities().toast(AppStrings.expectedPriceValidToast);
                  }else if(pricePerSqFt.isEmpty || int.parse(pricePerSqFt) < 1){
                    Utilities().toast(AppStrings.pricePerSqFtValidToast);
                  }else if(widget.type == AppStrings.plots){
                    if(width.isEmpty || int.parse(width) < 1) {
                      Utilities().toast(AppStrings.widthValidToast);
                    }else if(length.isEmpty || int.parse(length) < 1){
                      Utilities().toast(AppStrings.lengthValidToast);
                    }else {
                      // Utilities().toast("all validation done --${widget.type}");
                      postPropertyAPI(context, projectColonyName);
                    }
                  }else if(widget.type == AppStrings.commercialSpace || widget.type == AppStrings.flatHouseVilla){
                    if(superBuildupArea.isEmpty || int.parse(superBuildupArea) < 1) {
                      Utilities().toast(AppStrings.superBuildupAreaValidToast);
                    }else if(totalNoOfFloors.isEmpty || int.parse(totalNoOfFloors) < 1){
                      Utilities().toast(AppStrings.totalNoOfFloorsValidToast);
                    }else {
                      postPropertyAPI(context, projectColonyName);
                      // Utilities().toast("all validation done --${widget.type}");
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20.0,),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Text(
                    AppStrings.submit,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> locationListPostPropertyAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.locationListPostPropertyUrl;
      var formData = FormData.fromMap({});
      final responseDio = await Dio().get(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        LocationListPostPropertyModel response = LocationListPostPropertyModel.fromJson(map);

        if (response.status == true) {
          response.data!.forEach((element) {
            locationList.add(element.location!);
            // locationList.add(element.location!.toLowerCase());
          });
          setState(() {});
        } else {
          Utilities().toast(response.message);
        }
      }
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }
  Future<void> postPropertyAPI(BuildContext context, String projectColonyName) async {
    var typeOfProperty = "";
    if(widget.type == AppStrings.plots){
      typeOfProperty = plotTypeProperty;
    }else if(widget.type == AppStrings.commercialSpace){
      typeOfProperty = commercialTypeProperty;
    }else if(widget.type == AppStrings.flatHouseVilla){
      typeOfProperty = flatHouseTypeProperty;
    }
    Loader.ProgressloadingDialog(context, true);
    try {
      const url = Urls.postPropertyUrl;
      var formData = FormData.fromMap({
        "user_id": userID,
        "calony_name": projectColonyName,
        "type_of_property": typeOfProperty,
        // "location[0]": location,
        "address": propertyAddressController.text,
        "width": widthController.text,
        "length": lengthController.text,
        "totalarea": totalAreaController.text,
        "facing": facing,
        "open_side": openSide,
        "transaction_type": transactionType,
        "possession_status": possessionStatus,
        "expected_price": expectedPriceController.text,
        "price_pr_square": pricePerSqFtController.text,
        // "aminities": selectedAmenitiesList,
        "description_details": descriptionController.text,
        "buildup_area": superBuildupAreaController.text,
        "floor_no": totalNoOfFloorsController.text,
        "your_space_in_which_floor": floor,
        "furnished_status": furnished,
        "floor_no": noOfFloor,
        "flat_size": flatSize,
      });
      formData.fields.add(MapEntry("location[]", location));
      selectedAmenitiesList.forEach((amenity) {
        formData.fields.add(MapEntry("aminities[]", amenity));
      });
      final responseDio = await Dio().post(url,data: formData,);
      Loader.ProgressloadingDialog(context, false);
      if (responseDio.statusCode == 200) {
        print(url);

        Map<String, dynamic> map = (responseDio.data as Map).cast<String, dynamic>();
        PostPropertyModel response = PostPropertyModel.fromJson(map);

        Utilities().toast(response.message);
        if (response.status == true) {
          Navigator.of(context).pop();
          setState(() {});
        }
      }

    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
    return;
  }

}

class PlotTypePropertyDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  PlotTypePropertyDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<PlotTypePropertyDropdown> createState() => _PlotTypePropertyDropdownState();
}
class _PlotTypePropertyDropdownState extends State<PlotTypePropertyDropdown> {
  String dropdownValue = plotTypePropertyList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: plotTypePropertyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CommercialTypePropertyDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  CommercialTypePropertyDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<CommercialTypePropertyDropdown> createState() => _CommercialTypePropertyDropdownState();
}
class _CommercialTypePropertyDropdownState extends State<CommercialTypePropertyDropdown> {
  String dropdownValue = commercialTypePropertyList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: commercialTypePropertyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FlatHouseTypePropertyDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  FlatHouseTypePropertyDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<FlatHouseTypePropertyDropdown> createState() => _FlatHouseTypePropertyDropdownState();
}
class _FlatHouseTypePropertyDropdownState extends State<FlatHouseTypePropertyDropdown> {
  String dropdownValue = flatHouseTypePropertyList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: flatHouseTypePropertyList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FacingDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  FacingDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<FacingDropdown> createState() => _FacingDropdownState();
}
class _FacingDropdownState extends State<FacingDropdown> {
  String dropdownValue = facingList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: facingList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FloorDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  FloorDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<FloorDropdown> createState() => _FloorDropdownState();
}
class _FloorDropdownState extends State<FloorDropdown> {
  String dropdownValue = floorList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: floorList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class NoOfFloorDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  NoOfFloorDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<NoOfFloorDropdown> createState() => _NoOfFloorDropdownState();
}
class _NoOfFloorDropdownState extends State<NoOfFloorDropdown> {
  String dropdownValue = noOfFloorList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,overflow: TextOverflow.ellipsis,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: noOfFloorList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FurnishedDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  FurnishedDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<FurnishedDropdown> createState() => _FurnishedDropdownState();
}
class _FurnishedDropdownState extends State<FurnishedDropdown> {
  String dropdownValue = furnishedList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,overflow: TextOverflow.ellipsis,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: furnishedList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FlatSizeDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  FlatSizeDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<FlatSizeDropdown> createState() => _FlatSizeDropdownState();
}
class _FlatSizeDropdownState extends State<FlatSizeDropdown> {
  String dropdownValue = flatSizeList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,overflow: TextOverflow.ellipsis,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: flatSizeList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class OpenSideDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  OpenSideDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<OpenSideDropdown> createState() => _OpenSideDropdownState();
}
class _OpenSideDropdownState extends State<OpenSideDropdown> {
  String dropdownValue = openSideList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: openSideList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class possessionStatusDropdown extends StatefulWidget {
  String value;
  final Function(String) onChange; // Callback function
  possessionStatusDropdown({super.key,required this.value,required this.onChange,});

  @override
  State<possessionStatusDropdown> createState() => _possessionStatusDropdownState();
}
class _possessionStatusDropdownState extends State<possessionStatusDropdown> {
  String dropdownValue = possessionStatusList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isDense: true,
      padding: const EdgeInsets.symmetric(vertical: 6.5,),
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(fontSize: 15.0,color: AppColors.textColorGrey,),
      underline: Container(color: AppColors.transparent,),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChange(value);
        });
      },
      items: possessionStatusList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class AutoCompleteLeadSource extends StatefulWidget {
  List<String> locationList;
  AutoCompleteLeadSource({super.key,required this.locationList});

  @override
  State<AutoCompleteLeadSource> createState() => _AutoCompleteLeadSourceState();
}
class _AutoCompleteLeadSourceState extends State<AutoCompleteLeadSource> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // if (textEditingValue.text == '') {
        //   return const Iterable<String>.empty();
        // }
        setState(() {
          location = textEditingValue.text;
        });
        return widget.locationList.where((String option) {
          // return option.contains(textEditingValue.text);
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
          // return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        // debugPrint('You just selected $selection');
        location = selection;
        setState(() {});
      },
    );
  }
}