import 'package:flutter/material.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              color: AppColors.white,
              child: Image.asset(
                'assets/images/people.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                AppStrings.page1Paragraph,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
