import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/views/dashboard/dashboard.dart';
import 'package:propertymaster/views/onboarding-pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePref();
  }
  Future<void> sharePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if(prefs.getBool('isLogin') == true){
      goToScreen(Dashboard(bottomIndex: 0));
    }else{
      goToScreen(const Onboarding());
    }
  }
  Future<void> goToScreen(Widget whereToGo) async {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 500),
          isIos: true,
          child: whereToGo,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
