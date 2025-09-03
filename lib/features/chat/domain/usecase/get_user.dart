import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';

class GetUserUsecase implements UseCaseWithParams<User, String> {
  final ChatRepository chatRepository;
  GetUserUsecase(this.chatRepository);
  @override
  ResultFutureT<User> call(String uuid) {
    return chatRepository.getUser(uuid);
  }
}
