import 'package:e_commerce/Business%20Logics/Controllers/auth_controller.dart';
import 'package:e_commerce/Const/app_colors.dart';
import 'package:e_commerce/UI/Responsive/size_config.dart';
import 'package:e_commerce/UI/Route/route.dart';
import 'package:e_commerce/UI/Style/app_style.dart';
import 'package:e_commerce/UI/Widgets/custom_button.dart';
import 'package:e_commerce/UI/Widgets/custom_inkwell_button.dart';
import 'package:e_commerce/UI/Widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Registration extends StatelessWidget {
  Registration({super.key});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  RxBool _value = false.obs; //for checkbox

  final _formKey =
      GlobalKey<FormState>(); //formkey ta mainly validation er jonno use kora

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
                      'Sign Up',
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
                      TextInputType.text,
                      _nameController,
                      context,
                      'Name',
                      (val) {
                        //authentication logic
                        if (val.isEmpty) {
                          return 'this field can\'t be empty';
                        }
                      },
                      prefixIcon: Icons.person_outlined,
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
                          return 'enter a valid email address';
                        }
                      },
                      prefixIcon: Icons.email_outlined,
                    ),
                    customFormField(
                      TextInputType.text,
                      _passwordController,
                      context,
                      'Password',
                      (val) {
                        //authentication logic
                        if (val.isEmpty) {
                          return 'this field can\'t be empty';
                        }
                      },
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //checkbox
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                              value: _value.value,
                              //checkColor: AppColors.mandarinColor,
                              onChanged: (val) {
                                _value.value = val!;
                              }),
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "I accept all the",
                            style: TextStyle(color: AppColors.grayColor),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(termCon),
                            text: " Terms & Condition",
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: AppColors.fontW600),
                          ),
                        ])),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 200.w,
                      height: 45.h,
                      child: CustomButton(
                        'Sign Up',
                        () {
                          //for checking validate or not
                          if (_formKey.currentState!.validate() &&
                              _value.value == true) {
                            Get.find<AuthController>().signUp(
                                _nameController.text,
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                                context);
                            print("success");
                          } else {
                            Get.showSnackbar(AppStyles().customSnackBar(
                                'SignUp failed! Please try again!'));
                            print("failed");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        // customDivider.thickDivider,
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColors.black26Color,
                          ),
                        ),
                        Text('  OR  '),
                        // customDivider.thickDivider,
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColors.black26Color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomInkWellButton(
                          onTap: () {},
                          icon: Image.asset('assets/icons/facebook.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomInkWellButton(
                          onTap: () {},
                          icon: Image.asset('assets/icons/search.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomInkWellButton(
                          onTap: () {},
                          icon: Image.asset('assets/icons/apple.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "Already have an account?",
                        style: TextStyle(color: AppColors.grayColor),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(login),
                        text: " Log In",
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: AppColors.fontW600),
                      ),
                    ])),
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
