import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';

class CreateProfileUsecase implements UseCaseWithParams<void, User> {
  final ProfileRepository profileRepository;
  CreateProfileUsecase(this.profileRepository);
  @override
  ResultFutureT<void> call(User params) {
    return profileRepository.createUser(params);
  }
}
