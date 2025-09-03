import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/chat/domain/entities/messege.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';

abstract class ChatRepository {
  ResultFutureT<List<User>> searchUser(String query);
  ResultFutureT<User> getUser(String uuid);
  ResultFutureT<ChatsEntity> createNewChat(String userId);
  ResultVoid sendMessege(String chatId, Message messege);
  ResultVoid deleteMessege(String chatId, String messegeId);
  ResultVoid deleteChat(String chatId);

  // Stream
  Stream<List<Message>> getMesseges(String chatId);
  Stream<List<ChatsEntity>> getChats();
}
