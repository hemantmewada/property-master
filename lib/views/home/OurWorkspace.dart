// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/const.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OurWorkspace extends StatefulWidget {
  const OurWorkspace({super.key});

  @override
  _OurWorkspaceState createState() => _OurWorkspaceState();
}

class _OurWorkspaceState extends State<OurWorkspace> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = ourWorkSpaceList!
        .map((item) {
          return Stack(
              children: [
                /*Image.asset(
                  item.image,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                ),*/
                CachedNetworkImage(
                  imageUrl: item.image,
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 15.0,
                  right: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(0.0,10.0,20.0,10.0,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 2,
                          style: TextStyle(color: AppColors.white,fontSize: 20.0,fontWeight: FontWeight.w700,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
        })
        .toList();

    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              pauseAutoPlayInFiniteScroll: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              aspectRatio: 1.9,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              }),
        ),
        Positioned(
          left: 15.0,
          bottom: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ourWorkSpaceList!.map((url) {
              int index = ourWorkSpaceList!.indexOf(url);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 3,),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? AppColors.colorSecondary : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
