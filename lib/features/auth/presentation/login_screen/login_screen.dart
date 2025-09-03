// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/core/theme/app_images.dart';
import 'package:messenger/core/widgets/custom_button.dart';
import 'package:messenger/core/widgets/custom_image_view.dart';
import 'package:messenger/core/widgets/custom_snack_bar.dart';
import 'package:messenger/features/auth/presentation/login_screen/login_controller.dart';

import '../../../../ui/page/forget_password_page/forget_email_page/forget_password_page.dart';
import '../../../../ui/widget/app_icon_top_part.dart';
import '../../../../ui/widget/colors.dart';
import '../../../../ui/widget/elevatedbutton.dart';
import '../../../../ui/widget/text.dart';
import '../../../../ui/widget/textformfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          TopPartOfScreen(),
          Positioned(
            top:
                MediaQuery.of(context).size.height * 0.33 -
                MediaQuery.of(context).viewInsets.bottom * 0.5,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.67,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                // color: Colors.white,
                gradient: AppColors.gradient1,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: " Welcome !",
                      fontsize: 30,
                      textcolor: Colors.black,
                      fontweight: FontWeight.bold,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.3,
                                color: Colors.blueGrey,
                              ),
                            ),
                            TextWidget(
                              text: "  Log in Email/Password  ",
                              textcolor: Colors.grey,
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.3,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 5),
                        //   child: TextWidget(
                        //     text: errorData(),
                        //     textcolor: Colors.red,
                        //     fontsize: 15,
                        //   ),
                        // ),
                      ],
                    ),

                    TextFieldWidget(
                      hint: "Enter Email",
                      label: Text("Email"),
                      prfixIcon: Icon(Icons.email_outlined),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email";
                        } else if (!value.contains('@')) {
                          return "Please Enter @ ";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      obscureText: true,
                      hint: "Enter Password",
                      label: Text("Password"),
                      prfixIcon: Icon(Icons.password_rounded),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.visiblePassword,
                      controller: controller.passwordController,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Password".toString();
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => CustomElevatedButton(
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            controller.login();
                          } else {
                            customSnackBar(
                              "Please fill all the fields",
                              type: SnackBarType.error,
                            );
                          }
                        },
                        text: "Log In",
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButtonWidget(
                          text: "Forget Password?",
                          fontsize: 17,
                          textcolor: AppColors.black,
                          onpressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPageUi(),
                              ),
                            );
                          },
                        ),
                        ElevatedButtonWidget(
                          text: "Register",
                          fontsize: 17,
                          textcolor: AppColors.black,
                          // fontweight: FontWeight.bold,
                          onpressed: () {
                            Get.offNamed(AppRoutes.registerScreen);
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.3,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              TextWidget(
                                text: "  Or LogIn/Register  ",
                                textcolor: Colors.grey,
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.3,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          CustomImageView(
                            svgPath: AppImages.googleIcon,

                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
