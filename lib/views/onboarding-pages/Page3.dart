import 'package:flutter/material.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
                AppStrings.page3Paragraph,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
