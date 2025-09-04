import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_controller.dart';
import 'package:messenger/features/chat/presentation/chat_screen/chat_controller.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../ui/widget/colors.dart';
import '../../../../ui/widget/text.dart';
import '../profile_screen.dart';

class ChatScreen extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  final ChatListController chatListController = Get.find<ChatListController>();
  final String chatId = Get.parameters['chatId']!;
  final String oppenantId = Get.arguments['oppenantId']!;
  final String? name = Get.arguments['name'];
  ChatScreen({super.key});

  final messageController = TextEditingController();
  final _listViewController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_listViewController.hasClients) {
        _listViewController.animateTo(
          _listViewController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(
        chatId: chatId,
        getMessagesusecase: Get.find(),
        sendMessegeUsecase: Get.find(),
      ),
      builder: (controller) {
        ever(controller.messages, (_) => _scrollToBottom());
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary70,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: GestureDetector(
              onTap: () =>
                  Get.toNamed(AppRoutes.profileScreen, arguments: oppenantId),
              child: TextWidget(
                text:
                    name ??
                    chatListController.chatsUsers[oppenantId]?.name ??
                    "",
                textcolor: Colors.white,
                fontweight: FontWeight.w500,
                fontsize: 20.sp,
              ),
            ),
            actions: [
              // GestureDetector(
              //   onTap: () {
              //     controller.acceptCall();
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.only(right: 10.w),
              //     child: Icon(Icons.call, color: Colors.white),
              //   ),
              // ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  controller.startCall();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Icon(Icons.video_call, color: Colors.white),
                ),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(gradient: gradientColor),
            child: Column(
              children: [
                // 🔹 Message list
                Expanded(
                  child: Obx(() {
                    final msgs = controller.messages;
                    if (msgs.isEmpty) {
                      return Center(
                        child: Text(
                          "No messages yet",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      controller: _listViewController,
                      itemCount: msgs.length,
                      itemBuilder: (context, index) {
                        final msg = msgs[index];
                        final isMe =
                            msg.senderId ==
                            controller.profileController.user.value.uid;

                        return Container(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            left: isMe ? 80.w : 10.w,
                            right: isMe ? 10.w : 80.w,
                          ),
                          alignment: isMe
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: isMe
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(14.r),
                                      bottomLeft: Radius.circular(14.r),
                                      topRight: Radius.circular(14.r),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(14.r),
                                      bottomLeft: Radius.circular(14.r),
                                      bottomRight: Radius.circular(14.r),
                                    ),
                              color: isMe ? Colors.blue[200] : Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.r,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 12.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  msg.content,
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                SizedBox(height: 4.h),
                                TextWidget(
                                  text: timeago.format(
                                    msg.createdAt!,
                                    locale: 'en_short',
                                  ),
                                  fontsize: 11.sp,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(height: 16.h),
                // 🔹 Input field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          // cursorHeight: 30.h,
                          textInputAction: TextInputAction.newline,
                          maxLines: 4,
                          minLines: 1,
                          style: TextStyle(fontSize: 13.sp),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.photo_camera, size: 22.r),
                            ),
                            hintText: "Type Message...",
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.r),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: blueColor7,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 22.r,
                          ),
                          onPressed: () {
                            final text = messageController.text.trim();
                            if (text.isNotEmpty) {
                              controller.sendMessage(text);
                              messageController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
