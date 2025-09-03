import 'package:messenger/features/chat/domain/entities/messege.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';

class GetMeesegeusecase {
  final ChatRepository chatRepository;
  GetMeesegeusecase(this.chatRepository);
  Stream<List<Message>> call(String chatId) {
    return chatRepository.getMesseges(chatId);
  }
}
