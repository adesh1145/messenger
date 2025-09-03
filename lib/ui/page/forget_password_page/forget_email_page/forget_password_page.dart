// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, no_logic_in_create_state

import '../../../page/forget_password_page/forget_email_page/forget_password_api_service.dart';
import '../../../widget/app_icon_top_part.dart';
import '../../../widget/colors.dart';
import '../../../widget/elevatedbutton.dart';
import '../../../widget/text.dart';
import '../../../widget/textformfield.dart';
import 'package:flutter/material.dart';

class ForgetPageUi extends StatefulWidget {
  const ForgetPageUi({
    super.key,
  });
  @override
  State<ForgetPageUi> createState() => _ForgetPageUi();
}

class _ForgetPageUi extends State<ForgetPageUi> {
  final GlobalKey _emailFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  String email = "";
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
                key: _emailFormKey,
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
                            )),
                            TextWidget(
                              text: "  Forget Password  ",
                              textcolor: Colors.grey,
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 1.3,
                              color: Colors.blueGrey,
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextWidget(
                            text: errorData(),
                            textcolor: Colors.red,
                          ),
                        )
                      ],
                    ),

                    // --------------Email OTP-------------
                    TextFieldWidget(
                      hint: "Enter Email",
                      label: Text("Email"),
                      prfixIcon: Icon(Icons.email_outlined),
                      borderRadius: 10,
                      borderColor: Colors.grey,
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email";
                        } else if (!value.contains('@')) {
                          return "Please Enter @ ";
                        }
                        return null;
                      },
                    ),
                    ElevatedButtonWidget(
                      text: "Next",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.06,
                      textcolor: Colors.white,
                      borderRadius: 15,
                      onpressed: () async {
                        email = "";
                        email = emailController.text;

                        if (email != "") {
                          setState(() {
                            responseStatus = false;
                          });
                          await fetchUser(context, email);
                          responseStatus = true;
                          setState(() {});
                        }
                      },
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
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
