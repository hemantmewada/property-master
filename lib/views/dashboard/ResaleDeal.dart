import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/resale-deal/ResaleDealDashboard.dart';

class ResaleDeal extends StatefulWidget {
  const ResaleDeal({super.key});

  @override
  State<ResaleDeal> createState() => _ResaleDealState();
}

class _ResaleDealState extends State<ResaleDeal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 100),
          isIos: true,
          child: ResaleDealDashboard(bottomIndex: 0),
        ),
        (route) => false,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(""),);
  }
}
