import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';

import '../../../profile/domain/entities/user.dart';

class SeachUserUsecase implements UseCaseWithParams<List<User>, String> {
  final ChatRepository chatRepository;
  SeachUserUsecase(this.chatRepository);
  @override
  ResultFutureT<List<User>> call(String params) {
    return chatRepository.searchUser(params);
  }
}
