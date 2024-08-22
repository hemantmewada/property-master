import 'package:flutter/material.dart';
import 'package:propertymaster/utilities/AppColors.dart';


class Loader {

  static ProgressloadingDialog(BuildContext context,bool status) {
    if(status){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              // child: CircularProgressIndicator(color: AppColors.colorSecondary,),
              child: Image.asset('assets/icons/spinner.gif',width: 64.0,),
            );
          });
      // return pr.show();
    }else{
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static Future<void> showAlertDialog(BuildContext context,bool status) async {
    if (status) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(color: AppColors.colorSecondary),
        ),
      );

    }else{
      await Future.delayed(Duration(seconds: 0),(){
        Navigator.of(context, rootNavigator: true).pop();
      });


    }
  }
  static  hideKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
Widget loaderGIF = Image.asset('assets/icons/spinner.gif',width: 50.0,);