import 'package:get/get.dart';
import 'package:messenger/features/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:messenger/features/chat/data/repo_impl/call_repo_impl.dart';
import 'package:messenger/features/chat/data/sources/remote/chat_remote_source.dart';
import 'package:messenger/features/chat/data/sources/remote/meeting_service.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';
import 'package:messenger/features/chat/domain/usecase/create_new_chat.dart';
import 'package:messenger/features/chat/domain/usecase/get_chats.dart';
import 'package:messenger/features/chat/domain/usecase/get_meesege.dart';
import 'package:messenger/features/chat/domain/usecase/get_user.dart';
import 'package:messenger/features/chat/domain/usecase/send_messege_usecase.dart';

import 'domain/repository/call_repository.dart';
import 'domain/usecase/seach_user_usecase.dart';

class ChatBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRemoteSource());
    Get.lazyPut(() => CallDataSource());
    Get.lazyPut<ChatRepository>(
      () => ChatRepoImpl(Get.find<ChatRemoteSource>()),
      fenix: true,
    );
    Get.lazyPut<CallRepository>(
      () => CallRepoImpl(Get.find<CallDataSource>()),
      fenix: true,
    );
    Get.lazyPut<CallRepository>(
      () => CallRepoImpl(Get.find<CallDataSource>()),
      fenix: true,
    );
    Get.lazyPut(() => SeachUserUsecase(Get.find()));
    Get.lazyPut(() => GetChats(Get.find()));
    Get.lazyPut(() => CreateNewChatusecase(Get.find()));
    Get.lazyPut(() => GetUserUsecase(Get.find()));
    Get.lazyPut(() => SendMessegeUsecase(Get.find()));
    Get.lazyPut(() => GetMeesegeusecase(Get.find()));
  }
}
