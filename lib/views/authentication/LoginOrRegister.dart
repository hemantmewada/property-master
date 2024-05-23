import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/authentication/loginFreeUser.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.white,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xbeed6a45),
              AppColors.colorSecondaryLight,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png',width: 200.0,),
                const SizedBox(height: 10.0,),
                const Text(
                  AppStrings.pleaseSelectTypeToLogin,
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 20.0,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 750),
                          isIos: true,
                          child: const LoginRegisteredUser(),
                        )
                    );
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0,),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black38,
                          width: 1.0,
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SvgPicture.asset(
                            'assets/icons/registered_user.svg',
                            width: 23.0,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(AppStrings.registeredUser),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.double_arrow_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 750),
                          isIos: true,
                          child: const LoginFreeUser(),
                        )
                    );
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0,),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black38,
                          width: 1.0,
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SvgPicture.asset(
                            'assets/icons/free_user.svg',
                            width: 23.0,
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Text(AppStrings.freeUser),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.double_arrow_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
