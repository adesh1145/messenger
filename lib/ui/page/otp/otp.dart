// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, no_logic_in_create_state

import '../../page/otp/otp_api_services.dart';
import '../../widget/app_icon_top_part.dart';
import '../../widget/colors.dart';
import '../../widget/elevatedbutton.dart';
import '../../widget/text.dart';
import '../../widget/textformfield.dart';
import 'package:flutter/material.dart';

class OtpPageUi extends StatefulWidget {
  const OtpPageUi({super.key, required this.email, required this.password});
  final String password;
  final String email;
  @override
  State<OtpPageUi> createState() => _OtpPageUiState(email, password);
}

class _OtpPageUiState extends State<OtpPageUi> {
  _OtpPageUiState(this.email, this.password);
  final GlobalKey _otpFormKey = GlobalKey<FormState>();
  final passwordOtpController = TextEditingController();
  final emailOtpController = TextEditingController();

  String emailOtp = "";
  bool emailOtpValid = true;
  bool responseStatus = true;
  final String password;
  final String email;
  String errorData() {
    try {
      return responseData['error']['msg'][0].toString();
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
            top: MediaQuery.of(context).size.height * 0.33,
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
                key: _otpFormKey,
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
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.3,
                          color: Colors.blueGrey,
                        )),
                        TextWidget(
                          text: "  OTP  ",
                          textcolor: Colors.grey,
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1.3,
                          color: Colors.blueGrey,
                        )),
                      ],
                    ),

                    // --------------Email OTP-------------
                    errorData() == ""
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                              TextWidget(
                                text: "OTP has been Sent $email",
                                textcolor: Colors.green,
                              )
                            ],
                          )
                        : TextWidget(
                            text: "Invalid OTP",
                            textcolor: Colors.red,
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
                      controller: emailOtpController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter OTP".toString();
                        } else if (value.length < 4 || value.length > 4) {
                          return "Please Enter 4 Digit OTP";
                        }
                        return null;
                      },
                    ),
                    ElevatedButtonWidget(
                      text: "Submit",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      textcolor: Colors.white,
                      borderRadius: 15,
                      onpressed: () async {
                        emailOtp = "";
                        emailOtp = emailOtpController.text;

                        if (emailOtp.length == 4) {
                          setState(() {
                            responseStatus = false;
                          });
                          await fetchUser(context, email, password, emailOtp);
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
