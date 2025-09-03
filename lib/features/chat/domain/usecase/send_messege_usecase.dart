import 'package:dartz/dartz.dart';
import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/chat/domain/entities/messege.dart';
import 'package:messenger/features/chat/domain/repository/chat_repository.dart';

class SendMessegeUsecase implements UseCaseWithParams<void, SendMessegeParams> {
  final ChatRepository chatRepository;
  SendMessegeUsecase(this.chatRepository);
  @override
  ResultVoid call(SendMessegeParams params) async {
    await chatRepository.sendMessege(params.chatId, params.messege);
    return Right(null);
  }
}

class SendMessegeParams {
  final String chatId;
  final Message messege;

  SendMessegeParams({required this.chatId, required this.messege});
}
