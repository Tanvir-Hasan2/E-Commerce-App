import 'package:e_commerce/Business%20Logics/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Responsive/size_config.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: SizeConfig.screenHeight,
              child: Form(
                //for validation
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/icons/logo.png',
                      width: 40.w,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Forget Password?',
                      // style: CustomTextStyle.bodyTextStyle,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    customFormField(
                      TextInputType.emailAddress,
                      _emailController,
                      context,
                      'Email',
                      (val) {
                        //authentication logic
                        if (val.isEmpty) {
                          return 'this field can\'t be empty';
                        }
                        if (!val.contains(RegExp(r'\@'))) {
                          return 'Enter a valid email address';
                        }
                      },
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 200.w,
                      height: 40.h,
                      child: CustomButton(
                        'Continue',
                        () {
                          //for checking validate or not
                          if (_formKey.currentState!.validate()) {
                            Get.find<AuthController>().forgetPassword(
                              _emailController.text.trim(),
                              context,
                            );
                            print("Successfully Sign in");
                          } else {
                            print("Log in failed!\nPlease try again.");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
