import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppStyles {
//loading
  progressDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/files/loading.gif',
              height: 150.h,
            ),
          );
        });
  }

  // failed snackbar
  GetSnackBar customSnackBar(message) => GetSnackBar(
        message: message,
        borderColor: Colors.amber,
        borderWidth: 2,
        borderRadius: 20,
        overlayColor: Colors.transparent,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        backgroundColor: Colors.black87,
        duration: Duration(seconds: 2),
        icon: Image.asset('assets/icons/logo.png', height: 20, width: 20)


  );

}


