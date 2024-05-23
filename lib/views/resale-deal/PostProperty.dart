// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/views/resale-deal/PostPropertyForm.dart';
// apis
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class PostProperty extends StatefulWidget {
  const PostProperty({super.key});

  @override
  State<PostProperty> createState() => _PostPropertyState();
}
const List<String> requiredPropertyList = <String>[
  'Residential Plots',
  'Commercial Plots',
  'Flats',
  'Ready Duplex',
  'Row House',
  'P plus C',
  'Commercial Office',
  'Commercial Shop',
  'Indestrial Plots',
  'Form House',
  'Agriculture Land',
  'SNW Villas Omkareshwar',
];
const List<String> budgetList = <String>[
  '15 to 20 Lakh',
  '20 to 30 Lakh',
  '30 to 40 Lakh',
  '40 to 50 Lakh ',
  '50 to 60 Lakh',
  '60 to 70 Lakh',
  '70 to 85 Lakh',
  '85 Lakh to 1 cr',
  '2 cr',
  '3 cr',
  '4 cr',
  '5 cr',
  '10 cr and above',
];
const List<String> locationList = <String>[
  'Tricon City',
  'Info City',
  'The Grand Virasat',
  'Singapur Gold City 1',
  'White Pearl',
  'Parshvanath',
];

String leadSource = "";
class _PostPropertyState extends State<PostProperty> {
  late String userID;
  late String role;


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
                  const Text(AppStrings.postProperty,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
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
              const SizedBox(height: 10.0,),
              const Text(AppStrings.whatTypeProperty,style: TextStyle(fontSize: 18.0),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  const Expanded(
                    flex: 1,
                    child: PlotType(
                        icon: Icons.maps_home_work_outlined,
                        heading: AppStrings.plots,
                        desc: "Residential Plots, Flat, Bungalows",
                        goTo: PostPropertyForm(type: AppStrings.plots),
                      ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                children: [
                  const SizedBox(width: 20.0),
                  const Expanded(
                    flex: 3,
                    child: PlotType(
                        icon: Icons.add_home_work_outlined,
                        heading: AppStrings.commercialSpace,
                        desc: "Commercial plot, Office space, Showroom",
                        goTo: PostPropertyForm(type: AppStrings.commercialSpace),
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  const Expanded(
                    flex: 3,
                    child: PlotType(
                        icon: Icons.warehouse_outlined,
                        heading: AppStrings.flatHouseVilla,
                        desc: "Farmhouse plots, Agriculture land, Villas",
                        goTo: PostPropertyForm(type: AppStrings.flatHouseVilla),
                      ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PlotType extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String desc;
  final Widget goTo;
  const PlotType({super.key,required this.icon,required this.heading,required this.desc,required this.goTo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 750),
              isIos: true,
              child: goTo,
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0,),),
          border: Border.all(style: BorderStyle.solid,width: 2.0,color: AppColors.colorSecondaryLight),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 25.0,),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,color: AppColors.colorSecondaryLight,size: 35.0,),
            const SizedBox(width: 10.0,),
            Text(heading,style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),
            Text(desc,style: const TextStyle(fontSize: 12.0,),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
