import 'package:messenger/core/usecases/usecase.dart';
import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';

class UpdateProfileUsecase implements UseCaseWithParams<void, User> {
  final ProfileRepository _repository;

  UpdateProfileUsecase(this._repository);

  @override
  ResultVoid call(User params) async {
    return _repository.updateUser(params);
  }
}
