import 'package:flutter/material.dart';
import 'package:propertymaster/utilities/AppColors.dart';


class Loader {

  static ProgressloadingDialog(BuildContext context,bool status) {
    if(status){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.colorSecondary,),
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