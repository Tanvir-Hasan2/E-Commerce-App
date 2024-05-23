import 'package:e_commerce/Const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomButton(
String title,
onPressed,
){
  return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColors.mandarinColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 14.sp,
      ),
      padding: EdgeInsets.symmetric(horizontal: 30),
    ),
  );
}

