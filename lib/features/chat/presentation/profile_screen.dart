// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_controller.dart';

import 'package:messenger/features/profile/presentation/profile_controller.dart';

import '../../../ui/widget/text.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});
  final String userId = Get.arguments;
  final ChatListController chatListController = Get.find<ChatListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: AppColors.primary70,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15),
              child: SafeArea(
                child: Row(
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
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/client.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert_outlined, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.33,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.67,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
                gradient: AppColors.gradient1,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          TextWidget(
                            text:
                                "${chatListController.chatsUsers[userId]?.name}",
                            fontsize: 20.sp,
                            textcolor: Colors.black,
                          ),
                          TextWidget(
                            text:
                                chatListController.chatsUsers[userId]?.email ??
                                "",
                            fontsize: 20,
                            textcolor: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      color: Colors.white38,
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: TextWidget(
                        text: controller.user.value.description,
                        fontsize: 15,
                        textcolor: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white38,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.block_outlined,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                TextWidget(
                                  text:
                                      "Block ${chatListController.chatsUsers[userId]?.name}",
                                  textcolor: Colors.red,
                                  fontsize: 20,
                                  fontweight: FontWeight.w400,
                                ),
                                TextWidget(text: "              "),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.thumb_down_alt_rounded,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                TextWidget(
                                  text:
                                      "Report ${chatListController.chatsUsers[userId]?.name}",
                                  textcolor: Colors.red,
                                  fontsize: 20,
                                  fontweight: FontWeight.w400,
                                ),
                                TextWidget(text: "              "),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
