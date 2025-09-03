import 'package:messenger/core/utils/typedef.dart';
import 'package:messenger/core/errors/exception_handler.dart';
import 'package:messenger/features/profile/data/mapper/user_mapper.dart';
import 'package:messenger/features/profile/data/source/remote/profile_remote_source.dart';
import 'package:messenger/features/profile/domain/entities/user.dart';
import 'package:messenger/features/profile/domain/repository/profile_repository.dart';

class ProfileRepoImpl implements ProfileRepository {
  final ProfileRemoteSource remoteSource;

  ProfileRepoImpl(this.remoteSource);

  @override
  ResultFutureT<User> getUser() {
    return exceptionHandler(
      () => remoteSource.getUser().then((value) => value.toEntity()),
    );
  }

  @override
  ResultFutureT<void> createUser(User user) {
    return exceptionHandler(() => remoteSource.createUser(user.toModel()));
  }

  @override
  ResultFutureT<void> updateUser(User user) {
    return exceptionHandler(() => remoteSource.updateUser(user.toModel()));
  }

  @override
  ResultFutureT<void> signOut() {
    return exceptionHandler(() => remoteSource.signOut());
  }
}
