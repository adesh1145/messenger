import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';

class LogoutUsecase implements UseCaseWithoutParams<void> {
  final ProfileRepository profileRepository;

  LogoutUsecase(this.profileRepository);

  @override
  ResultVoid call() {
    return profileRepository.signOut();
  }
}
