import 'package:get/get.dart';
import 'package:messenger/core/theme/app_colors.dart';

import 'package:messenger/core/widgets/custom_button.dart';
import 'package:messenger/features/auth/presentation/register/registration_controller.dart';

import '../../../../ui/widget/app_icon_top_part.dart';
import '../../../../ui/widget/colors.dart';
import '../../../../ui/widget/elevatedbutton.dart';
import '../../../../ui/widget/text.dart';
import '../../../../ui/widget/textformfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends GetView<RegisterController> {
  RegisterScreen({super.key});

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
                MediaQuery.of(context).viewInsets.bottom * 0.75,
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
                gradient: AppColors.gradient1,
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              text: "  Register  ",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email".toString();
                        } else if (!value.contains('@')) {
                          return "Please Enter @ ";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hint: "Enter Pasword",
                      label: Text("Pasword"),
                      obscureText: true,
                      prfixIcon: Icon(Icons.password_outlined),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.visiblePassword,
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password".toString();
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hint: "Enter Confirm Pasword",
                      label: Text("Confirm Pasword"),
                      obscureText: true,
                      prfixIcon: Icon(Icons.password_outlined),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.visiblePassword,
                      controller: controller.confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password".toString();
                        } else if (value !=
                            controller.passwordController.text) {
                          return "Password Doesn't Match";
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => CustomElevatedButton(
                        isLoading: controller.isLoading.value,
                        text: "Register",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.register();
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButtonWidget(
                          text: "Log In",
                          fontsize: 15,
                          textcolor: AppColors.black,
                          onpressed: () {
                            Get.back();
                          },
                        ),
                      ],
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
