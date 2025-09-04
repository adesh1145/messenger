// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messenger/core/config/app_routes.dart';
import 'package:messenger/core/theme/app_colors.dart';
import 'package:messenger/core/widgets/custom_loader.dart';
import 'package:messenger/core/widgets/custom_snack_bar.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_controller.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/presentation/profile_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../ui/widget/text.dart';
import '../../../../ui/page/contact_list/contact_list_page.dart';
import '../../../profile/presentation/update_profile_screen.dart';
import '../chat_screen/chat_screen.dart';

import 'package:flutter/material.dart';

class ChatListScreen extends GetView<ChatListController> {
  ChatListScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.primary,
            centerTitle: true,
            floating: true,
            pinned: true,
            title: _buildHeader(context),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          Obx(
            () => controller.searchBarStatus.value
                ? controller.searchLoading.value
                      ? SliverToBoxAdapter(child: CircularLoader())
                      : SliverList.builder(
                          itemBuilder: (context, index) {
                            User user = controller.searchedUsers[index];
                            return searchUser(context, user);
                          },
                          itemCount: controller.searchedUsers.length,
                        )
                : StreamBuilder<List<ChatsEntity>>(
                    stream: controller.getChatsList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return (snapshot.data?.length ?? 0) == 0
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: TextWidget(text: "No Chats"),
                                ),
                              )
                            : SliverList.builder(
                                itemBuilder: (context, index) {
                                  ChatsEntity chat = snapshot.data![index];
                                  return chatList(
                                    context,
                                    chat,
                                    profileController.user.value,
                                  );
                                },
                                itemCount: snapshot.data?.length ?? 0,
                              );
                      } else if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return SliverToBoxAdapter(
                          child: TextWidget(text: "Error"),
                        );
                      } else {
                        return SliverToBoxAdapter(child: CircularLoader());
                      }
                    },
                  ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactListPageUi()),
          );
        },
        child: Icon(Icons.speaker_notes),
      ),
    );
  }

  /// 🔹 Header - toggles between Title & SearchBar
  Widget _buildHeader(BuildContext context) {
    return Obx(() {
      if (controller.searchBarStatus.value) {
        return Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: controller.searchTextController,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search chats...",
              prefixIcon: Icon(Icons.search, color: AppColors.black),
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: AppColors.black),
                onPressed: () {
                  controller.searchTextController.clear();
                  controller.searchedUsers.clear();
                  controller.searchBarStatus.value = false;
                },
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                controller.searchBarStatus.value = false;
                controller.searchedUsers.clear();
              } else {
                controller.searchBarStatus.value = true;
                controller.searchChat(value);
              }
            },
          ),
        );
      } else {
        // 👤 Normal Mode
        return Row(
          children: [
            Expanded(
              flex: 4,
              child: TextWidget(
                text: profileController.user.value.name,
                fontweight: FontWeight.w900,
                fontsize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.search, color: AppColors.black),
              ),
              onPressed: () {
                controller.searchBarStatus.value = true;
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfileScreen(),
                  ),
                );
              },
              icon: CircleAvatar(
                backgroundImage: AssetImage('assets/images/client.png'),
              ),
            ),
          ],
        );
      }
    });
  }

  Widget searchUser(BuildContext context, User user) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/client.png'),
      ),
      title: TextWidget(text: user.name, fontweight: FontWeight.w500),

      trailing: controller.createChatLoading.value
          ? CircularProgressIndicator()
          : TextButton(
              onPressed: () {
                controller.createChat(user.uid, user.name);
              },
              child: TextWidget(text: "Chat", textcolor: AppColors.primary),
            ),
    );
  }

  Widget chatList(BuildContext context, ChatsEntity chat, User myUser) {
    String userId = chat.participants.firstWhere((user) => user != myUser.uid);
    !controller.chatsUsers.containsKey(userId)
        ? controller.getUserDetail(userId)
        : null;
    return Obx(
      () => Visibility(
        visible: controller.chatsUsers.containsKey(userId),
        child: ListTile(
          onTap: () {
            Get.toNamed(
              AppRoutes.chatScreen,
              parameters: {"chatId": chat.id},
              arguments: {"oppenantId": userId},
            );
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/client.png'),
          ),
          title: TextWidget(
            text: controller.chatsUsers[userId]?.name ?? "",
            fontweight: FontWeight.w500,
          ),
          subtitle: TextWidget(text: chat.lastMessage ?? ""),
          trailing: chat.lastMessage == null
              ? TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: "New Chat",
                    textcolor: AppColors.primary,
                  ),
                )
              : TextWidget(
                  text: timeago.format(chat.updatedAt!, locale: 'en_short'),
                ),
        ),
      ),
    );
  }
}
