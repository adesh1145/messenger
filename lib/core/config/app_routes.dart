import 'package:get/get.dart';
import 'package:messenger/features/auth/auth_binding.dart';
import 'package:messenger/features/auth/presentation/login_screen/login_binding.dart';
import 'package:messenger/features/auth/presentation/register/register_binding.dart';
import 'package:messenger/features/auth/presentation/register/register_screen.dart';
import 'package:messenger/features/chat/chat_bindings.dart';
import 'package:messenger/features/chat/presentation/call_screen/call_binding.dart';
import 'package:messenger/features/chat/presentation/call_screen/call_screen.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_binding.dart';
import 'package:messenger/features/chat/presentation/chat_list_screen/chat_list_screen.dart';
import 'package:messenger/features/chat/presentation/chat_screen/chat_screen.dart';
import 'package:messenger/features/chat/presentation/profile_screen.dart';
import 'package:messenger/features/profile/profile_binding.dart';
import 'package:messenger/features/welcome/splash_binding.dart';
import 'package:messenger/features/welcome/splash_screen.dart';
import 'package:messenger/features/auth/presentation/login_screen/login_screen.dart';
import 'package:messenger/features/profile/presentation/update_profile_screen.dart';

import '../../features/chat/presentation/chat_screen/chat_screen_binding.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String loginScreen = "/logIn";
  static const String registerScreen = "/register";
  static const String profileScreen = "/profile";
  static const String updateProfileScreen = "/updateProfile";

  static const String chatListScreen = "/chatList";
  static const String chatScreen = "/chat";
  static const String callScreen = "/call";

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
      bindings: [AuthBinding()],
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      bindings: [AuthBinding()],
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: updateProfileScreen,
      page: () => UpdateProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: chatListScreen,
      page: () => ChatListScreen(),
      binding: ChatListBinding(),
      bindings: [ChatBindings()],
    ),
    GetPage(
      name: chatScreen,
      page: () => ChatScreen(),
      binding: ChatScreenBinding(),
      bindings: [ChatBindings()],
    ),
    GetPage(
      name: profileScreen,
      page: () => ProfileScreen(),
      // binding: ChatScreenBinding(),
      // bindings: [ChatBindings()],
    ),
    GetPage(
      name: callScreen,
      page: () => CallScreen(),
      binding: CallBinding(),
      // bindings: [ChatBindings()],
    ),
  ];
}
