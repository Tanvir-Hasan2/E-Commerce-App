import 'package:e_commerce/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customFormField(
    //ei gulo pass kortei hobe default vabe set kora ty
    // amr shob gulo text formfield er jonno same
    keyboardtype,
    controller,
    context,
    hinttext,
    validator, {
      //ei gulo optional (pass na korle o hobe.
      // ty amn vabe rakha hoyece and pore ta parameter
      //vabe pass kora hoyece
      bool obscureText = false,
      prefixIcon,
      readOnly = false,
      bool showPasswordToggle = false, // Optional parameter for password toggle

    })
{
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      keyboardType: keyboardtype,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 5,
            bottom: 5,
            right: 10,
          ),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFDF2EE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              prefixIcon,
              color: AppColors.mandarinColor,
              size: 20,
            ),
          ),
        ),
        // suffixIcon: showPasswordToggle
        //     ? InkWell(
        //   onTap: () {
        //     controller.obscureText.value = !controller.obscureText.value;
        //   },
        //   child: Obx(() {
        //     return Icon(controller.obscureText.value ? Icons.visibility : Icons.visibility_off);
        //   }),
        // )
        //     : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.r),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hinttext,
        hintStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
