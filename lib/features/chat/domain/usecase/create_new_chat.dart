import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/entities/chats_entity.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';

class CreateNewChatusecase implements UseCaseWithParams<ChatsEntity, String> {
  final ChatRepository chatRepository;
  CreateNewChatusecase(this.chatRepository);
  @override
  ResultFutureT<ChatsEntity> call(String params) {
    return chatRepository.createNewChat(params);
  }
}
