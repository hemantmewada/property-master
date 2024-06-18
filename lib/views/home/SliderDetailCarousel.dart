// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SliderDetailCarousel extends StatefulWidget {
  List<String>? imgList;

  SliderDetailCarousel({required this.imgList});

  @override
  _SliderDetailCarouselState createState() => _SliderDetailCarouselState();
}

class _SliderDetailCarouselState extends State<SliderDetailCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList!
        .map((item) {
      return CachedNetworkImage(
        imageUrl: item,
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,)),
        errorWidget: (context, url, error) => Icon(Icons.error),
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
              aspectRatio: 1.7,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList!.map((url) {
              int index = widget.imgList!.indexOf(url);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  _current == index ? AppColors.colorSecondary : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
