// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import '../../../page/forget_password_page/forget_otp_page/forget_otp_api_services.dart';
import '../../../widget/app_icon_top_part.dart';
import '../../../widget/colors.dart';
import '../../../widget/elevatedbutton.dart';
import '../../../widget/text.dart';
import '../../../widget/textformfield.dart';
import 'package:flutter/material.dart';

class ForgetOtpPage extends StatefulWidget {
  ForgetOtpPage({super.key, required this.email});
  String email;

  @override
  // ignore: no_logic_in_create_state
  State<ForgetOtpPage> createState() => _ForgetOtpPageState();
}

class _ForgetOtpPageState extends State<ForgetOtpPage> {
  final GlobalKey _forgetPasswordFormKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  String otp = "";

  String password = "";

  String confirmPassword = "";

  bool responseStatus = true;
  String errorData() {
    try {
      var s = responseData['error']['msg'][0].toString();

      return s;
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          TopPartOfScreen(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.33 -
                MediaQuery.of(context).viewInsets.bottom * 0.6,
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
                  gradient: gradientColor),
              child: Form(
                key: _forgetPasswordFormKey,
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
                            )),
                            TextWidget(
                              text: " OTP and Password ",
                              textcolor: Colors.grey,
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 1.3,
                              color: Colors.blueGrey,
                            )),
                          ],
                        ),
                        errorData() == ""
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  TextWidget(
                                    text: "OTP has been Sent ${widget.email}",
                                    textcolor: Colors.green,
                                  )
                                ],
                              )
                            : TextWidget(
                                text: "Invalid OTP",
                                textcolor: Colors.red,
                              ),
                      ],
                    ),
                    TextFieldWidget(
                      hint: "Enter Email OTP",
                      label: Text("Email OTP"),
                      prfixIcon: Icon(
                        Icons.pin,
                      ),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.number,
                      controller: otpController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter OTP".toString();
                        } else if (value.length < 4 || value.length > 4) {
                          return "Please Enter 4 Digit OTP";
                        }
                        return null;
                      },
                    ),
                    TextFieldWidget(
                      hint: "Enter Pasword",
                      label: Text("Pasword"),
                      obscureText: true,
                      prfixIcon: Icon(
                        Icons.password_outlined,
                      ),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController,
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
                      prfixIcon: Icon(
                        Icons.password_outlined,
                      ),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.visiblePassword,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password".toString();
                        } else if (value != passwordController.text) {
                          return "Password Doesn't Match";
                        }
                        return null;
                      },
                    ),
                    ElevatedButtonWidget(
                      text: "Submit",
                      borderRadius: 15,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      textcolor: Colors.white,
                      onpressed: () async {
                        otp = "";
                        password = "";
                        confirmPassword = "";

                        otp = otpController.text;
                        password = passwordController.text;
                        confirmPassword = confirmPasswordController.text;

                        if (otp != "" &&
                            password != "" &&
                            confirmPassword != "" &&
                            password == confirmPassword) {
                          setState(() {
                            responseStatus = false;
                          });

                          await fetchUser(context, widget.email, otp, password);
                          responseStatus = true;
                          setState(() {});
                        }
                      },
                    ),
                    ElevatedButtonWidget(
                      text: "Resend OTP",
                      fontsize: 15,
                      textcolor: blueColor7,
                      onpressed: () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (responseStatus == false)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: true, color: Colors.black),
            ),
          if (responseStatus == false)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
