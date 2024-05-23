import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/authentication/LoginOrRegister.dart';
import 'package:propertymaster/views/onboarding-pages/Page1.dart';
import 'package:propertymaster/views/onboarding-pages/Page2.dart';
import 'package:propertymaster/views/onboarding-pages/Page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // page view
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  _currentIndex = index;
                  print('_currentIndex index is---------$_currentIndex');
                  setState(() {});
                },
                reverse: false,
                children: const [
                  Page1(),
                  Page2(),
                  Page3(),
                ],
              ),
            ),

            // dot indicators
            Stack(
              children: [
                SmoothPageIndicator(
                  onDotClicked: (index) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  controller: _controller,
                  count: 3,
                  effect: const ScrollingDotsEffect(
                    activeStrokeWidth: 2.6,
                    activeDotScale: 1.3,
                    maxVisibleDots: 5,
                    radius: 8,
                    spacing: 10,
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: AppColors.colorSecondaryDark,
                    dotColor: AppColors.colorSecondaryLight,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,),
              height: 50.0,
              decoration: const BoxDecoration(
                color: AppColors.colorSecondaryDark,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorSecondaryLight,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 9.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  _currentIndex == 2
                      ? Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 500),
                          isIos: true,
                          child: const LoginOrRegister(),
                        ),
                      )
                      : _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    _currentIndex == 2 ? AppStrings.getStarted : AppStrings.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
