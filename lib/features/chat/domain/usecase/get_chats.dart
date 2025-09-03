import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';

class GetChats {
  final ChatRepository chatRepository;
  GetChats(this.chatRepository);
  Stream<List<ChatsEntity>> call() {
    return chatRepository.getChats();
  }
}
