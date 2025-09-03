import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';

class GetProfileUsecase implements UseCaseWithoutParams<User> {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository);

  @override
  ResultFutureT<User> call() {
    return repository.getUser();
  }
}
