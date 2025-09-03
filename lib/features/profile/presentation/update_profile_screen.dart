// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/core/theme/app_images.dart';
import 'package:messenger/core/widgets/custom_button.dart';
import 'package:messenger/core/widgets/custom_image_view.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';

import '../../../ui/widget/colors.dart';
import '../../../ui/widget/elevatedbutton.dart';
import '../../../ui/widget/text.dart';
import '../../../ui/widget/textformfield.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfilePageUi();
}

class _UpdateProfilePageUi extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final descriptionController = TextEditingController();
  final arg = Get.arguments;
  @override
  void initState() {
    final controller = Get.find<ProfileController>();
    nameController.text = controller.user.value.name;
    descriptionController.text = controller.user.value.description;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: GetX<ProfileController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.06,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        height: 180.r,
                        width: 180.r,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            CustomImageView(imagePath: AppImages.clientImage),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 60.r,
                                width: 60.r,
                                padding: EdgeInsets.all(5.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppColors.gradient2,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // imageSelector();
                                  },
                                  icon: Icon(Icons.photo_camera),
                                  color: Colors.white,
                                  iconSize: 30.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.logout();
                        },
                        icon: Icon(Icons.logout, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      // color: Colors.white,
                      gradient: AppColors.gradient1,
                    ),
                    child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.3,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                TextWidget(
                                  text: "    Update Profile    ",
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              hint: "Email",
                              label: Text("Email"),
                              prfixIcon: Icon(Icons.email_rounded),
                              borderRadius: 10,
                              borderColor: Colors.grey,
                              textInputType: TextInputType.emailAddress,
                              controller: TextEditingController(
                                text: controller.user.value.email,
                              ),
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Name";
                                }
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              hint: "Enter Name",
                              label: Text("Name"),
                              prfixIcon: Icon(Icons.mode_edit_outline_outlined),
                              borderRadius: 10,
                              borderColor: Colors.grey,
                              textInputType: TextInputType.name,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Name";
                                }
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFieldWidget(
                              hint: "Descripton",
                              label: Text("Descripton"),
                              prfixIcon: Icon(Icons.description_outlined),
                              borderRadius: 10.r,
                              borderColor: Colors.grey,
                              textInputType: TextInputType.streetAddress,
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Descripton".toString();
                                }
                                return null;
                              },
                            ),
                          ),
                          Obx(() {
                            return CustomElevatedButton(
                              isLoading: controller.isLoading.value,
                              isExpanded: false,
                              text:
                                  arg != null &&
                                      (arg["isFromRegister"] ?? false) == true
                                  ? "Create Profile"
                                  : "Update",

                              borderRadius: BorderRadius.circular(15.r),

                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (arg != null &&
                                      (arg["isFromRegister"] ?? false) ==
                                          true) {
                                    controller.createProfile(
                                      nameController.text,
                                      descriptionController.text,
                                    );
                                  } else {
                                    controller.updateProfile(
                                      nameController.text,
                                      descriptionController.text,
                                    );
                                  }
                                }
                              },
                            );
                          }),
                          SizedBox(height: 300.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
