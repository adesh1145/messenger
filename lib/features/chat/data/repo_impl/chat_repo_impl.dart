import 'package:messenger/core/errors/exception_handler.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/data/mapper/chat_mapper.dart';
import 'package:messenger/features/chat/data/mapper/message_mapper.dart';
import 'package:messenger/features/chat/data/sources/remote/chat_remote_source.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/chat/domain/entities/messege.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';
import 'package:messenger/features/profile/data/mapper/user_mapper.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';

class ChatRepoImpl implements ChatRepository {
  final ChatRemoteSource chatRemoteSource;
  ChatRepoImpl(this.chatRemoteSource);

  @override
  ResultFutureT<ChatsEntity> createNewChat(String userId) async {
    return exceptionHandler<ChatsEntity>(
      () =>
          chatRemoteSource.createChat(userId).then((value) => value.toEntity()),
    );
  }

  @override
  ResultVoid deleteChat(String chatId) {
    // TODO: implement deleteChat
    throw UnimplementedError();
  }

  @override
  ResultFutureT<List<User>> searchUser(String query) {
    return exceptionHandler(
      () => chatRemoteSource
          .searchUser(query)
          .then((value) => value.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  ResultFutureT<User> getUser(String uuid) {
    return exceptionHandler(
      () => chatRemoteSource.getUser(uuid).then((value) => value.toEntity()),
    );
  }

  @override
  ResultVoid sendMessege(String chatId, Message messege) {
    return exceptionHandler(
      () => chatRemoteSource.sendMessage(chatId, messege.toModel()),
    );
  }

  @override
  ResultVoid deleteMessege(String chatId, String messegeId) {
    return exceptionHandler(
      () => chatRemoteSource.deleteMessage(chatId, messegeId),
    );
  }

  @override
  Stream<List<Message>> getMesseges(String chatId) {
    return chatRemoteSource
        .getMessages(chatId)
        .map((value) => value.map((e) => e.toEntity()).toList());
  }

  @override
  Stream<List<ChatsEntity>> getChats() {
    return chatRemoteSource.getChats().map(
      (value) => value.map((e) => e.toEntity()).toList(),
    );
  }
}
