import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/models/PropertyDataModel.dart';
import 'package:propertymaster/utilities/Urls.dart';

class PropertyDetail extends StatefulWidget {
  Listing? propertyData;
  PropertyDetail({super.key,required this.propertyData});

  @override
  State<PropertyDetail> createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('propertyTitle : ${widget.propertyData!.propertyTitle}');
    print('about : ${widget.propertyData!.about}');
    print('detail : ${widget.propertyData!.detail}');
    print('location : ${widget.propertyData!.location}');
    print('image : ${widget.propertyData!.image}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitish,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        iconTheme: const IconThemeData(color: AppColors.white,),
        title: const Text(
          AppStrings.propertyMaster,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.propertyData!.propertyTitle!.toUpperCase(),
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 20.0,
              ),
            ),
            Html(
              data: widget.propertyData!.about,
              style: {
                "body" : Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
            Image.network(
              Urls.imageUrl + widget.propertyData!.image!,
            ),
            Html(
              data: widget.propertyData!.detail,
              style: {
                "body" : Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}